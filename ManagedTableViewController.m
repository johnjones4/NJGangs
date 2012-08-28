//
//  ManagedTableViewController.m
//
//  Created by John Jones on 8/24/10.
//

#import "ManagedTableViewController.h"
#import "NJGangsColors.h"

@implementation ManagedTableViewController

@synthesize fetchedResultsController, managedObjectContext;

#pragma mark -
#pragma mark Object control

// See header for details
- (id)initWithManagedObjectContext:(NSManagedObjectContext*)context {
	if (self = [super initWithStyle:UITableViewStylePlain]) {
		self.managedObjectContext = context;
	}
	return self;
}

// If the memory is overloaded, there is not much we can dump here
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// Desconstruct and release the fetched results controller and the managed object controller
- (void)dealloc {
    [fetchedResultsController release];
    [managedObjectContext release];
    [super dealloc];
}

// See header for details
- (BOOL)direction {
	return YES;
}

#pragma mark -
#pragma mark View lifecycle

// Called when the view is loaded.  Do the following:
//   1. Perform the initial data fetch
//   2. Set the navigation bar color
//   3. Get rid of the table cell separator
//   4. Set the background color
- (void)viewDidLoad {
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
	NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
	self.navigationController.navigationBar.tintColor = [NJGangsColors navigationBarColor];
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	self.view.backgroundColor = [NJGangsColors standardBackgroundColor];
}

// When rotated, only support portrait modes
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait) || (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
#pragma mark Table view data source

// Return the value from the fetched results controller
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[fetchedResultsController sections] count];
}

// Return the value from the fetched results controller
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [[[fetchedResultsController sections] objectAtIndex:section] name];
}

// Return the value from the fetched results controller
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

// Called in order to customize the cell colors.  This sets:
//   1. The background color.  Even rows are different colors than odd rows
//   2. The text color
//   3. The selected background color
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row % 2) {
		cell.backgroundColor = [NJGangsColors cellColorOdd];
	} else {
		cell.backgroundColor = [NJGangsColors cellColorEven];
	}
	cell.textLabel.textColor = [NJGangsColors cellTextColor];
	
	UIView* selectedView = [[UIView alloc] initWithFrame: cell.backgroundView.frame];
	selectedView.backgroundColor = [NJGangsColors cellSeclectedColor];
	cell.selectedBackgroundView = selectedView;
}

// Construct or fetch from cache a cell for a given index path
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	[self configureCell:cell atIndexPath:indexPath];
    return cell;
}


// Returns no.  This data is read only
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

// Returns no.  This data is read only
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

#pragma mark -
#pragma mark Custom interface methods

// Construct a UIView for a section header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	if ([self numberOfSectionsInTableView:tableView] > 1) {
		UILabel *view = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 22)] autorelease];
		[view setBackgroundColor: [NJGangsColors sectionHeaderColor]];
		[view setTextColor: [NJGangsColors sectionHeaderTextColor]];
		[view setText: [NSString stringWithFormat:@" %@",[self tableView:tableView titleForHeaderInSection:section]]];
		return view;
	} else {
		return nil;
	}
}

// Construct a UIView for custum disclosure button.  The UIView is actually a UIButton.
- (UIView*)getCustomDisclosureButton {
	UIImage *image = [UIImage imageNamed:@"disclose.png"];
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	CGRect frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
	button.frame = frame;
	[button setBackgroundImage:image forState:UIControlStateNormal];	
	[button addTarget:self action:@selector(customDisclosureTapped:event:)  forControlEvents:UIControlEventTouchUpInside];
	button.backgroundColor = [UIColor clearColor];
	return button;
}

// Called when the custom disclosure button is tapped.  It then will call [self tableView: accessoryButtonTappedForRowWithIndexPath:]
- (void)customDisclosureTapped:(id)sender event:(id)event {
	NSSet *touches = [event allTouches];
	UITouch *touch = [touches anyObject];
	CGPoint currentTouchPosition = [touch locationInView:self.tableView];
	NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
	if (indexPath != nil)
	{
		[self tableView: self.tableView accessoryButtonTappedForRowWithIndexPath: indexPath];
	}
}

#pragma mark -
#pragma mark Fetched results controller

// Get or consturct a fetched results controller to broker data from the database
- (NSFetchedResultsController *)fetchedResultsController {
    
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    /*
     Set up the fetched results controller.
     */
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:[self fetchObject] inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[self sortObject] ascending: [self direction]];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
	
	NSPredicate* predicate = [self predicate];
	if (predicate != nil) {
		[fetchRequest setPredicate:predicate];
	}
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
	[NSFetchedResultsController deleteCacheWithName:[self fetchObject]];
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:[self sectionObject] cacheName:[self fetchObject]];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    [aFetchedResultsController release];
    [fetchRequest release];
    [sortDescriptor release];
    [sortDescriptors release];
    
    return fetchedResultsController;
}    

@end

