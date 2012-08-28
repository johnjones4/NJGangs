//
//  TallyMap.h
//  NJ Gangs
//
//  Created by John Jones on 3/17/11.
//  Copyright 2011 Phoenix4. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TallyMap : NSObject {
	NSMutableDictionary* dict;
	NSInteger count;
	
	NSArray* cachedSortedList;
	BOOL cacedAscending;
	NSDictionary* cachedPercentages;
}

-(id)init;
-(void)tally:(NSInteger)i forObject:(id)object;
-(void)tally:(id)object;
-(NSInteger)tallyFor:(id)object;
-(NSInteger)tallyTotal;
-(id)popularItem;
-(NSArray*)sortKeysAscending:(BOOL)ascending;
-(NSArray*)tallyItems;
-(NSDictionary*)itemPercentagesWithTotal:(NSInteger)total;

@end
