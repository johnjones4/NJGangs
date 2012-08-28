//
//  Gang.h
//  NJ Gangs
//
//  Created by John Jones on 3/17/11.
//  Copyright 2011 Phoenix4. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Municipality;

@interface Gang :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * Name;
@property (nonatomic, retain) NSString * FirstLetterOfName;
@property (nonatomic, retain) NSNumber * NumMunicips;
@property (nonatomic, retain) Gang * Umbrella;
@property (nonatomic, retain) NSSet* SubGangs;
@property (nonatomic, retain) NSSet* SurveyRecords;
@property (nonatomic, retain) NSSet* Municip;

@end


@interface Gang (CoreDataGeneratedAccessors)
- (void)addSubGangsObject:(Gang *)value;
- (void)removeSubGangsObject:(Gang *)value;
- (void)addSubGangs:(NSSet *)value;
- (void)removeSubGangs:(NSSet *)value;

- (void)addSurveyRecordsObject:(NSManagedObject *)value;
- (void)removeSurveyRecordsObject:(NSManagedObject *)value;
- (void)addSurveyRecords:(NSSet *)value;
- (void)removeSurveyRecords:(NSSet *)value;

- (void)addMunicipObject:(Municipality *)value;
- (void)removeMunicipObject:(Municipality *)value;
- (void)addMunicip:(NSSet *)value;
- (void)removeMunicip:(NSSet *)value;

@end

