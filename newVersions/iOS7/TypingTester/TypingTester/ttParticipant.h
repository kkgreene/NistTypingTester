//
//  ttParticipant.h
//  TypingTester
//
//  Created by Matthew Kerr on 7/31/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ttParticipant;


@interface ttParticipant : NSObject


@property (nonatomic, copy) NSString *participantNumber;

-(id)initWithParticipantNumber:(NSString*)participantNumber;


@end
