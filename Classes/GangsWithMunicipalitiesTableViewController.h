//
//  GangTableViewController.h
//  NJ Gangs
//
//  Created by John Jones on 10/8/10.
//
//  This class is the second level of the gangs-based drill down.  It displays municipalities for a given gang

#import <UIKit/UIKit.h>
#import "ManagedTableViewController.h"
#import "ProfileMap.h"

@interface GangsWithMunicipalitiesTableViewController : ManagedTableViewController <ProfileMapDelegate> {
	// The gang to retrieve municipalities on
	NSManagedObject* gangsObject;
}

// Constructor to set gang
- (id)initWithGang:(NSManagedObject*)iobject;

@end
