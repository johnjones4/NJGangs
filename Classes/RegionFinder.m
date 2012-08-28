//
//  RegionFinder.m
//  NJ Gangs
//
//  Created by John Jones on 12/19/10.
//  Copyright 2010 Phoenix4. All rights reserved.
//

#import "RegionFinder.h"
#import "County.h"
#import "Municipality.h"

@implementation RegionFinder

#pragma mark Object init

-(id)initWithManagedObjectContext:(NSManagedObjectContext*)_context {
	if (self = [super init]) {
		context = _context;
	}
	return self;
}

#pragma mark Utilities

- (BOOL)inetAvailable {
	return YES;
}

- (double)distForX1:(double)x1 y1:(double)y1 x2:(double)x2 y2:(double)y2 {
	return sqrt(pow(x2-x1, 2) + pow(y2-y1, 2));
}

- (County*)countyForLongtitude:(double)lon andLatitude:(double)lat {
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"County" inManagedObjectContext:context];
	[request setEntity:entity];
	NSError *error = nil;
	NSMutableArray *mutableFetchResults = [[context executeFetchRequest:request error:&error] mutableCopy];
	if (mutableFetchResults != nil) {
		double dist = 1000;
		County* best = nil;
		for (County* county in mutableFetchResults) {
			double thisDist = [self distForX1:lat y1:lon x2:[county.lat doubleValue] y2:[county.lon doubleValue]];
			if (thisDist < dist) {
				best = county;
				dist = thisDist;
#ifdef LOC_SYSTEM_TESTING
				NSLog(@"%f",thisDist);
#endif
			}
		}
		return best;
	}
	return nil;
}

- (Municipality*)municipalityWithName:(NSString*)name {
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Municipality" inManagedObjectContext:context];
	[request setEntity:entity];
	NSError *error = nil;
	NSMutableArray *mutableFetchResults = [[context executeFetchRequest:request error:&error] mutableCopy];
	if (mutableFetchResults != nil) {
		for (Municipality* municipality in mutableFetchResults) {
			if ([municipality.Name isEqualToString:name]) {
				return municipality;
			}
		}
	}
	return nil;
}

#pragma mark Starting and stopping GPS

-(void)startUpdates {
#ifdef LOC_SYSTEM_TESTING
	static int count;
	static const double lons[NUM_TESTS] = {LONS};
	static const double lats[NUM_TESTS] = {LATS};
	
	if (count < 1)
		count = 1;
	
	NSLog(@"Feeding fake location #%i",count-1);
	
	CLLocation* loc = [[CLLocation alloc] initWithLatitude:lats[count-1] longitude:lons[count-1]];
	count++;
	if (count > NUM_TESTS)
		count = 1;
	[self locationManager:nil didUpdateToLocation:loc fromLocation:nil];
#else
	if (mananger) {
		[mananger stopUpdatingLocation];
		[mananger release];
	}	
	mananger = [[CLLocationManager alloc] init];
	[mananger retain];
	mananger.desiredAccuracy = kCLLocationAccuracyKilometer;
	mananger.distanceFilter = 500;
	mananger.delegate = self;
	[mananger startUpdatingLocation];
#endif
}

- (void)stopUpdates {
	if (mananger) {
		[mananger stopUpdatingLocation];
		[mananger release];
		mananger = nil;
	}
}

#pragma mark Actual functions.  Only these are visible

-(void)stdKernel:(NSObject*)target action:(SEL)action {
	[self retain];
	nextTarget = target;
	nextSelector = action;
	[self performSelectorOnMainThread:@selector(startUpdates) withObject:nil waitUntilDone:YES];
}

-(void)pushCurrentCountyOn:(NSObject*)target action:(SEL)action {
	type = COUNTY;
	[self stdKernel:target action:action];
}

-(void)pushCurrentMunicipalityOn:(NSObject*)target action:(SEL)action {
	type = MUNICIPALITY;
	[self stdKernel:target action:action];
}

#pragma mark CLLocationManagerDelegate functions

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	[self performSelectorOnMainThread:@selector(stopUpdates) withObject:nil waitUntilDone:YES];
#ifdef LOC_SYSTEM_TESTING
	NSLog(@"You are at: %f x %f",newLocation.coordinate.longitude,newLocation.coordinate.latitude);
#endif
	if (type == COUNTY) {
		MKReverseGeocoder* theGeocoder = [[MKReverseGeocoder alloc] initWithCoordinate:newLocation.coordinate];
		theGeocoder.delegate = self;
		[theGeocoder start];
	} else if (type == MUNICIPALITY) {
		MKReverseGeocoder* theGeocoder = [[MKReverseGeocoder alloc] initWithCoordinate:newLocation.coordinate];
		theGeocoder.delegate = self;
		[theGeocoder start];
	}
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	[self performSelectorOnMainThread:@selector(stopUpdates) withObject:nil waitUntilDone:NO];
	[nextTarget performSelectorOnMainThread:nextSelector withObject:nil waitUntilDone:NO];
}

#pragma mark MKReverseGeocoderDelegate functions

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error {
	[nextTarget performSelectorOnMainThread:nextSelector withObject:nil waitUntilDone:NO];
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark {
	if (type == COUNTY) {
		Municipality* municip = [self municipalityWithName:placemark.locality];
		if (municip) {
			[nextTarget performSelectorOnMainThread:nextSelector withObject:municip.County waitUntilDone:NO];
		} else {
			County* county = [self countyForLongtitude: placemark.coordinate.longitude andLatitude: placemark.coordinate.latitude];
			[nextTarget performSelectorOnMainThread:nextSelector withObject:county waitUntilDone:NO];
			[county release];
		}
	} else if (type == MUNICIPALITY) {
		Municipality* municip = [self municipalityWithName:placemark.locality];
		[nextTarget performSelectorOnMainThread:nextSelector withObject:municip waitUntilDone:NO];
	}
}

@end
