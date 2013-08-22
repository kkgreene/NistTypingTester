//
//  ttInputData.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/19/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ttXmlParserDelegate.h"

@interface ttInputData : ttXmlParserDelegate

@property (atomic, strong) NSArray *filters;
@property (atomic, strong) NSArray *proficiencyItems;
@property (atomic, strong) NSArray *entities;


+(ttInputData*) Instance;

-(void) loadDataFile:(NSString*)filepath;
-(void) clearData;

-(NSArray*) getPhrasesForGroupId:(int)groupId;
-(NSArray*) getPhrasesForGroupId:(int)groupId inRandomOrder:(BOOL)random;
-(NSArray*) getPhrasesForGroupId:(int)groupId withRandomSeedValue:(int)seed;
-(NSArray*) getEntities;
-(NSArray*) getEntitiesInRandomOrder;
-(NSArray*) getEntitiesWithGroupId:(int)groupId
                      EarlierThan:(NSDate*)date
                      WithFilters:(NSArray*)includeFilters
                   WithoutFilters:(NSArray*)excludeFilters
                         withSeed:(unsigned int)seed;
-(NSArray*) getEntitiesWithGroupId:(int)groupId
                      EarlierThan:(NSDate*)date
                      WithFilters:(NSArray*)includeFilters
                   WithoutFilters:(NSArray*)excludeFilters
                    inRandomOrder:(BOOL)random;
-(NSArray*) getEntitiesWithGroupId:(int)groupId
                      EarlierThan:(NSDate*)date
                      WithFilters:(NSArray*)includeFilters
                   WithoutFilters:(NSArray*)excludeFilters;
@end
