//
//  ttEventInput.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/15/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttEvent.h"

@interface ttEventInput : ttEvent

@property (nonatomic, assign) int location;
@property (nonatomic, assign) int length;
@property (nonatomic, copy) NSString *enteredCharacters;
@property (nonatomic, copy) NSString *currentValue;

-(id) init;
-(id) initWithPhase:(Phase)phase;
-(id) initWithPhase:(Phase)phase andSubPhase:(SubPhase)subPhase;
-(id) initWithPhase:(Phase)phase andSubPhase:(SubPhase)subPhase atTime:(NSDate*)date;
@end
