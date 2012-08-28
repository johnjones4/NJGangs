    //
//  ProfileViewController.m
//  NJ Gangs
//
//  Created by John Jones on 12/20/10.
//  Copyright 2010 Phoenix4. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileItem.h"
#import "NJGangsColors.h"
#import "ProfileCellView.h"
#import "ProfileMap.h"
#import "ProfileHTMLConverter.h"

@implementation ProfileViewController

// See header
-(id)initWithProfileObject:(id<Profilable>)_profObject {
	if (self = [super initWithStyle:UITableViewStyleGrouped]) {
		profObject = _profObject;
		[profObject precomputeValues];
	}
	return self;
}

#pragma mark -
#pragma mark View lifecycle

// Called when the interface has been setup.  Additional setup happens here
- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [NJGangsColors standardBackgroundColor];
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	self.navigationItem.title = [profObject profileName];
	//self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Map" style:UIBarButtonItemStylePlain target:self action:@selector(showMap)];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(emailProfile)];
}

// Called by a user to email the current profile
- (void)emailProfile {
	ProfileHTMLConverter* converter = [[ProfileHTMLConverter alloc] initWithProfile:profObject];
	MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
	controller.mailComposeDelegate = self;
	[controller setSubject:converter.subjectLine];
	[controller setMessageBody:converter.messageBody isHTML:YES]; 
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
	[self presentModalViewController:controller animated:YES];
	[controller release];
}

// Called by the mailer class when complete
- (void)mailComposeController:(MFMailComposeViewController*)controller  
          didFinishWithResult:(MFMailComposeResult)result 
                        error:(NSError*)error;
{
	if (result == MFMailComposeResultSent) {
		NSLog(@"It's away!");
	}
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:YES];
	[self dismissModalViewControllerAnimated:YES];
}

// Not used right now, but this is here if we want to show a map
- (void)showMap {
	ProfileMap* mapViewController = [[ProfileMap alloc] initWithNibName:@"ProfileMap" bundle:nil andProfile:profObject];
	mapViewController.mapdelegate = self;
	UINavigationController* controller = [[UINavigationController alloc] initWithRootViewController:mapViewController];
	[self presentModalViewController:controller animated:YES];
}

// From the map delegate protocol
- (void)closeMap {
	[self dismissModalViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark Table view data source

// All of these methods delegate control to the Profilable object


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [profObject numProfileSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [profObject numProfileItemsInSection:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [profObject titleForSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self tableView:tableView titleForHeaderInSection:section] != nil) {
        return SECTION_HEADER_HEIGHT;
    }
    else {
        // If no section header title, no section header needed
        return 0;
    }
}

// Custom header view implementation
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
	
    // Create label with section title
    UILabel *label = [[[UILabel alloc] init] autorelease];
    label.frame = CGRectMake(20, 6, self.view.frame.size.width - 20, 30);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [NJGangsColors cellTextColor];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.text = sectionTitle;
	
    // Create header view and add label as a subview
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SECTION_HEADER_HEIGHT)];
    [view autorelease];
    [view addSubview:label];
	
    return view;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	ProfileCellView *cell = [[[ProfileCellView alloc] initWithNibName:@"ProfileCellView" bundle:nil] autorelease];
    ProfileItem* item = [profObject itemAtIndexSection:indexPath.section andIndex:indexPath.row];
	CGFloat height = [item heightForSize:[ProfileCellView createDefaultRect].size];
	[cell adaptToHeight:height];
	cell.label.text = item.label;
	[cell.cellview addSubview:item.view];
    return (UITableViewCell*)cell.view;
}

// Nothing is editable!
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

// Nothing is movable
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}

@end
