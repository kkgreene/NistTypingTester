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
    return [NSString stringWithFormat:@"%@,%f,%i,%i,%i,%@,-1,-1,-1,-1,,", self.time, self.interval, self.event, self.phase, self.subPhase, self.notes];
}


@end
