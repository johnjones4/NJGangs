//
//  GangData.h
//  NJ Gangs
//
//  Created by John Jones on 3/17/11.
//  Copyright 2011 Phoenix4. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CRIME_TRANSIENT 3
#define CRIME_RESIDENT 2
#define CRIME_NEITHER 1
#define CRIME_UNKNOWN 0

#define MEMBERS_TRANSIENT 3
#define MEMBERS_RESIDENT 2
#define MEMBERS_NEITHER 1
#define MEMBERS_UNKNOWN 0

#define BUSINESS_LEGITIMATE 3
#define BUSINESS_REALESTATE 2
#define BUSINESS_NEITHER 1
#define BUSINESS_UNKNOWN 0

#define BOOLEAN_TRUE 1
#define BOOLEAN_FALSE -1
#define BOOLEAN_UNKNOWN 0

#define AGE_LESS_15 @"Agel15"
#define AGE_15to17 @"Age15to17"
#define AGE_18to24 @"Age18to24"
#define AGE_24_PLUS @"Age24plus"
#define AGE_UNKNOWN @"AgeDontKnow"

#define GENDER_MALE @"GenderMale"
#define GENDER_FEMALE @"GenderFemale"
#define GENDER_UNKNOWN @"GenderDontKnow"

#define VIOLENT_CRIME @"ViolentCrime"
#define THEFT_CRIME @"TheftCrime"
#define MISC_CRIME @"MiscCrime"

@interface GangData : NSObject {

}

+(NSString*)crimeTypeName:(NSInteger)ord;
+(NSString*)membersTypeName:(NSInteger)ord;
+(NSString*)booleanName:(NSInteger)ord;
+(NSString*)ageLabel:(NSString*)shortname;
+(NSString*)businessTypeName:(NSInteger)ord;
+(NSString*)genderLabel:(NSString*)shortname;

@end
