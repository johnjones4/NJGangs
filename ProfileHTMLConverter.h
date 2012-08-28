//
//  ProfileHTMLConverter.h
//  NJ Gangs
//
//  Created by John Jones on 3/19/11.
//  Copyright 2011 Phoenix4. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Profilable.h"

@interface ProfileHTMLConverter : NSObject {
	id<Profilable> profile;
}

-(id)initWithProfile:(id<Profilable>)_profile;

@property (readonly) NSString* subjectLine;
@property (readonly) NSString* messageBody;

@end
