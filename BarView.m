//
//  BarView.m
//  NJ Gangs
//
//  Created by John Jones on 5/11/11.
//  Copyright 2011 Phoenix4. All rights reserved.
//

#import "BarView.h"


@implementation BarView

@synthesize value;

-(id)initWithValue:(double)_value andFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
    if (self) {
		value = _value;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGRect outerRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
	CGRect innerRect = CGRectMake(0, 0, self.frame.size.width * value, self.frame.size.width);
	
	CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
	CGContextAddRect(context, outerRect);
	CGContextFillRect(context, outerRect);
	
	if (value > 0.6)
		CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
	else if (value <= 0.6 && value > 0.3)
		CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
	else
		CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);

	CGContextAddRect(context, innerRect);
	CGContextFillRect(context, innerRect);
}


- (void)dealloc {
    [super dealloc];
}


@end
