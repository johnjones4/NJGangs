//
//  BarView.h
//  NJ Gangs
//
//  Created by John Jones on 5/11/11.
//  Copyright 2011 Phoenix4. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BarView : UIView {
	double value;
}

@property (readonly) double value;

-(id)initWithValue:(double)_value andFrame:(CGRect)frame;

@end
