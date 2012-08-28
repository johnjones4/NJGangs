//
//  GangTableViewController.m
//  NJ Gangs
//
//  Created by John Jones on 10/8/10.
//

#import "GangTableViewController.h"
#import "GangsWithMunicipalitiesTableViewController.h"
#import "Gang.h"
#import "ProfileViewController.h"
#import "ProfileableGang.h"

@implementation GangTableViewController

// Fetch all "Gang" objects
- (NSString*)fetchObject {
	return @"Gang";
}

// Alpha sort by Gang.Name
- (NSString*)alphabeticalSortObject {
	return @"Name";
}

// Num sort by Gang.NumMunicips
- (NSString*)numericalSortObject {
	return @"NumMunicips";
}

// Alpha section is FirstLetterOfName
- (NSString*)alphabeticalSection {
	return @"FirstLetterOfName";
}

// There is no num sort section
- (NSString*)numericalSection {
	return nil;
}

// There is no predicate
- (NSPredicate*)predicate {
	return nil;
}

// Overriden from superclass.  The difference is that the cell is of style "UITableViewCellStyleSubtitle"
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"GangCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	[self configureCell:cell atIndexPath:indexPath];
    return cell;
}

// Configure the cell by setting the main text to the gang name and the subtitle to the number of active gangs
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [[managedObject valueForKey:@"Name"] description];
	if ([[managedObject valueForKey:@"Municip"] count] == 1)
		cell.detailTextLabel.text = @"Active in 1 Municipality";
	else
		cell.detailTextLabel.text = [NSString stringWithFormat:@"Active in %i Municipalities",[[managedObject valueForKey:@"Municip"] count]];
	cell.accessoryView = [self getCustomDisclosureButton];
}

// If the disclosure button is tapped, push a gang profile
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
	NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	ProfileViewController* profile = [[ProfileViewController alloc] initWithProfileObject: (Gang*)managedObject];
	[self.navigationController pushViewController:profile animated:YES];
}

// If the row is tapped, push a GangsWithMunicipaltiesTableViewController object
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	GangsWithMunicipalitiesTableViewController* controller = [[GangsWithMunicipalitiesTableViewController alloc] initWithGang:managedObject];
	[self.navigationController pushViewController:controller animated:YES];
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
