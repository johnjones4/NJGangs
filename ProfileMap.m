//
//  ProfileMap.m
//  NJ Gangs
//
//  Created by John Jones on 3/18/11.
//  Copyright 2011 Phoenix4. All rights reserved.
//

#import "ProfileMap.h"
#import "NJGangsColors.h"
#import "ProfileMapAnnotations.h"

@implementation ProfileMap

@synthesize map, mapdelegate, profile;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andProfile:(id<Profilable>)_profile {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.profile = _profile;
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(callClose)];
	self.navigationItem.title = [NSString stringWithFormat:@"Map for %@",[self.profile profileName]];
	self.navigationController.navigationBar.tintColor = [NJGangsColors navigationBarColor];
	[self.map addAnnotations: [self.profile mapAnnotations]];
	[self.map setRegion:[self.profile  regionForMap] animated:YES];
}

- (void)callClose {
	[mapdelegate closeMap];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	static NSString *defaultPinID = @"profileannotation";
	MKPinAnnotationView *retval = nil;
	
	// See if we can reduce, reuse, recycle
	retval = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
	
	// If we have to, create a new view
	if (retval == nil) {
		retval = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID] autorelease];
		
		// Set the button as the callout view
		retval.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	}
	
	// Set a bunch of other stuff
	if (retval) {
		retval.canShowCallout = YES;
	}
	
	return retval;
}

// Called when the disclosure button in a map view is tapped.  Ths will push some view created by the Profile
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	ProfileMapAnnotations* annotation = (ProfileMapAnnotations*)view.annotation;
	UIViewController* controller = [self.profile viewControllerForAnnotation:annotation];
	[self.navigationController pushViewController:controller animated:YES];
}


@end
