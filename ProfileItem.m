//
//  ProfileItem.m
//  NJ Gangs
//
//  Created by John Jones on 2/17/11.
//  Copyright 2011 Phoenix4. All rights reserved.
//

#import "ProfileItem.h"
#import "BarView.h"

@implementation ProfileItem

@synthesize label,view;

-(CGFloat)heightForSize:(CGSize)size {
	CGRect oldFrame = view.frame;
	if (oldFrame.size.height > size.height || oldFrame.size.width > size.width) {
		CGFloat height = (size.width * oldFrame.size.height) / oldFrame.size.width;
		CGRect newFrame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y, size.width, height);
		[self.view setFrame:newFrame];
		return height;
	} else {
		CGRect newFrame = CGRectMake(0, 0, size.width, size.height);
		[self.view setFrame:newFrame];
		return size.height;
	}
}

-(NSString*)textApproximationForView {
	if ( [view isKindOfClass: [UILabel class]] ) {
		UILabel* uilabel = (UILabel*)view;
		return uilabel.text;
	} else if ([view isKindOfClass: [BarView class]] ) {
		BarView* barView = (BarView*)view;
		return [NSString stringWithFormat:@"%3.1f%%",(barView.value*100)];
	} else {
		return [view description];
	}

}

@end
