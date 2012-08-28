//
//  County.h
//  NJ Gangs
//
//  Created by John Jones on 12/19/10.
//  Copyright 2010 Phoenix4. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Municipality;

@interface County :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * Name;
@property (nonatomic, retain) NSNumber * lat;
@property (nonatomic, retain) NSNumber * lon;
@property (nonatomic, retain) NSSet* Municipalities;

@end


@interface County (CoreDataGeneratedAccessors)
- (void)addMunicipalitiesObject:(Municipality *)value;
- (void)removeMunicipalitiesObject:(Municipality *)value;
- (void)addMunicipalities:(NSSet *)value;
- (void)removeMunicipalities:(NSSet *)value;

@end

