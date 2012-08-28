//
//  RegionFinder.h
//  NJ Gangs
//
//  Created by John Jones on 12/19/10.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#ifdef LOC_SYSTEM_TESTING

#define NUM_TESTS 6

// Atlantic or Cumberland
#define LAT1 39.349351
#define LON1 -74.860714

// Gloucester
#define LAT2 39.711400
#define LON2 -75.323579

// Camden
#define LAT3 39.926951
#define LON3 -75.118200

// Newark in Essex
#define LAT4 40.722823
#define LON4 -74.172981

// Atlantic
#define LAT5 39.352465
#define LON5 -74.442998

// New Jersey
#define LAT6 39.964445
#define LON6 -74.193795

#define LATS LAT1,LAT2,LAT3,LAT4,LAT5,LAT6
#define LONS LON1,LON2,LON3,LON4,LON5,LON6

#endif

@class Municipality, County;

enum FINDER_TYPE {
	COUNTY,
	MUNICIPALITY
};

@interface RegionFinder : NSObject <CLLocationManagerDelegate,MKReverseGeocoderDelegate> {
	CLLocationManager* mananger;
	id nextTarget;
	SEL nextSelector;
	NSManagedObjectContext* context;
	enum FINDER_TYPE type;
}

-(id)initWithManagedObjectContext:(NSManagedObjectContext*)_context;
-(void)pushCurrentCountyOn:(NSObject*)target action:(SEL)action;
-(void)pushCurrentMunicipalityOn:(NSObject*)target action:(SEL)action;

@end
