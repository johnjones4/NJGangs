//
//  GangTableViewController.m
//  NJ Gangs
//
//  Created by John Jones on 10/8/10.
//

#import "GangsWithMunicipalitiesTableViewController.h"
#import "ProfileViewController.h"
#import "Municipality.h"
#import "ProfilableMunicipality.h"
#import "ProfileableGang.h"

@implementation GangsWithMunicipalitiesTableViewController

// See header
- (id)initWithGang:(NSManagedObject*)iobject {
	if (self = [super initWithManagedObjectContext:iobject.managedObjectContext]) {
		gangsObject = iobject;
	}
	return self;
}

- (void)showMap {
	ProfileMap* mapViewController = [[ProfileMap alloc] initWithNibName:@"ProfileMap" bundle:nil andProfile:(Gang*)gangsObject];
	mapViewController.mapdelegate = self;
	UINavigationController* controller = [[UINavigationController alloc] initWithRootViewController:mapViewController];
	[self presentModalViewController:controller animated:YES];
}

- (void)closeMap {
	[self dismissModalViewControllerAnimated:YES];
}

// When the view loads, set the navigation title to the gang name
- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = [[gangsObject valueForKey:@"Name"] description];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Map" style:UIBarButtonItemStylePlain target:self action:@selector(showMap)];
}

// The fetch object is "Municipality"
- (NSString*)fetchObject {
	return @"Municipality";
}

// Sort by Municipality.Name
- (NSString*)sortObject {
	return @"Name";
}

// There is no section
- (NSString*)sectionObject {
	return nil;
}

// The predicate specifies that a Gang within the Municipality.Gangs must be equal to the Gang object
- (NSPredicate*)predicate {
	NSPredicate *pred = [NSPredicate predicateWithFormat:@"ANY Gangs==%@",gangsObject];
	return pred;
}

// Configure the cell by setting the name to the associated municip's name and set the accessory to an arrow
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [[managedObject valueForKey:@"Name"] description];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

// If the cell is tapped, push a MunicipalityProfileViewController object
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	ProfileViewController* profile = [[ProfileViewController alloc] initWithProfileObject: (Municipality*)managedObject];
	[self.navigationController pushViewController:profile animated:YES];
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
