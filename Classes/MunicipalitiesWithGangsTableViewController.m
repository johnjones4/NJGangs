//
//  MunicipalitiesWithGangsTableViewController.m
//  NJ Gangs
//
//  Created by John Jones on 10/18/10.
//

#import "MunicipalitiesWithGangsTableViewController.h"
#import "Municipality.h"
#import "ProfilableMunicipality.h"
#import "ProfileViewController.h"
#import "ProfileableGang.h"

@implementation MunicipalitiesWithGangsTableViewController

- (id)initWithMunicipality:(NSManagedObject*)iobject {
	if (self = [super initWithManagedObjectContext:iobject.managedObjectContext]) {
		municipality = iobject;
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = [[municipality valueForKey:@"Name"] description];
}

- (NSString*)fetchObject {
	return @"Gang";
}

- (NSString*)sortObject {
	return @"Name";
}

- (NSString*)sectionObject {
	return nil;
}

- (NSPredicate*)predicate {
	NSPredicate *pred = [NSPredicate predicateWithFormat:@"ANY Municip==%@",municipality];
	return pred;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [[managedObject valueForKey:@"Name"] description];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	ProfileViewController* profile = [[ProfileViewController alloc] initWithProfileObject: (Gang*)managedObject];
	[self.navigationController pushViewController:profile animated:YES];
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
