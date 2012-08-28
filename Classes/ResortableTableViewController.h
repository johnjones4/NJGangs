//
//  ResortableTableViewController.h
//  NJ Gangs
//
//  Created by John Jones on 11/17/10.
//
//  This subclass of ManagedTableViewController handles tables that need to be sorted alphabetically or numerically as this paradigm is used frequently using
//  abstract methods similar to the parent class.
//

#import <Foundation/Foundation.h>
#import "ManagedTableViewController.h"

@interface ResortableTableViewController : ManagedTableViewController {
	// Stores the image for the button when the list is alphabetically sorted
	UIImage* alphabetical;
	// Stores the image for the button when the list is numerically sorted
	UIImage* numerical;
	// Stores the current sorting state.  TRUE means alphabetically, FALSE means numerically
	BOOL sortAlphabetical;
}

// !!!! These are the unimplemented methods !!!!

// The object to sort by when set to alphabetical sorting.  Nil supported
- (NSString*)alphabeticalSortObject;
// The object to sort by when set to numerical sorting.  Nil supported
- (NSString*)numericalSortObject;
// The section object when sorting alphabetically.  Nil supported
- (NSString*)alphabeticalSection;
// The section object when sorting numerically.  Nil supported
- (NSString*)numericalSection;

// !!!! END unimplemented methods !!!!

@end
