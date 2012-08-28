//
//  MunicipalitiesWithGangsTableViewController.h
//  NJ Gangs
//
//  Created by John Jones on 10/18/10.
//
//  This class is the third step of the region-based drill-down.  It presents a list of gangs for a given municipality.
//

#import <Foundation/Foundation.h>
#import "ManagedTableViewController.h"

@interface MunicipalitiesWithGangsTableViewController : ManagedTableViewController {
	// The object that holds the municipaltiy
	NSManagedObject* municipality;
}

// Constructor that accepts a municipality object
- (id)initWithMunicipality:(NSManagedObject*)iobject;

@end
