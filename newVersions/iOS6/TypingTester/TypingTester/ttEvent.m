//
//  ttEvent.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/15/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttEvent.h"

@implementation ttEvent

-(id)init
{
    return [self initWithEventType:UnknownEvent andPhase:UnknownPhase andSubPhase:UnknownSubPhase andTime:[NSDate date]];
}

-(id)initWithEventType:(Event)event
{
    return [self initWithEventType:event andPhase:UnknownPhase andSubPhase:UnknownSubPhase andTime:[NSDate date]];
}

-(id) initWithEventType:(Event)event andPhase:(Phase)phase
{
    return [self initWithEventType:event andPhase:phase andSubPhase:UnknownSubPhase andTime:[NSDate date]];
}

-(id) initWithEventType:(Event)event andPhase:(Phase)phase andSubPhase:(SubPhase)subPhase
{
    return [self initWithEventType:event andPhase:phase andSubPhase:subPhase andTime:[NSDate date]];
}

-(id) initWithEventType:(Event)event andPhase:(Phase)phase andSubPhase:(SubPhase)subPhase andTime:(NSDate*)date
{
    self = [super init];
    if (self)
    {
        _event = event;
        _phase = phase;
        _subPhase = subPhase;
        _time = date;
    }
    return self;
}

-(BOOL)writeEventToLog:(NSFileHandle *)fileHandle
{
    return NO;
}

-(NSString*) description
{
    NSString *eventType = ttcEventTypeStringArray[self.event];
    NSString *phase = ttcPhaseStringArray[self.phase];
    NSString *subphase = ttcSubPhaseStringArray[self.subPhase];
    return [NSString stringWithFormat:@"%@\t%f\t%@\t%@\t%@\t%@\t-1\t-1\t-1\t-1\t\t%@", self.time, self.interval/1000, eventType, phase, subphase, self.targetString, self.notes];
}


@end
