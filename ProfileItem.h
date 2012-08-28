//
//  ProfileItem.h
//  NJ Gangs
//
//  Created by John Jones on 2/17/11.
//  Copyright 2011 Phoenix4. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ProfileItem : NSObject {
	NSString* label;
	UIView* view;
}

@property (nonatomic,retain) NSString* label;
@property (nonatomic,retain) UIView* view;

-(CGFloat)heightForSize:(CGSize)size;
-(NSString*)textApproximationForView;

@end
