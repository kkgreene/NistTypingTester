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
    return [NSString stringWithFormat:@"%@,%f,%i,%i,%i,%@,-1,-1,%i,%i,%@,%@", self.time, self.interval, self.event,
            self.phase, self.subPhase, self.notes, self.location, self.length, self.enteredCharacters, self.currentValue];
}

@end
