//
//  NJ_GangsAppDelegate.h
//  NJ Gangs
//
//  Created by John Jones on 9/27/10.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class GangTableViewController;
@class CountyTableViewController;

@interface NJ_GangsAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UITabBarController* initialViewController;
	GangTableViewController *rootViewController;
	CountyTableViewController* countyTableViewController;

@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController* initialViewController;
@property (nonatomic, retain) IBOutlet GangTableViewController *rootViewController;
@property (nonatomic, retain) IBOutlet CountyTableViewController* countyTableViewController;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSString *)applicationDocumentsDirectory;

@end

