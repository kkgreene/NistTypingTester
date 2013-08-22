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
#import "ttSettings.h"
#import "ttInputData.h"

@implementation ttSession
{
    NSFileHandle *rawFileHandle;
    NSFileHandle *summaryFileHandle;
    NSDate *sessionStart;
    NSDate *sessionEnd;
    ttSettings *settings;
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
        settings = [ttSettings Instance];
        // TODO :: Make this work with settings...
        self.proficiencyStrings = [[ttInputData Instance]getPhrasesForGroupId:settings.proficiencyGroup];
        self.entities = [[ttInputData Instance]getEntites];
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
    event.interval = [event.time timeIntervalSinceDate:sessionStart];
    [self.events addObject:event];
    [self writeLineToRawLogFile:[event description]];
    return;
}

-(void) sessionDidFinish
{
    sessionEnd = [NSDate date];
    NSString *startString = [NSString stringWithFormat:@"Session Finished:%@", sessionEnd];
    [self writeLineToSummaryLogFile:startString];
    return;
}

-(void) sessionDidStart
{
    sessionStart = [NSDate date];
    NSString *startString = [NSString stringWithFormat:@"Session Started:%@", sessionStart];
    [self writeLineToSummaryLogFile:startString];
    // TODO :: Write summary session information
    [self writeLineToSummaryLogFile:[NSString stringWithFormat:@"Participant Id:%@", self.participant.participantNumber]];
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
    // write the raw log file header
    [self writeLineToRawLogFile:@"Time,Time Since Session Start,Event,Phase,SubPhase,Notes,X,Y,Location,Length,Characters,Current Value"];
    if (rawFileHandle == nil || summaryFileHandle == nil) return NO;
    return YES;
}

-(void)closeLogFiles
{
    [rawFileHandle closeFile];
    [summaryFileHandle closeFile];
}

-(void) writeLineToRawLogFile:(NSString*)string
{
    NSString *lineToWrite = [NSString stringWithFormat:@"%@\n",string];
    // TODO :: ADD Better error handling
    @try
    {
        [rawFileHandle writeData:[lineToWrite dataUsingEncoding:NSUTF8StringEncoding]];
    }
    @catch (NSException *exception)
    {
        NSLog(@"Error writing data to the log file");
    }
    @finally
    {
    }
}

-(void) writeLineToSummaryLogFile:(NSString*)string
{
    NSString *lineToWrite = [NSString stringWithFormat:@"%@\n",string];
    // TODO :: ADD Better error handling
    @try
    {
        [summaryFileHandle writeData:[lineToWrite dataUsingEncoding:NSUTF8StringEncoding]];
    }
    @catch (NSException *exception)
    {
        NSLog(@"Error writing data to the log file");
    }
    @finally
    {
        
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
