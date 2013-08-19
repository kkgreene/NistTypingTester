//
//  ttTestEntity.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/14/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ttTestEntity : NSObject

@property (nonatomic, copy) NSString *entityString;
@property (nonatomic, assign) int groupId;
@property (nonatomic, strong) NSMutableArray *filterValues;

@end
