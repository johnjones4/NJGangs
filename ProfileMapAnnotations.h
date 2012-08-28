//
//  ProfileMapAnnotations.h
//  NJ Gangs
//
//  Created by John Jones on 3/18/11.
//  Copyright 2011 Phoenix4. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Municipality.h"

// This is an implementation of the standard mapping annotation protocol
@interface ProfileMapAnnotations : NSObject <MKAnnotation> {
	// The municipality that we are annotating.
	Municipality* municip;
}

@property (nonatomic, readonly) Municipality* municip;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

// Instantiate with a the municipality
-(id)initWithMunicipality:(Municipality*)_municip;

@end
