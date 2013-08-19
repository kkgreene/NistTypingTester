//
//  ttEventTouch.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/15/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttEvent.h"

@interface ttEventTouch : ttEvent

@property (nonatomic, assign) CGPoint point;

-(id) initWithPoint:(CGPoint)point;
-(id) initWithPoint:(CGPoint)point andPhase:(Phase)phase;
-(id) initWithPoint:(CGPoint)point andPhase:(Phase)phase andSubPhase:(SubPhase)subPhase;
-(id) initWithPoint:(CGPoint)point andPhase:(Phase)phase andSubPhase:(SubPhase)subPhase andTime:(NSDate*)time;

@end
