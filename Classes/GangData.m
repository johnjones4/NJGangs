//
//  GangData.m
//  NJ Gangs
//
//  Created by John Jones on 3/17/11.
//  Copyright 2011 Phoenix4. All rights reserved.
//

#import "GangData.h"


@implementation GangData

+(NSString*)crimeTypeName:(NSInteger)ord {
	switch (ord) {
		case CRIME_TRANSIENT:
			return @"Transient";
		case CRIME_RESIDENT:
			return @"Resident";
		case CRIME_NEITHER:
			return @"Neither";
		default:
			return @"Unknown";
	}
}

+(NSString*)membersTypeName:(NSInteger)ord {
	switch (ord) {
		case MEMBERS_TRANSIENT:
			return @"Transient";
		case MEMBERS_RESIDENT:
			return @"Resident";
		case MEMBERS_NEITHER:
			return @"Neither";
		default:
			return @"Unknown";
	}
}

+(NSString*)businessTypeName:(NSInteger)ord {
	switch (ord) {
		case BUSINESS_LEGITIMATE:
			return @"Legitimate";
		case BUSINESS_REALESTATE:
			return @"Real Estate";
		case BUSINESS_NEITHER:
			return @"Neither";
		default:
			return @"Unknown";
	}
}

+(NSString*)booleanName:(NSInteger)ord {
	switch (ord) {
		case BOOLEAN_TRUE:
			return @"Yes";
		case BOOLEAN_FALSE:
			return @"No";
		default:
			return @"Unknown";
	}
}

+(NSString*)ageLabel:(NSString*)shortname {
	if ([shortname isEqualToString:AGE_LESS_15])
		return @"Less than 15";
	if ([shortname isEqualToString:AGE_15to17])
		return @"15 to 17";
	if ([shortname isEqualToString:AGE_18to24])
		return @"18 to 24";
	if ([shortname isEqualToString:AGE_24_PLUS])
		return @"Over 24";
	else
		return @"Unknown";
}

+(NSString*)genderLabel:(NSString*)shortname {
	if ([shortname isEqualToString:GENDER_MALE])
		return @"Male";
	if ([shortname isEqualToString:GENDER_FEMALE])
		return @"Female";
	else
		return @"Unknown";
}

@end
