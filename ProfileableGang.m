//
//  ProfileableGang.m
//  NJ Gangs
//
//  Created by John Jones on 12/20/10.
//  Copyright 2010 Phoenix4. All rights reserved.
//

#import "ProfileableGang.h"
#import "ProfileCellView.h"
#import "GangData.h"
#import "Municipality.h"
#import "ProfilableMunicipality.h"
#import "ProfileMapAnnotations.h"
#import "ProfileViewController.h"
#import "BarView.h"

@implementation Gang (Profilable)

// See Profilable.h
-(NSInteger)numProfileSections {
	return 6;
}

// See Profilable.h
-(void)precomputeValues {
	members = [[NSString stringWithFormat:@"≈ %4.2f per region",[[self averageMembersForMunicip:nil] doubleValue]] retain];
	age = [self popularAgeForMunicip:nil];
	business = [self popularBusinessForMunicip:nil];
	cooperates = [self cooperatesWithOtherGangsInMunicip:nil];
	crime = [self popularCrimeTypeInMunicip:nil];
	dues = [self collectsDuesInMunicip:nil];
	gender = [self popularGenderInMunicip:nil];
	member = [self popularMemberTypeInMunicip:nil];
	military = [self recuritsMilitaryInMunicip:nil];
	taxes = [self collectsTaxesInMunicip:nil];
	
	vcrimes = [self buildWorkableSetOfCrimes:VIOLENT_CRIME fromRecords:[self getWorkableSetOfRecordsForMunicip:nil]];
	violentCrimeMap = [[TallyMap alloc] init];
	for (NSManagedObject* crimeObj in vcrimes) {
		NSString* crime = [crimeObj valueForKey:@"Name"];
		if (![crime isEqualToString:@"None"])
			[violentCrimeMap tally:crime];
	}
	
	tcrimes = [self buildWorkableSetOfCrimes:THEFT_CRIME fromRecords:[self getWorkableSetOfRecordsForMunicip:nil]];
	theftCrimeMap = [[TallyMap alloc] init];
	for (NSManagedObject* crimeObj in tcrimes) {
		NSString* crime = [crimeObj valueForKey:@"Name"];
		if (![crime isEqualToString:@"None"])
			[theftCrimeMap tally:crime];
	}
	
	ocrimes = [self buildWorkableSetOfCrimes:MISC_CRIME fromRecords:[self getWorkableSetOfRecordsForMunicip:nil]];
	otherCrimeMap = [[TallyMap alloc] init];
	for (NSManagedObject* crimeObj in ocrimes) {
		NSString* crime = [crimeObj valueForKey:@"Name"];
		if (![crime isEqualToString:@"None"])
			[otherCrimeMap tally:crime];
	}
	
	drugs = [self buildWorkableSetOfDrugsfromRecords:[self getWorkableSetOfRecordsForMunicip:nil]];
	drugsMap = [[TallyMap alloc] init];
	NSLog(@"drug count: %i",[drugs count]);
	for (NSManagedObject* drugObj in drugs) {
		NSString* drug = [drugObj valueForKey:@"Name"];
		if (![drug isEqualToString:@"None"])
			[drugsMap tally:[[drugObj valueForKey:@"Level"] intValue] forObject:drug];
		NSLog(@"%@: %i",drug,[[drugObj valueForKey:@"Level"] intValue]);
	}
}

// See Profilable.h
-(NSInteger)numProfileItemsInSection:(NSInteger)section {
	switch (section) {
		case 0:
			return 1;
		case 1:
			return 10;
		case 2:
			return [[violentCrimeMap tallyItems] count];
		case 3:
			return [[theftCrimeMap tallyItems] count];
		case 4:
			return [[otherCrimeMap tallyItems] count];	
		case 5:
			return [[drugsMap tallyItems] count];
		default:
			return 0;
	}
}

// See Profilable.h
-(NSString*)titleForSection:(NSInteger)section {
	switch (section) {
		case 0:
			return @"Gang";
		case 1:
			return @"Basic Information";
		case 2:
			return @"Violent Crime";
		case 3:
			return @"Theft Crime";
		case 4:
			return @"Other Crime";
		case 5:
			return @"Drugs";
		default:
			return nil;
	}
}

