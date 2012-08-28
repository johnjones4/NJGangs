//
//  Profilable.h
//  NJ Gangs
//
//  Created by John Jones on 12/20/10.
//  Copyright 2010 Phoenix4. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "ProfileItem.h"
#import "ProfileMapAnnotations.h"

// This protocol defines methods that must be shared amongst the municipality and gang classes to be profiled.

@protocol Profilable

// Called to help the object frontload values for sake of speed
-(void)precomputeValues;
// The number of sections in the profile
-(NSInteger)numProfileSections;
// The number of items in the section
-(NSInteger)numProfileItemsInSection:(NSInteger)section;
// Get the actual profile item
-(ProfileItem*)itemAtIndexSection:(NSInteger)section andIndex:(NSInteger)index;
// The name of the profile
-(NSString*)profileName;
// The title of the section
-(NSString*)titleForSection:(NSInteger)section;
// The region to show if a map is being used
-(MKCoordinateRegion)regionForMap;
// Annotations to add to the map
-(NSArray*)mapAnnotations;
// Return true if the map annotation popup should have a dsiclosure button
-(BOOL)detailsForMapAnnotation:(ProfileMapAnnotations*)annotation;
// The view to push if the disclosure button on the annotation popup was selected
-(UIViewController*)viewControllerForAnnotation:(ProfileMapAnnotations*)annotation;

@end

