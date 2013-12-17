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
        _subphaseVisitNumber = 0;
        _currentRound = 0;
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
    
    return [NSString stringWithFormat:@"%@\t%f\t%@\t%@\t%@\t%@\t%i\t%@\t%.0f\t%.0f\t%i\t%i\t%@\t%@\t%@", self.time, self.interval/1000, self.participantNumber, eventType, phase, subphase, self.subphaseVisitNumber, self.targetString, self.point.x, self.point.y, self.location, self.length, self.enteredCharacters, self.currentValue,self.notes];
}

// we override this so we can subsititute in known values for non displayinmg or special characters
-(void)setEnteredCharacters:(NSString *)enteredCharacters
{
    // utf 8 encode entered character
    _enteredCharacters = [enteredCharacters stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //_enteredCharacters = [enteredCharacters stringByReplacingOccurrencesOfString:@" " withString:@"<space>"];
}

+(NSString*)getHeaderLine
{
    return @"Time\tTime Since Session Start\tParticpant Id\tEvent\tPhase\tSubPhase\tSubphase Visit\tTarget String\tX\tY\tLocation\tLength\tCharacters\tCurrent Value\tNotes";
}

@end