// See Profilable.h
-(ProfileItem*)itemAtIndexSection:(NSInteger)section andIndex:(NSInteger)index {
	ProfileItem* item = [[ProfileItem alloc] init];
	UILabel* label = [ProfileCellView createDefaultLabel];
	item.view = label;
	if (section == 0) {
		if (index == 0) {
			item.label = @"Name";
			label.text = self.Name;
			return item;
		}
	} else if (section == 1) {
		switch (index) {
			case 0: {
				label.text = members;
				item.label = @"Reported Members";	
				break;
			}
			case 1: {
				label.text = age;
				item.label = @"Popular Age";	
				break;
			}
			case 2: {
				label.text = business;
				item.label = @"Business Involvement";	
				break;
			}
			case 3: {
				label.text = cooperates;
				item.label = @"Works with other Gangs";	
				break;
			}
			case 4: {
				label.text = crime;
				item.label = @"Popular Crime Type";	
				break;
			}
			case 5: {
				label.text = dues;
				item.label = @"Member Dues";	
				break;
			}
			case 6: {
				label.text = gender;
				item.label = @"Popular Gender Type";	
				break;
			}
			case 7: {
				label.text = member;
				item.label = @"Popular Member Type";	
				break;
			}
			case 8: {
				label.text = military;
				item.label = @"Recruits from Military";	
				break;
			}
			case 9: {
				label.text = taxes;
				item.label = @"Collects Taxes";	
				break;
			}
			default:
				break;
		}
		return item;
	} else if (section == 2) {
		NSString* itemlabel = [[violentCrimeMap sortKeysAscending:NO] objectAtIndex:index];
		item.label = itemlabel;
		item.view = [[BarView alloc] initWithValue:[[[violentCrimeMap itemPercentagesWithTotal:[vcrimes count]] valueForKey:itemlabel] doubleValue] andFrame:label.frame];
		return item;
	} else if (section == 3) {
		NSString* itemlabel = [[theftCrimeMap sortKeysAscending:NO] objectAtIndex:index];
		item.label = itemlabel;
		item.view = [[BarView alloc] initWithValue:[[[theftCrimeMap itemPercentagesWithTotal:[tcrimes count]] valueForKey:itemlabel] doubleValue] andFrame:label.frame];
		return item;
	} else if (section == 4) {
		NSString* itemlabel = [[otherCrimeMap sortKeysAscending:NO] objectAtIndex:index];
		item.label = itemlabel;
		item.view = [[BarView alloc] initWithValue:[[[otherCrimeMap itemPercentagesWithTotal:[ocrimes count]] valueForKey:itemlabel] doubleValue] andFrame:label.frame];
		return item;
	} else if (section == 5) {
		NSString* itemlabel = [[drugsMap sortKeysAscending:NO] objectAtIndex:index];
		item.label = itemlabel;
		item.view = [[BarView alloc] initWithValue:[[[drugsMap itemPercentagesWithTotal:[drugs count]] valueForKey:itemlabel] doubleValue] andFrame:label.frame];
		return item;
	}
	return nil;
}

// See header
-(NSSet*)buildWorkableSetOfCrimes:(NSString*)crimeType fromRecords:(NSSet*)records {
	NSMutableSet *crimeRecords = [[NSMutableSet alloc] init];
	for (NSManagedObject* gangrecord in records) {
		NSSet* subCrimeRecords = [gangrecord valueForKey:@"Crimes"];
		for (NSManagedObject* crimeRecrod in subCrimeRecords) {
			if ([[crimeRecrod valueForKey:@"Type"] isEqualToString:crimeType]) {
				[crimeRecords addObject:crimeRecrod];
			}
		}
	}
	return [[NSSet alloc] initWithSet:crimeRecords];
}

// See header
-(NSSet*)buildWorkableSetOfDrugsfromRecords:(NSSet*)records {
	NSMutableSet *drugRecords = [[NSMutableSet alloc] init];
	for (NSManagedObject* gangrecord in records) {
		NSSet* subDrugRecords = [gangrecord valueForKey:@"Drugs"];
		for (NSManagedObject* drugRecord in subDrugRecords) {
			[drugRecords addObject:drugRecord];
		}
	}
	return [[NSSet alloc] initWithSet:drugRecords];
}

// See header
-(NSString*)profileName {
	return self.Name;
}

// See header
-(NSSet*)getWorkableSetOfRecordsForMunicip:(Municipality*)munic {
	NSSet* set = [self SurveyRecords];
	NSMutableSet* buildSet = [[NSMutableSet alloc] init];
	for (NSManagedObject* record in set) {
		if (munic == nil || [[record valueForKey:@"Municipality"] isEqual: munic] ) {
			[buildSet addObject:record];
		}
	}
	return [[NSSet alloc] initWithSet:buildSet];
}

// See header
-(NSNumber*)averageMembersForMunicip:(Municipality*)munic {
	double total = 0;
	double count = 0;
	NSSet* set = [self getWorkableSetOfRecordsForMunicip:munic];
	for (NSManagedObject* record in set) {
		count ++;
		total += [[record valueForKey:@"Members"] doubleValue];
	}
	return [NSNumber numberWithDouble:(total/count)];
}

// See header
-(NSString*)popularAgeForMunicip:(Municipality*)munic {
	NSSet* set = [self getWorkableSetOfRecordsForMunicip:munic];
	TallyMap* map = [[TallyMap alloc] init];
	for (NSManagedObject* record in set) {
		[map tally:[[record valueForKey:AGE_LESS_15] intValue] forObject:AGE_LESS_15];
		[map tally:[[record valueForKey:AGE_15to17] intValue] forObject:AGE_15to17];
		[map tally:[[record valueForKey:AGE_18to24] intValue] forObject:AGE_18to24];
		[map tally:[[record valueForKey:AGE_24_PLUS] intValue] forObject:AGE_24_PLUS];
		[map tally:[[record valueForKey:AGE_UNKNOWN] intValue] forObject:AGE_UNKNOWN];
	}
	return [GangData ageLabel:(NSString*)[map popularItem]];
}

