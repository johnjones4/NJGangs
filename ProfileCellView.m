//
//  ProfileCellView.m
//  NJ Gangs
//
//  Created by John Jones on 2/17/11.
//  Copyright 2011 Phoenix4. All rights reserved.
//

#import "ProfileCellView.h"
#import "NJGangsColors.h"

@implementation ProfileCellView

@synthesize label,cellview;

-(void)adaptToHeight:(CGFloat)height {
	CGRect oldInnerFrame = cellview.frame;
	CGRect newInnerFrame = CGRectMake(oldInnerFrame.origin.x, oldInnerFrame.origin.y, oldInnerFrame.size.width, height);
	[self.cellview setFrame:newInnerFrame];
	
	CGRect oldOuterFrame = self.view.frame;
	CGRect newOuterFrame = CGRectMake(oldOuterFrame.origin.x, oldOuterFrame.origin.y, oldOuterFrame.size.width, height + (oldOuterFrame.origin.x*2));
	[self.view setFrame:newOuterFrame];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [NJGangsColors cellColorOdd];
	self.label.textColor = [NJGangsColors cellTextColor];
}

+ (CGRect)createDefaultRect {
	return CGRectMake(0, 0, DEFAULT_CELL_WIDTH, DEFAULT_CELL_HEIGHT);
}

+ (UILabel*)createDefaultLabel {
	UILabel* label = [[UILabel alloc] init];
	label.frame = [ProfileCellView createDefaultRect];
	label.backgroundColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0];
	label.textColor = [NJGangsColors cellTextColor];
	return label;
}

+ (UILabel*)createLevelLabelWithNumber:(NSNumber*)num {
	UILabel* label = [[UILabel alloc] init];
	label.frame = [ProfileCellView createDefaultRect];
	label.backgroundColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0];
	double val = [num doubleValue];
	if (val < .25) {
		label.textColor = [UIColor greenColor];
		label.text = @"Low Level";
	} else if (val >= .25 && val < .75) {
		label.textColor = [UIColor yellowColor];
		label.text = @"Medium Level";
	} else {
		label.textColor = [UIColor redColor];
		label.text = @"High Level";
	}
	return label;
}

+ (UILabel*)createYesNoLabelWithNumber:(NSNumber*)num {
	UILabel* label = [[UILabel alloc] init];
	label.frame = [ProfileCellView createDefaultRect];
	label.backgroundColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0];
	label.textColor = [NJGangsColors cellTextColor];
	double val = [num doubleValue];
	if (val < .5) {
		label.text = @"No";
	} else {
		label.text = @"Yes";
	}
	return label;
}

@end
