//
//  ProfileCellView.h
//  NJ Gangs
//
//  Created by John Jones on 2/17/11.
//  Copyright 2011 Phoenix4. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DEFAULT_CELL_WIDTH 159
#define DEFAULT_CELL_HEIGHT 21

@interface ProfileCellView : UIViewController {
	UILabel* label;
	UIView* cellview;
}

@property (nonatomic,retain) IBOutlet UILabel* label;
@property (nonatomic,retain) IBOutlet UIView* cellview;

-(void)adaptToHeight:(CGFloat)height;
+ (CGRect)createDefaultRect;
+ (UILabel*)createDefaultLabel;
+ (UILabel*)createLevelLabelWithNumber:(NSNumber*)num;
+ (UILabel*)createYesNoLabelWithNumber:(NSNumber*)num;

@end