// See header
-(NSString*)popularBusinessForMunicip:(Municipality*)munic {
	NSSet* set = [self getWorkableSetOfRecordsForMunicip:munic];
	TallyMap* map = [[TallyMap alloc] init];
	for (NSManagedObject* record in set) {
		[map tally:[record valueForKey:@"Business"]];
	}
	return [GangData businessTypeName:[(NSNumber*)[map popularItem] intValue]];
}

// See header
-(NSString*)cooperatesWithOtherGangsInMunicip:(Municipality*)munic {
	NSSet* set = [self getWorkableSetOfRecordsForMunicip:munic];
	TallyMap* map = [[TallyMap alloc] init];
	for (NSManagedObject* record in set) {
		[map tally:[record valueForKey:@"CooperateWithOtherGangs"]];
	}
	return [GangData booleanName:[(NSNumber*)[map popularItem] intValue]];
}

// See header
-(NSString*)popularCrimeTypeInMunicip:(Municipality*)munic {
	NSSet* set = [self getWorkableSetOfRecordsForMunicip:munic];
	TallyMap* map = [[TallyMap alloc] init];
	for (NSManagedObject* record in set) {
		[map tally:[record valueForKey:@"Crime"]];
	}
	return [GangData crimeTypeName:[(NSNumber*)[map popularItem] intValue]];
}

// See header
-(NSString*)collectsDuesInMunicip:(Municipality*)munic {
	NSSet* set = [self getWorkableSetOfRecordsForMunicip:munic];
	TallyMap* map = [[TallyMap alloc] init];
	for (NSManagedObject* record in set) {
		[map tally:[record valueForKey:@"Dues"]];
	}
	return [GangData booleanName:[(NSNumber*)[map popularItem] intValue]];
}

// See header
-(NSString*)popularGenderInMunicip:(Municipality*)munic {
	NSSet* set = [self getWorkableSetOfRecordsForMunicip:munic];
	TallyMap* map = [[TallyMap alloc] init];
	for (NSManagedObject* record in set) {
		[map tally:[[record valueForKey:GENDER_MALE] intValue] forObject:GENDER_MALE];
		[map tally:[[record valueForKey:GENDER_FEMALE] intValue] forObject:GENDER_FEMALE];
		[map tally:[[record valueForKey:GENDER_UNKNOWN] intValue] forObject:GENDER_UNKNOWN];
	}
	return [GangData genderLabel:(NSString*)[map popularItem]];
}

// See header
-(NSString*)popularMemberTypeInMunicip:(Municipality*)munic {
	NSSet* set = [self getWorkableSetOfRecordsForMunicip:munic];
	TallyMap* map = [[TallyMap alloc] init];
	for (NSManagedObject* record in set) {
		[map tally:[record valueForKey:@"Members"]];
	}
	return [GangData membersTypeName:[(NSNumber*)[map popularItem] intValue]];
}

// See header
-(NSString*)recuritsMilitaryInMunicip:(Municipality*)munic {
	NSSet* set = [self getWorkableSetOfRecordsForMunicip:munic];
	TallyMap* map = [[TallyMap alloc] init];
	for (NSManagedObject* record in set) {
		[map tally:[record valueForKey:@"RecruitsMilitarySkills"]];
	}
	return [GangData booleanName:[(NSNumber*)[map popularItem] intValue]];
}

// See header
-(NSString*)collectsTaxesInMunicip:(Municipality*)munic {
	NSSet* set = [self getWorkableSetOfRecordsForMunicip:munic];
	TallyMap* map = [[TallyMap alloc] init];
	for (NSManagedObject* record in set) {
		[map tally:[record valueForKey:@"Taxes"]];
	}
	return [GangData booleanName:[(NSNumber*)[map popularItem] intValue]];
}

// See Profilable.h
-(MKCoordinateRegion)regionForMap {
	CLLocationCoordinate2D njCenter;
	njCenter.latitude = NJ_LAT_CENTER;
	njCenter.longitude = NJ_LON_CENTER;
	
	MKCoordinateSpan span;
	span.latitudeDelta = NJ_LAT_NORTHERN - NJ_LAT_CENTER;
	span.longitudeDelta = (NJ_LON_WESTERN - NJ_LON_CENTER) * -1.0;
	
	MKCoordinateRegion region;
	region.center = njCenter;
	region.span = span;
	
	return region;
}

// See Profilable.h
-(BOOL)detailsForMapAnnotation:(ProfileMapAnnotations*)annotation {
	return YES;
}

// See Profilable.h
-(NSArray*)mapAnnotations {
	NSMutableArray* annotations = [[NSMutableArray alloc] initWithCapacity: [self.Municip count]];
	for (Municipality* municip in [self Municip]) {
		[annotations addObject: [[ProfileMapAnnotations alloc] initWithMunicipality:municip]];
	}
	return [[NSArray alloc] initWithArray:annotations];
}

// See Profilable.h
-(UIViewController*)viewControllerForAnnotation:(ProfileMapAnnotations*)annotation {
	return [[ProfileViewController alloc] initWithProfileObject:annotation.municip];
}

@end
