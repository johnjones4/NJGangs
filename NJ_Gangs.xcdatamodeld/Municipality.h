//
//  Municipality.h
//  NJ Gangs
//
//  Created by John Jones on 3/18/11.
//  Copyright 2011 Phoenix4. All rights reserved.
//

#import <CoreData/CoreData.h>

@class County;
@class Gang;

@interface Municipality :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * GangDates;
@property (nonatomic, retain) NSNumber * GangsDecreased;
@property (nonatomic, retain) NSNumber * GangsIncreased;
@property (nonatomic, retain) NSNumber * GangsStayedSame;
@property (nonatomic, retain) NSNumber * GangPublicEvents;
@property (nonatomic, retain) NSNumber * IncarceratedMembersControlling;
@property (nonatomic, retain) NSNumber * lon;
@property (nonatomic, retain) NSString * Name;
@property (nonatomic, retain) NSNumber * PresentNewSchools;
@property (nonatomic, retain) NSString * FIPS;
@property (nonatomic, retain) NSNumber * RecruitedInJail;
@property (nonatomic, retain) NSNumber * NumGangs;
@property (nonatomic, retain) NSNumber * GangsPresent;
@property (nonatomic, retain) NSNumber * lat;
@property (nonatomic, retain) NSNumber * GangLocations;
@property (nonatomic, retain) NSNumber * LinkedToExtremists;
@property (nonatomic, retain) NSNumber * ExtremeViews;
@property (nonatomic, retain) NSNumber * CrimalNetworks;
@property (nonatomic, retain) NSSet* Gangs;
@property (nonatomic, retain) County * County;

@end


@interface Municipality (CoreDataGeneratedAccessors)
- (void)addGangsObject:(Gang *)value;
- (void)removeGangsObject:(Gang *)value;
- (void)addGangs:(NSSet *)value;
- (void)removeGangs:(NSSet *)value;

@end

