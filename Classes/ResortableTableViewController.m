//
//  ResortableTableViewController.m
//  NJ Gangs
//
//  Created by John Jones on 11/17/10.
//

#import "ResortableTableViewController.h"


@implementation ResortableTableViewController

#pragma mark -
#pragma mark View lifecycle

// Called when the view is loaded.  Does the follwing:
//    1. Set sortAlphabetical to true
//    2. Load the images
//    3. Set up the sort button using the alphabetical image
- (void)viewDidLoad {
	sortAlphabetical = TRUE;
	[super viewDidLoad];
	alphabetical = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sorting_alphabetical" ofType:@"png"]];
	numerical = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sorting_numerical" ofType:@"png"]];
	UIBarButtonItem *sortButton = [[UIBarButtonItem alloc] initWithImage:alphabetical style:UIBarButtonItemStylePlain target:self action:@selector(toggleSort)];
	self.navigationItem.rightBarButtonItem = sortButton;
}

#pragma mark -
#pragma mark Abstract methods from ManagedTableViewController

// Called to get the sort object.  
// If sortAlphabetical is true, return the value of [self alphabeticalSortObject]
// If sortAlphabetical is false, return the value of [self numericalSortObject]
- (NSString*)sortObject {
	if (sortAlphabetical)
		return [self alphabeticalSortObject];
	else
		return [self numericalSortObject];
}

// Called to get the section object
// If sortAlphabetical is true, return the value of [self alphabeticalSection]
// If sortAlphabetical is false, return the value of [self numericalSection]
- (NSString*)sectionObject {
	if (sortAlphabetical)
		return [self alphabeticalSection];
	else
		return [self numericalSection];
}

// Called to get the sort direction.  Return sortAlphabetical
- (BOOL)direction {
	return sortAlphabetical;
}

#pragma mark -
#pragma mark Sorting control

// Called when the sort button is tapped.
// Flips the value of sortAlphabetical
// Changes the button image appropriately
// Resorts the table
- (void)toggleSort {
	sortAlphabetical = !sortAlphabetical;
	
	UIBarButtonItem *sortButton = nil;
	if (sortAlphabetical) {
		sortButton = [[UIBarButtonItem alloc] initWithImage:alphabetical style:UIBarButtonItemStylePlain target:self action:@selector(toggleSort)];
	} else {
		sortButton = [[UIBarButtonItem alloc] initWithImage:numerical style:UIBarButtonItemStylePlain target:self action:@selector(toggleSort)];
	}
	self.navigationItem.rightBarButtonItem = sortButton;
	
	
	self.fetchedResultsController = nil;
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Error in refetch: %@",[error localizedDescription]);
        abort();
    }
	
    [self.tableView reloadData];
}
	
@end
