//
//  ttTestEntity.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/14/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ttXmlParserDelegate.h"

@interface ttTestEntity : ttXmlParserDelegate

@property (nonatomic, copy) NSString *entityString;
@property (nonatomic, assign) int groupId;
@property (nonatomic, assign) int itemId;
@property (nonatomic, copy) NSDate *date;
@property (nonatomic, strong) NSMutableArray *filterValues;

@end
