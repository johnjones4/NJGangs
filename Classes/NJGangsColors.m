//
//  NJGangsColors.m
//  NJ Gangs
//
//  Created by John Jones on 11/23/10.
//
//  See header file for method descriptions
//

#import "NJGangsColors.h"

@implementation NJGangsColors

+ (UIColor*)navigationBarColor {
	return COLOR_DARK_SLATE;
}

+ (UIColor*)standardBackgroundColor {
	return COLOR_SLATE;
}

+ (UIColor*)cellColorOdd {
	return COLOR_DARK_GRAY;
}

+ (UIColor*)cellColorEven {
	return COLOR_SLATE;
}

+ (UIColor*)cellTextColor {
	return COLOR_OFF_WHITE;
}

+ (UIColor*)cellSeclectedColor {
	return COLOR_LIGHT_GRAY;
}

+ (UIColor*)sectionHeaderColor {
	return COLOR_SEMITRANSPARENT_GRAY;
}

+ (UIColor*)sectionHeaderTextColor {
	return COLOR_LIGHT_SLATE;
}

@end