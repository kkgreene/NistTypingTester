//
//  ttSession.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/13/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ttParticipant;
@class ttSession;
@class ttEvent;

@protocol SessionDelegate <NSObject>


@end

@interface ttSession : NSObject


@property (nonatomic, weak) id <SessionDelegate> delegate;
@property (nonatomic, strong) ttParticipant *participant;
@property (nonatomic, strong) NSMutableArray* events;

-(id)initWithParticipantId:(NSString*)participantId;

-(void)sessionDidStart;
-(void)sessionDidFinish;

-(void)addEvent:(ttEvent*)event;

-(BOOL)initializeLogFiles;
-(void)closeLogFiles;
-(void) writeString:(NSString*)string toLogFile:(NSFileHandle*)logFile;

@end
