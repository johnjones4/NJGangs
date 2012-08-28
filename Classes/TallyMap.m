//
//  TallyMap.m
//  NJ Gangs
//
//  Created by John Jones on 3/17/11.
//  Copyright 2011 Phoenix4. All rights reserved.
//

#import "TallyMap.h"
#import "TallyMapItemPair.h"

@implementation TallyMap

-(id)init {
	self = [super init];
	if (self) {
		dict = [[NSMutableDictionary alloc] init];
		count = 0;
	}
	return self;
}

-(void)tally:(NSInteger)i forObject:(id)object {
	cachedSortedList = nil;
	cachedPercentages = nil;
	NSNumber* num = [dict valueForKey:[object description]];
	if (!num)
		num = [NSNumber numberWithInt:0];
	num = [NSNumber numberWithInt: [num intValue]+i];
	[dict setValue:num forKey:[object description]];
	count += i;
}

-(void)tally:(id)object {
	[self tally:1 forObject:object];
}

-(id)popularItem {
	NSObject* popularItem = nil;
	int popularity = 0;
	for (NSString* item in [dict allKeys]) {
		int thisPopularity = [[dict valueForKey:item] intValue];
		if (thisPopularity > popularity) {
			popularity = thisPopularity;
			popularItem = item;
		}
	}
	return popularItem;
}

-(NSDictionary*)itemPercentagesWithTotal:(NSInteger)total {
	if (!cachedPercentages) {
		NSMutableDictionary* pdict = [[NSMutableDictionary alloc] initWithCapacity:[dict count]];
		for (NSString* item in [dict allKeys]) {
			double val = [[dict valueForKey:item] doubleValue];
			[pdict setValue:[NSNumber numberWithDouble:(val/(double)total)] forKey:item];
		}
		cachedPercentages = [[NSDictionary alloc] initWithDictionary:pdict];
	}
	return cachedPercentages;
}

-(NSInteger)tallyFor:(id)object {
	return [[dict valueForKey:[object description]] intValue];
}

-(NSInteger)tallyTotal {
	return count;
}

-(NSArray*)tallyItems {
	return [dict allKeys];
}

-(NSArray*)sortKeysAscending:(BOOL)ascending {
	if (!cachedSortedList || cacedAscending != ascending) {
		NSMutableArray* pairs = [[NSMutableArray alloc] initWithCapacity:[dict count]];
		for (NSString* key in [dict allKeys]) {
			TallyMapItemPair* pair = [[TallyMapItemPair alloc] init];
			pair.key = key;
			pair.object = [dict valueForKey:key];
			[pairs addObject:pair];
		}
		NSSortDescriptor *sortDescriptor;
		sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"object" ascending:ascending] autorelease];
		NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
		NSArray* sortedPairs = [[pairs sortedArrayUsingDescriptors:sortDescriptors] retain];
		NSMutableArray* keys = [[NSMutableArray alloc] initWithCapacity:[dict count]];
		for (TallyMapItemPair* pair in sortedPairs) {
			[keys addObject:pair.key];
		}
		cachedSortedList = [[NSArray alloc] initWithArray:keys];
		cacedAscending = ascending;
	}
	return cachedSortedList;
}

@end
