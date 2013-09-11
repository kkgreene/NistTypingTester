//
//  ttEventInput.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/15/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttEventInput.h"

@implementation ttEventInput

-(id) init
{
    return [self initWithPhase:UnknownPhase andSubPhase:UnknownSubPhase atTime:[NSDate date]];
}

-(id) initWithPhase:(Phase)phase
{
    return [self initWithPhase:phase andSubPhase:UnknownSubPhase atTime:[NSDate date]];
}

-(id) initWithPhase:(Phase)phase andSubPhase:(SubPhase)subPhase
{
    return [self initWithPhase:phase andSubPhase:subPhase atTime:[NSDate date]];
}

-(id) initWithPhase:(Phase)phase andSubPhase:(SubPhase)subPhase atTime:(NSDate*)date
{
    self = [super initWithEventType:Input andPhase:phase andSubPhase:subPhase andTime:date];
    if (self)
    {
        
    }
    return self;
}

-(NSString*) description
{
    NSString *eventType = ttcEventTypeStringArray[self.event];
    NSString *phase = ttcPhaseStringArray[self.phase];
    NSString *subphase = ttcSubPhaseStringArray[self.subPhase];
    return [NSString stringWithFormat:@"%@,%f,%@,%@,%@,%@,-1,-1,%i,%i,%@,%@", self.time, self.interval, eventType,
            phase, subphase, self.notes, self.location, self.length, self.enteredCharacters, self.currentValue];
}

@end
