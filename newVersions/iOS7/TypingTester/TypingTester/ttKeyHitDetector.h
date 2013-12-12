//
//  ttKeyHitDetector.h
//  TypingTester
//
//  Created by Matthew Kerr on 12/11/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ttConstants.h"

@interface ttKeyHitDetector : NSObject

+(ttKeyHitDetector*)Instance;

-(SpecialKey)GetKeyAtPoint:(CGPoint)point;

@end
