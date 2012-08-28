//
//  MunicipalityTableViewController.m
//  NJ Gangs
//
//  Created by John Jones on 10/7/10.
//

#import "MunicipalityTableViewController.h"
#import "MunicipalitiesWithGangsTableViewController.h"
#import "ProfileViewController.h"
#import "Municipality.h"
#import "ProfilableMunicipality.h"

@implementation MunicipalityTableViewController

@synthesize object;

// See header
- (id)initWithManagedObjectContext:(NSManagedObjectContext*)context andCounty:(NSManagedObject*)iobject {
	if (self = [super initWithManagedObjectContext:context]) {
		self.object = iobject;
	}
	return self;
}

// When the view loads, set the navigation title to the county name or "All Counties" if the county object is nil
- (void)viewDidLoad {
    [super viewDidLoad];
	if (self.object != nil)
		self.navigationItem.title = [NSString stringWithFormat:@"%@ County",[[object valueForKey:@"Name"] description]];
	else
		self.navigationItem.title = @"All Counties";
}

// The fetch object is "Municipality"
- (NSString*)fetchObject {
	return @"Municipality";
}

// Alpha sort by Municipality.Name
- (NSString*)alphabeticalSortObject {
	return @"Name";
}

// Num sort by num gangs
- (NSString*)numericalSortObject {
	return @"NumGangs";
}

// There is no alpha section
- (NSString*)alphabeticalSection {
	return nil;
}

// There is no num section
- (NSString*)numericalSection {
	return nil;
}

// If the county object is set, the predicate stipulates that Municipality.County must equal the County object
- (NSPredicate*)predicate {
	if (self.object != nil)
		return [NSPredicate predicateWithFormat:@"County=%@",self.object];
	else
		return nil;
}

// Override the cell builder to create a cell that is of style "UITableViewCellStyleSubtitle"
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"MunicCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	[self configureCell:cell atIndexPath:indexPath];
    return cell;
}

// Configure the cell.
// Set the label to the municipality name
// If the municip has one active gang, the subhead is "1 Active Gang"
// If the municip has X mulitiple active gangs, the subhead is "X Active Gangs"
// Else the municip has no active gangs, then the subhead is "Detailed Gang Activity Unavailable"
// Also set the disclosure button to the custom disclosure button available in ManagedTableViewController
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [[managedObject valueForKey:@"Name"] description];
	if ([[managedObject valueForKey:@"Gangs"] count] == 1) {
		cell.detailTextLabel.text = @"1 Active Gang";
		cell.textLabel.textColor = [UIColor blackColor];
	} else if ([[managedObject valueForKey:@"Gangs"] count] > 0) {
		cell.detailTextLabel.text = [NSString stringWithFormat:@"%i Active Gangs",[[managedObject valueForKey:@"Gangs"] count]];
		cell.textLabel.textColor = [UIColor blackColor];
	} else {
		cell.detailTextLabel.text = [NSString stringWithFormat:@"Detailed Gang Activity Unavailable",[[managedObject valueForKey:@"Gangs"] count]];
		cell.textLabel.textColor = [UIColor grayColor];
	}
	cell.accessoryView = [self getCustomDisclosureButton];
}

// If the disclosure button is tapped, push a MunicipalityProfileViewController
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
	NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	ProfileViewController* profile = [[ProfileViewController alloc] initWithProfileObject: (Municipality*)managedObject];
	[self.navigationController pushViewController:profile animated:YES];
}

// If a row is selected and the municip in that row has active gangs, return the indexpath or nil otherwise
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	if ([[managedObject valueForKey:@"Gangs"] count] > 0) 
		return indexPath;
	else 
		return nil;
}

// If a row was selected and the municip in that row has active gangs, then push a MunicipalitiesWithGangsTableViewController
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	if ([[managedObject valueForKey:@"Gangs"] count] > 0) {
		MunicipalitiesWithGangsTableViewController *controller = [[MunicipalitiesWithGangsTableViewController alloc] initWithMunicipality:managedObject];
		[self.navigationController pushViewController:controller animated:YES];
	}
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
