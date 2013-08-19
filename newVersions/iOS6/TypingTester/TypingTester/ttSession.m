//
//  ttSession.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/13/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttSession.h"
#import "ttParticipant.h"
#import "ttEvent.h"

@implementation ttSession



-(id) initWithParticipantId:(NSString *)participantId
{
    self = [super init];
    if (self)
    {
        self.participant = [[ttParticipant alloc]initWithParticipantNumber:participantId];
        self.events = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void) addEvent:(ttEvent *)event
{
    [self.events addObject:event];
    return;
}

@end
