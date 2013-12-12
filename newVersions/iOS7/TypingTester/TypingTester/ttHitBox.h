//
//  ttcHitBox.h
//  TypingTester
//
//  Created by Matthew Kerr on 12/11/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ttConstants.h"

@interface ttHitBox : NSObject

@property (nonatomic, assign) CGRect hitBox;
@property (nonatomic, assign) SpecialKey keyType;

-(id)initWithRect:(CGRect)rect forKeyType:(SpecialKey)type;

-(bool)isPointInHitbox:(CGPoint) point;


@end
