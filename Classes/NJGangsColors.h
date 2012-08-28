//
//  NJGangsColors.h
//  NJ Gangs
//
//  Created by John Jones on 11/23/10.
//
//  This class holds a set of static methods to get UI colors
//

#import <Foundation/Foundation.h>

// Static color definitions
#define COLOR_LIGHT_SLATE [UIColor colorWithRed:0.85 green:0.85 blue:0.9 alpha:1]
#define COLOR_DARK_SLATE [UIColor colorWithRed:0.1 green:0.1 blue:0.15 alpha:1]
#define COLOR_SLATE [UIColor colorWithRed:0.25 green:0.25 blue:0.3 alpha:1]
#define COLOR_DARK_GRAY [UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1]
#define COLOR_OFF_WHITE [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1]
#define COLOR_LIGHT_GRAY [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1]
#define COLOR_GRAY [UIColor grayColor]
#define COLOR_SEMITRANSPARENT_GRAY [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.75]

@interface NJGangsColors : NSObject {

}

// The color of the navigation bar found at the top of the screen, below the clock
+ (UIColor*)navigationBarColor;

// The standard background color
+ (UIColor*)standardBackgroundColor;

// The color of odd-indexed cells
+ (UIColor*)cellColorOdd;

// The color of even indexed cells
+ (UIColor*)cellColorEven;

// The color of text in the cells
+ (UIColor*)cellTextColor;

// The color of selected cells
+ (UIColor*)cellSeclectedColor;

// The color of secion headers
+ (UIColor*)sectionHeaderColor;

// The color of section header colors
+ (UIColor*)sectionHeaderTextColor;

@end
