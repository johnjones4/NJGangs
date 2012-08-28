// 
//  Gang.m
//  NJ Gangs
//
//  Created by John Jones on 3/17/11.
//  Copyright 2011 Phoenix4. All rights reserved.
//

#import "Gang.h"
#import "Municipality.h"
#import "GangData.h"
#import "TallyMap.h"

@implementation Gang 

@dynamic Name;
@dynamic FirstLetterOfName;
@dynamic NumMunicips;
@dynamic Umbrella;
@dynamic SubGangs;
@dynamic SurveyRecords;
@dynamic Municip;

- (NSString *) FirstLetterOfName {
    [self willAccessValueForKey:@"FirstLetterOfName"];
    NSString * initial = [[self Name] substringToIndex:1];
	if ([initial isEqualToString:@"0"] ||
		[initial isEqualToString:@"1"] ||
		[initial isEqualToString:@"2"] ||
		[initial isEqualToString:@"3"] ||
		[initial isEqualToString:@"4"] ||
		[initial isEqualToString:@"5"] ||
		[initial isEqualToString:@"6"] ||
		[initial isEqualToString:@"7"] ||
		[initial isEqualToString:@"8"] ||
		[initial isEqualToString:@"9"])
		initial = @"#";
    [self didAccessValueForKey:@"FirstLetterOfName"];
    return initial;
}

@end
