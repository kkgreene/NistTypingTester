//
//  ttEvent.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/15/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ttConstants.h"


@interface ttEvent : NSObject

@property (nonatomic, assign) Event event;
@property (nonatomic, assign) Phase phase;
@property (nonatomic, assign) SubPhase subPhase;
@property (nonatomic, copy) NSDate *time;

-(id)initWithEventType:(Event)event;
-(id) initWithEventType:(Event)event andPhase:(Phase)phase;
-(id) initWithEventType:(Event)event andPhase:(Phase)phase andSubPhase:(SubPhase)subPhase;
-(id) initWithEventType:(Event)event andPhase:(Phase)phase andSubPhase:(SubPhase)subPhase andTime:(NSDate*)date;

-(BOOL)writeEventToLog:(NSFileHandle*)fileHandle;

@end
