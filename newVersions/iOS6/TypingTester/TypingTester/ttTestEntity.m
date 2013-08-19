//
//  ttTestEntity.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/14/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttTestEntity.h"

@implementation ttTestEntity

-(id) init
{
    self = [super init];
    if (self)
    {
        _groupId = -1;
        _filterValues = [[NSMutableArray alloc]init];
    }
    return self;
}


@end
