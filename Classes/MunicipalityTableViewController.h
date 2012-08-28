//
//  MunicipalityTableViewController.h
//  NJ Gangs
//
//  Created by John Jones on 10/7/10.
//
//  This class is the second level of the region-based drill-down.  It displays a list of municipalities in a county.

#import <Foundation/Foundation.h>
#import "ResortableTableViewController.h"

@interface MunicipalityTableViewController : ResortableTableViewController {
	NSManagedObject *object;
}

// The object that holds a county
@property (nonatomic,retain) NSManagedObject *object;

// Constructor that sets the county object
- (id)initWithManagedObjectContext:(NSManagedObjectContext*)context andCounty:(NSManagedObject*) object;

@end
