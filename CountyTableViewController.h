//
//  CountyTableViewController.h
//  NJ Gangs
//
//  Created by John Jones on 10/7/10.
//
//  This class is the root table in region-based drill down.  It extends ManagedTableViewController
//

#import <Foundation/Foundation.h>
#import "ManagedTableViewController.h"

@class Municipality;

@interface CountyTableViewController : ManagedTableViewController <UIActionSheetDelegate> {
	UIActionSheet* step1sheet;
	UIActionSheet* step2sheet;
	Municipality* foundMunicip;
}

@end
