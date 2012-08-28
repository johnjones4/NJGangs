//
//  TallyMapItemPair.h
//  NJ Gangs
//
//  Created by John Jones on 3/18/11.
//  Copyright 2011 Phoenix4. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TallyMapItemPair : NSObject {
	NSString* key;
	id object;
}

@property (nonatomic,retain) NSString* key;
@property (nonatomic,retain) id object;

@end
