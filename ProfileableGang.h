//
//  ProfileableGang.h
//  NJ Gangs
//
//  Created by John Jones on 12/20/10.
//  Copyright 2010 Phoenix4. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gang.h"
#import "Profilable.h"
#import "TallyMap.h"

#define NJ_LAT_CENTER 40.160174
#define NJ_LON_CENTER -74.547200

#define NJ_LAT_NORTHERN 41.99
#define NJ_LON_WESTERN -75.9

// This categorical interface of the Gang class adheres to the Profilable protocol

@interface Gang (Profilable) <Profilable>

// All of these variables are used by the class to cache calculated statistics

NSString* members;
NSString* age;
NSString* business;
NSString* cooperates;
NSString* crime;
NSString* dues;
NSString* gender;
NSString* member;
NSString* military;
NSString* taxes;
NSSet* vcrimes;
TallyMap* violentCrimeMap;
NSSet* tcrimes;
TallyMap* theftCrimeMap;
NSSet* ocrimes;
TallyMap* otherCrimeMap;
NSSet* drugs;
TallyMap* drugsMap;


// All of these methods are used to call various quick calculations

-(NSNumber*)averageMembersForMunicip:(Municipality*)munic;
-(NSString*)popularAgeForMunicip:(Municipality*)munic;
-(NSString*)popularBusinessForMunicip:(Municipality*)munic;
-(NSString*)cooperatesWithOtherGangsInMunicip:(Municipality*)munic;
-(NSString*)popularCrimeTypeInMunicip:(Municipality*)munic;
-(NSString*)collectsDuesInMunicip:(Municipality*)munic;
-(NSString*)popularGenderInMunicip:(Municipality*)munic;
-(NSString*)popularMemberTypeInMunicip:(Municipality*)munic;
-(NSString*)recuritsMilitaryInMunicip:(Municipality*)munic;
-(NSString*)collectsTaxesInMunicip:(Municipality*)munic;
-(NSSet*)buildWorkableSetOfCrimes:(NSString*)crimeType fromRecords:(NSSet*)records;
-(NSSet*)getWorkableSetOfRecordsForMunicip:(Municipality*)munic;
-(NSSet*)buildWorkableSetOfDrugsfromRecords:(NSSet*)records;

@end
