//
//  ttEventTouch.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/15/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttEventTouch.h"

@implementation ttEventTouch


-(id) initWithPoint:(CGPoint)point
{
    return [self initWithPoint:point andPhase:UnknownPhase andSubPhase:UnknownSubPhase andTime:[NSDate date]];
}
-(id) initWithPoint:(CGPoint)point andPhase:(Phase)phase
{
    return [self initWithPoint:point andPhase:phase andSubPhase:UnknownSubPhase andTime:[NSDate date]];
}
-(id) initWithPoint:(CGPoint)point andPhase:(Phase)phase andSubPhase:(SubPhase)subPhase
{
    return [self initWithPoint:point andPhase:phase andSubPhase:subPhase andTime:[NSDate date]];
}
-(id) initWithPoint:(CGPoint)point andPhase:(Phase)phase andSubPhase:(SubPhase)subPhase andTime:(NSDate*)time
{
    self = [super initWithEventType:Touch andPhase:phase andSubPhase:subPhase andTime:time];
    if (self)
    {
        return self;
    }
        
}

@end
