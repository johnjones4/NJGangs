//
//  CountyTableViewController.m
//  NJ Gangs
//
//  Created by John Jones on 10/7/10.
//

#import "CountyTableViewController.h"
#import "MunicipalityTableViewController.h"
#import "RegionFinder.h"
#import "County.h"
#import "Municipality.h"
#import "MunicipalitiesWithGangsTableViewController.h"
#import "ProfileViewController.h"
#import "ProfilableMunicipality.h"

@implementation CountyTableViewController

// The fetch object is "County"
- (NSString*)fetchObject {
	return @"County";
}

// Sort by County.Name
- (NSString*)sortObject {
	return @"Name";
}

// There are no sections
- (NSString*)sectionObject {
	return nil;
}

// There is no predicate
- (NSPredicate*)predicate {
	return nil;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	UIBarButtonItem *findMeButton = [[UIBarButtonItem alloc] initWithTitle:@"Find Me" style:UIBarButtonItemStyleBordered target:self action:@selector(findMe)];
	self.navigationItem.rightBarButtonItem = findMeButton;
	[findMeButton release];
}

// Return the standard value + 1.  This is to support the "All Counties" button.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [super tableView:tableView numberOfRowsInSection:section] + 1;
}

// Configure the cell.  If the row == 0, simply label it "All Counties"
// Otherwise, label the cell with the county name
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 0) {
		cell.textLabel.text = @"All Counties";
	} else {
		NSIndexPath* path1 = [NSIndexPath indexPathForRow:indexPath.row-1 inSection:indexPath.section];
		NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:path1];
		cell.textLabel.text = [[managedObject valueForKey:@"Name"] description];
	}
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

// Push a list of municipalities for a give county
- (void)pushCounty:(County*)county {
	MunicipalityTableViewController* controller = [[MunicipalityTableViewController alloc] initWithManagedObjectContext:self.managedObjectContext andCounty:county];
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];
}

// If a cell is tapped, push a MunicipalityTableViewController object view.  
// If row 0 was tapped, leave the county object set to nil in the new object view.  Otherwise, set the county object to the appropriate value
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSManagedObject *managedObject = nil;
	if (indexPath.row > 0) {
		NSIndexPath* path1 = [NSIndexPath indexPathForRow:indexPath.row-1 inSection:indexPath.section];
		managedObject = [self.fetchedResultsController objectAtIndexPath:path1];
	}
	[self pushCounty:(County*)managedObject];
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	[managedObject release];
}

// Called by the "Find Me" button in the UI
- (void)findMe {
	step1sheet = [[UIActionSheet alloc] initWithTitle:@"Locate your county or municipality?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"County",@"Municipality",nil];
	[step1sheet showFromTabBar:self.tabBarController.tabBar];
}

- (void)foundMunicip:(Municipality*)municip {
	if (municip == nil) {
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Municipality Not Found" message:@"We could not determine your municipality. Your location services may not be working properly or you are in a region that is not documented in this App." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	} else {
		foundMunicip = municip;
		NSString* title = [NSString stringWithFormat:@"You're in: %@",municip.Name];
		step2sheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"View Profile",@"View Gangs",nil];
		[step2sheet showFromTabBar:self.tabBarController.tabBar];
	}
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (step1sheet && actionSheet == step1sheet) {
		RegionFinder *finder = [[RegionFinder alloc] initWithManagedObjectContext:self.managedObjectContext];
		if (buttonIndex == 0) {
			[finder pushCurrentCountyOn:self action:@selector(pushCounty:)];
		} else if (buttonIndex == 1) {
			[finder pushCurrentMunicipalityOn:self action:@selector(foundMunicip:)];
		}
		//[finder release];
		[step1sheet release];
		step1sheet = nil;
	} else if (step2sheet && actionSheet == step2sheet) {
		if (buttonIndex == 0) {
			ProfileViewController* profile = [[ProfileViewController alloc] initWithProfileObject: foundMunicip];
			[self.navigationController pushViewController:profile animated:YES];
		} else if (buttonIndex == 1) {
			MunicipalitiesWithGangsTableViewController *controller = [[MunicipalitiesWithGangsTableViewController alloc] initWithMunicipality:foundMunicip];
			[self.navigationController pushViewController:controller animated:YES];
		}
		[step2sheet release];
		step2sheet = nil;
	}
}

@end
