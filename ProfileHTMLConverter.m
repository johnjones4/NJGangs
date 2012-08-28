//
//  ProfileHTMLConverter.m
//  NJ Gangs
//
//  Created by John Jones on 3/19/11.
//  Copyright 2011 Phoenix4. All rights reserved.
//

#import "ProfileHTMLConverter.h"
#import "ProfileItem.h"

@implementation ProfileHTMLConverter

-(id)initWithProfile:(id<Profilable>)_profile {
	self = [super init];
	if (self) {
		profile = _profile;
	}
	return self;
}

-(NSString*)subjectLine {
	return [NSString stringWithFormat:@"%@ via NJ Gangs App",[profile profileName]];
}

+(NSString*)makeTableWithKeys:(NSArray*)keys andValues:(NSArray*)values {
	NSMutableString* str = [[NSMutableString alloc] init];
	[str appendString:@"<table>"];
	for(int i=0;i<[keys count];i++) {
		[str appendFormat:@"<tr><td align=\"right\">%@</td><td align=\"left\">%@</td></tr>",[keys objectAtIndex:i],[values objectAtIndex:i]];
	}
	[str appendFormat:@"</table>"];
	return [[NSString alloc] initWithString:str];
}

-(NSString*)messageBody {
	NSMutableString* str = [[NSMutableString alloc] init];
	[str appendFormat:@"<html><body><h1>%@</h1>",[profile profileName]];
	for (int section=0;section<[profile numProfileSections];section++) {
		NSMutableArray* keys = [[NSMutableArray alloc] initWithCapacity:[profile numProfileSections]];
		NSMutableArray* values = [[NSMutableArray alloc] initWithCapacity:[profile numProfileSections]];
		for (int index=0;index<[profile numProfileItemsInSection:section];index++) {
			ProfileItem* item = [profile itemAtIndexSection:section andIndex:index];
			[keys insertObject:item.label atIndex:index];
			[values insertObject:[item textApproximationForView] atIndex:index];
		}
		[str appendFormat:@"<h2>%@</h2>",[profile titleForSection:section]];
		[str appendString:[ProfileHTMLConverter makeTableWithKeys:keys andValues:values]];
	}
	[str appendString:@"</body></html>"];
	return [[NSString alloc] initWithString:str];
}

@end
