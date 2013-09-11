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
        self.point = point;
    }
    return self;
}

-(NSString*)description
{
    NSString *eventType = ttcEventTypeStringArray[self.event];
    NSString *phase = ttcPhaseStringArray[self.phase];
    NSString *subphase = ttcSubPhaseStringArray[self.subPhase];
    return [NSString stringWithFormat:@"%@,%f,%@,%@,%@,%@,%f,%f,-1,-1,,", self.time, self.interval, eventType,
            phase, subphase, self.notes, self.point.x, self.point.y];
}

@end
