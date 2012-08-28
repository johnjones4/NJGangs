//
//  ProfileMapAnnotations.m
//  NJ Gangs
//
//  Created by John Jones on 3/18/11.
//  Copyright 2011 Phoenix4. All rights reserved.
//

#import "ProfileMapAnnotations.h"


@implementation ProfileMapAnnotations

@synthesize municip;

// See header
-(id)initWithMunicipality:(Municipality*)_municip {
	self = [super init];
	if (self) {
		municip = _municip;
	}
	return self;
}

// Get the lat-lon coordinate of this annotation
- (CLLocationCoordinate2D)coordinate {
	CLLocationCoordinate2D cord;
	cord.latitude = [municip.lat doubleValue];
	cord.longitude = [municip.lon doubleValue];
	return cord;
}

// Unused
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
	// Complies with protocol.  Do nothing.
}

// Get the title of this annotation
- (NSString *)title {
	return municip.Name;
}

// Unused
- (NSString *)subtitle {
	return nil;
}

@end
