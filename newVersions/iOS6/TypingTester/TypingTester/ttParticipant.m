//
//  ttParticipant.m
//  TypingTester
//
//  Created by Matthew Kerr on 7/31/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttParticipant.h"
#import "ttUtilities.h"

@implementation ttParticipant
{
    
}

-(id) init
{
    self = [super init];
    if(self)
    {
        self.participantNumber = @"";
    }
    return self;
}

-(id) initWithParticipantNumber:(NSString*)participantNumber
{
    self = [super init];
    if (self)
    {
        self.participantNumber = participantNumber;
    }
    return self;
}

-(NSString*) dataFilePath
{
    NSString* filename = [NSString stringWithFormat:@"%@-session.raw", self.participantNumber];
    return [[ttUtilities documentsDirectory] stringByAppendingPathComponent:filename];
}



@end
