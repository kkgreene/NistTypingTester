//
//  ttSession.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/13/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ttConstants.h"

@class ttParticipant;
@class ttSession;
@class ttEvent;

@protocol SessionDelegate <NSObject>


@end

@interface ttSession : NSObject


@property (nonatomic, weak) id <SessionDelegate> delegate;
@property (nonatomic, strong) ttParticipant *participant;
@property (nonatomic, strong) NSMutableArray* events;

@property (nonatomic, assign) int currentProficiencyString;
@property (nonatomic, assign) int currentEntity;
@property (nonatomic, assign) int currentEntryForEntity;
@property (nonatomic, strong) NSArray *proficiencyStrings;
@property (nonatomic, strong) NSArray *entities;
@property (nonatomic, assign) int CurrentPracticeRoundForEntity;

@property (nonatomic, copy) NSString* workAreaContents;
@property (nonatomic, assign) Phase currentPhase;
@property (nonatomic, assign) SubPhase currentSubPhase;


-(id)initWithParticipantId:(NSString*)participantId;

-(void)sessionDidStart;
-(void)sessionDidFinish;

-(void)enteredPhase:(Phase)phase withNote:(NSString*)note;
-(void)leftPhase:(Phase)phase withNote:(NSString*)note;
-(void)enteredSubPhase:(SubPhase)subphase withNote:(NSString*)note;

-(void)enteredProficiencyPhase;
-(void)nextEntity;

-(void)addEvent:(ttEvent*)event;

-(BOOL)initializeLogFiles;
-(void)closeLogFiles;
-(void) writeLineToRawLogFile:(NSString*)string;
-(void) writeLineToSummaryLogFile:(NSString*)string;

@end
