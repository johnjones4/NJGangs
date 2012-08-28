//
//  ProfilableMunicipality.m
//  NJ Gangs
//
//  Created by John Jones on 12/20/10.
//  Copyright 2010 Phoenix4. All rights reserved.
//

#import "ProfilableMunicipality.h"
#import "ProfileItem.h"
#import "ProfileCellView.h"
#import "County.h"
#import "ProfileMapAnnotations.h"

@implementation Municipality (Profilable)

-(void)precomputeValues {
	
}

-(NSInteger)numProfileSections {
	return 2;
}

-(NSInteger)numProfileItemsInSection:(NSInteger)section {
	if (section == 0)
		return 2;
	else 
		return 6;
}

-(NSString*)titleForSection:(NSInteger)section {
	if (section == 0)
		return @"General Information";
	else 
		return @"Gang Information";
}

-(ProfileItem*)itemAtIndexSection:(NSInteger)section andIndex:(NSInteger)index {
	ProfileItem* item = [[ProfileItem alloc] init];
	if (section == 0) {
		UILabel* label = [ProfileCellView createDefaultLabel];
		item.view = label;
		if (index == 0) {
			item.label = @"Name";
			label.text = self.Name;
		} else if (index == 1) {
			item.label = @"County";
			label.text = self.County.Name;
		}
		return item;
	} else {
		switch (index) {
			case 0: {
				UILabel* label = [ProfileCellView createDefaultLabel];
				label.text = [self.NumGangs stringValue];
				item.view = label;
				item.label = @"Number of Gangs";	
				break;
			}
			case 1: {
				item.label = @"Extreme Views";
				item.view = [ProfileCellView createYesNoLabelWithNumber:self.ExtremeViews];
				break;
			}
			case 2: {
				item.label = @"Public Events";
				item.view = [ProfileCellView createYesNoLabelWithNumber:self.GangPublicEvents];
				break;
			}
			case 3: {
				item.label = @"Linked to Extremists";
				item.view = [ProfileCellView createYesNoLabelWithNumber:self.LinkedToExtremists];
				break;
			}
			case 4: {
				item.label = @"Recruited in Jail";
				item.view = [ProfileCellView createYesNoLabelWithNumber:self.RecruitedInJail];
				break;
			}
			case 5: {
				item.label = @"Present in Schools";
				item.view = [ProfileCellView createYesNoLabelWithNumber:self.PresentNewSchools];
				break;
			}
			default:
				break;
		}
		return item;
	}
	return nil;
}

-(NSString*)profileName {
	return self.Name;
}

-(MKCoordinateRegion)regionForMap {
	CLLocationCoordinate2D njCenter;
	njCenter.latitude = [self.lat doubleValue];
	njCenter.longitude = [self.lon doubleValue];
	
	MKCoordinateSpan span;
	span.latitudeDelta = MAP_PADDING;
	span.longitudeDelta = MAP_PADDING;
	
	MKCoordinateRegion region;
	region.center = njCenter;
	region.span = span;
	
	return region;
}

-(NSArray*)mapAnnotations {
	ProfileMapAnnotations* annot = [[ProfileMapAnnotations alloc] initWithMunicipality:self];
	return [[NSArray alloc] initWithObjects:annot,nil];
}

-(BOOL)detailsForMapAnnotation:(ProfileMapAnnotations*)annotation {
	return NO;
}

-(UIViewController*)viewControllerForAnnotation:(ProfileMapAnnotations*)annotation {
	return nil;
}

@end
