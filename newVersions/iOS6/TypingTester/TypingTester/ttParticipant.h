//
//  ttParticipant.h
//  TypingTester
//
//  Created by Matthew Kerr on 7/31/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ttParticipant;

@protocol ParticipantDelegate <NSObject>

-(void)ttParticipant:(ttParticipant*)participant didEnterPhase:(int)phaseId;
-(void)ttParticipant:(ttParticipant*)participant didLeavePhase:(int)phaseId;
-(void)ttParticipant:(ttParticipant*)participant didEnterStage:(int)stageId;
-(void)ttParticipant:(ttParticipant*)participant didLeaveStage:(int)stageId;

@end

@interface ttParticipant : NSObject


@property (nonatomic, weak) id <ParticipantDelegate> delgate;
@property (nonatomic, copy) NSString *participantNumber;

-(id)initWithParticipantNumber:(NSString*)participantNumber;

-(void)didEnterPhase:(int)phaseId;
-(void)didLeavePhase:(int)phaseId;
-(void)didEnterStage:(int)stageId;
-(void)didLeaveStage:(int)stageId;

@end
