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

@property (atomic, strong) NSMutableArray *filters;
@property (atomic, strong) NSMutableArray *proficiencyItems;
@property (atomic, strong) NSMutableArray *entities;


+(ttInputData*) Instance;

-(void) loadDataFile:(NSString*)filepath;
-(void) clearData;

-(NSArray*) getPhrasesForGroupId:(int)groupId;


@end
