//
//  ManagedTableViewController.h
//
//  Created by John Jones on 8/24/10.
//
//  This subclass of UITableViewController simplifies implementation of Core Data to GUI coupling needed by the tables throughout this project.  In order to
//  control what and how CoreData objects are accessed, there are several unimplemented methods in this class.  These are documented below.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ManagedTableViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
}

// This object acts as the broker between the GUI and CoreData
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

// The "context" represents the specific CoreData database that we are using
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

// Constructor that accepts a context from which to draw data
- (id)initWithManagedObjectContext:(NSManagedObjectContext*)context;

// !!!! These are the unimplemented methods !!!!

// The name of the objects to fetch from the database.  This must have a value
- (NSString*)fetchObject;

// The column to sort using.  A nil value means no sorting
- (NSString*)sortObject;

// The column to identify sections by.  A nil value means no sectioning
- (NSString*)sectionObject;

// The filtering predicate.  A nil value means no filtering
- (NSPredicate*)predicate;

// !!!! END unimplemented methods !!!!

// Direction to sort by.  TRUE means ascending, FALSE means descending
- (BOOL)direction;

// Configure a cell for the given index path
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

// Custom overriding of the Apple-provided disclosure button
- (UIView*)getCustomDisclosureButton;

@end
