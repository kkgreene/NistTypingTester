//
//  ttcHitBox.m
//  TypingTester
//
//  Created by Matthew Kerr on 12/11/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttHitBox.h"

@implementation ttHitBox

-(id)init
{
    return [self initWithRect:CGRectMake(0,0,0,0) forKeyType:SpecialKeyNone];
}

-(id)initWithRect:(CGRect)rect forKeyType:(SpecialKey)type
{
    self = [super init];
    if (self)
    {
        self.hitBox = rect;
        self.keyType = type;
    }
    return self;
}

-(bool)isPointInHitbox:(CGPoint) point
{
    return CGRectContainsPoint(self.hitBox, point);
}

@end
