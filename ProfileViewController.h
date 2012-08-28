//
//  ProfileViewController.h
//  NJ Gangs
//
//  Created by John Jones on 12/20/10.
//  Copyright 2010 Phoenix4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "ProfileMap.h"
#import "Profilable.h"

#define SECTION_HEADER_HEIGHT 40

// This class is the view controller for both the municipality and gang profiles. 
// The Profilable protocol implementation determines how the profile is rendered
@interface ProfileViewController : UITableViewController <UIActionSheetDelegate,ProfileMapDelegate,MFMailComposeViewControllerDelegate> {
	// The object to get profile data from
	id<Profilable> profObject;
}

// Create a profile view with a iven profilable object
-(id)initWithProfileObject:(id<Profilable>)_profObject;

@end
