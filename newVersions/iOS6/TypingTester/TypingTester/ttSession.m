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
#import "ttUtilities.h"

@implementation ttSession
{
    NSFileHandle *rawFileHandle;
    NSFileHandle *summaryFileHandle;
}

-(id) init
{
    return [self initWithParticipantId:@"000000000"];
}

-(id) initWithParticipantId:(NSString *)participantId
{
    self = [super init];
    if (self)
    {
        self.participant = [[ttParticipant alloc]initWithParticipantNumber:participantId];
        self.events = [[NSMutableArray alloc]init];
        [self initializeLogFiles];
        [self sessionDidStart];
    }
    return self;
}

-(void)dealloc
{
    [self sessionDidFinish];
    [self closeLogFiles];
}

-(void) addEvent:(ttEvent *)event
{
    [self.events addObject:event];
    return;
}

-(void) sessionDidFinish
{
    NSString *startString = [NSString stringWithFormat:@"Session Finished:%@", [NSDate date]];
    [self writeString:startString toLogFile:summaryFileHandle];
    return;
}

-(void) sessionDidStart
{
    NSString *startString = [NSString stringWithFormat:@"Session Started:%@", [NSDate date]];
    [self writeString:startString toLogFile:summaryFileHandle];
    return;

}

#pragma -mark Log Functions
-(BOOL)initializeLogFiles
{
    NSString *rawFileName = [NSString stringWithFormat:@"%@-raw.txt",self.participant.participantNumber];
    NSString *summaryFileName = [NSString stringWithFormat:@"%@-summary.txt", self.participant.participantNumber];
    NSString *rawLogFile = [[ttUtilities documentsDirectory] stringByAppendingPathComponent:rawFileName];
    NSString *summaryLogFile = [[ttUtilities documentsDirectory] stringByAppendingPathComponent:summaryFileName];
    rawFileHandle = [self createLogfile:rawLogFile];
    summaryFileHandle = [self createLogfile:summaryLogFile];
    if (rawFileHandle == nil || summaryFileHandle == nil) return NO;
    return YES;
}

-(void)closeLogFiles
{
    [rawFileHandle closeFile];
    [summaryFileHandle closeFile];
}

-(void) writeString:(NSString*)string toLogFile:(NSFileHandle*)logFile;
{
    @try
    {
        [logFile writeData:[string dataUsingEncoding:NSUTF8StringEncoding]];
    }
    @catch (NSException *e)
    {
        NSLog(@"Error writing data to the log file");
    }
}

-(NSFileHandle*) createLogfile:(NSString*)logfileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError* error;
    if ([fileManager fileExistsAtPath:logfileName])
    {
        [fileManager removeItemAtPath:logfileName error:&error];
    }
    [fileManager createFileAtPath:logfileName contents:nil attributes:nil];
    return [NSFileHandle fileHandleForWritingAtPath:logfileName];
}

@end
