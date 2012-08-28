//
//  ProfileMap.h
//  NJ Gangs
//
//  Created by John Jones on 3/18/11.
//  Copyright 2011 Phoenix4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ProfileMapAnnotations.h"
#import "Profilable.h"

// Protocol to control the map
@protocol ProfileMapDelegate
// Called when user is done with the map view
- (void)closeMap;
@end

// This class is a UI controller of a map of NJ
@interface ProfileMap : UIViewController <MKMapViewDelegate> {
	// The actual map interface element
	MKMapView* map;
	// A delegate protocol to retrieve information
	id<ProfileMapDelegate> mapdelegate;
	// The profile to draw data from
	id<Profilable> profile;
}

@property (nonatomic,retain) IBOutlet MKMapView* map;
@property (nonatomic,retain) id<ProfileMapDelegate> mapdelegate;
@property (nonatomic,retain) id<Profilable> profile;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andProfile:(id<Profilable>)_profile;

@end
