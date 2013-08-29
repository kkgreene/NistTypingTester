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
#import "ttTestEntity.h"

@implementation ttSession
{
    NSFileHandle *rawFileHandle;
    NSFileHandle *summaryFileHandle;
    NSDate *sessionEnd;
    ttSettings *settings;
    NSDate *sessionStartTime;
    NSDate *phaseStartTime;
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
        self.currentPhase = UnknownPhase;
        self.currentSubPhase = UnknownSubPhase;
        self.participant = [[ttParticipant alloc]initWithParticipantNumber:participantId];
        self.events = [[NSMutableArray alloc]init];
        if ([self initializeLogFiles] == NO)
        {
            // TODO :: Add error handling
        }
        settings = [ttSettings Instance];
        [self loadProficiencyGroups];
        [self loadEntities];
        [self sessionDidStart];
        [[UIApplication sharedApplication] setValue:self forKey:@"session"];
    }
    return self;
}

-(void)dealloc
{
    [self sessionDidFinish];
}

-(void) loadEntities
{
    self.entities = [[ttInputData Instance]getEntities];
}

-(void) loadProficiencyGroups
{
     self.proficiencyStrings = [[ttInputData Instance]getPhrasesForGroupId:settings.proficiencyGroup];
}

#pragma mark - Lifecycle Events
-(void) sessionDidStart
{
    sessionStartTime = [NSDate date];
    NSString *startString = [NSString stringWithFormat:@"Session Started:%@", sessionStartTime];
    [self writeLineToSummaryLogFile:startString];
    // TODO :: Write summary session information
    [self writeLineToSummaryLogFile:[NSString stringWithFormat:@"Participant Id:%@", self.participant.participantNumber]];
    phaseStartTime = [NSDate date];
    [self writeLineToSummaryLogFile:[settings getSettings]];
    // write out strings
    [self writeLineToSummaryLogFile:@"Entities for session:"];
    for(int i = 0; i < self.entities.count; i++)
    {
        ttTestEntity *entity = [self.entities objectAtIndex:i];
        [self writeLineToSummaryLogFile:entity.entityString];
    }
    [self writeLineToSummaryLogFile:@"End entity list"];
    return;
}

-(void)enteredPhase:(Phase)phase withNote:(NSString*)note
{
    // only log if we are not in current phase
    if (phase != self.currentPhase)
    {
        ttEvent *event = [[ttEvent alloc]initWithEventType:PhaseBegin andPhase:phase];
        event.notes = note;
        [self addEvent:event];
        
        NSString *line = [NSString stringWithFormat:@"Started Phase:%@ : %@", ttcPhaseStringArray[phase], note];
        [self writeLineToSummaryLogFile:line];
        
        self.currentPhase = phase;
        phaseStartTime = [NSDate date];
    }
}

-(void)leftPhase:(Phase)phase withNote:(NSString*)note
{
    ttEvent *event = [[ttEvent alloc]initWithEventType:PhaseEnd andPhase:phase];
    event.notes = note;
    [self addEvent:event];
    self.currentPhase = UnknownPhase;
    self.currentSubPhase = UnknownSubPhase;
    NSDate *now = [NSDate date];
    NSString *line = [NSString stringWithFormat:@"Leaving Phase %@, overall time in phase:%f : %@", ttcPhaseStringArray[phase], [now timeIntervalSinceDate:phaseStartTime], note];
    [self writeLineToSummaryLogFile:line];
}

-(void)enteredSubPhase:(SubPhase)subphase withNote:(NSString*)note
{
    if (subphase != self.currentSubPhase)
    {
        ttEvent *event = [[ttEvent alloc]initWithEventType:SubPhaseChange andPhase:self.currentPhase andSubPhase:subphase];
        event.notes = note;
        [self addEvent:event];
        self.currentSubPhase = subphase;
    }
}

-(void)enteredProficiencyPhase
{
    self.proficiencyStrings = [[ttInputData Instance]getPhrasesForGroupId:settings.proficiencyGroup];
    self.currentProficiencyString = 0;
}

-(void) sessionDidFinish
{
    sessionEnd = [NSDate date];
    [[UIApplication sharedApplication] setValue:nil forKey:@"session"];
    NSString *startString = [NSString stringWithFormat:@"Session Finished:%@", sessionEnd];
    [self writeLineToSummaryLogFile:startString];
    [self closeLogFiles];
    return;
}

-(void) moveToNextEntity
{
    self.currentEntity++;
    self.CurrentPracticeRoundForEntity = 0;
    self.currentEntryForEntity = 0;
    self.workAreaContents = @"";
    ttEvent *event = [[ttEvent alloc]initWithEventType:SubPhaseChange andPhase:Entry andSubPhase:EntityChange];
    ttTestEntity *entity = [self.entities objectAtIndex:self.currentEntity];
    event.notes = [NSString stringWithFormat:@"Moving to Entity:%@", entity.entityString];
}

#pragma -mark Log Functions

-(void) addEvent:(ttEvent *)event
{
    event.interval = [event.time timeIntervalSinceDate:sessionStartTime];
    [self.events addObject:event];
    [self writeLineToRawLogFile:[event description]];
    return;
}


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
