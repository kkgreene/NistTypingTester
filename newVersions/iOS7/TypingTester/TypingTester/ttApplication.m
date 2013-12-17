//
//  ttApplication.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/20/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttApplication.h"
#import "ttConstants.h"
#import "ttEvent.h"
#import "ttSession.h"
#import "ttKeyHitDetector.h"

@implementation ttApplication
{
    bool keyboardVisible;
    KeyboardMode currentKeyboardMode;
}


-(void)sendEvent:(UIEvent *)event
{
    UITouch* lastTouch;
    
    // Check to see if this was  a touch event
    for(UITouch* touch in event.allTouches)
    {
        lastTouch = touch;
    }
    // do we have a ending touch event?
    if(lastTouch != nil && lastTouch.phase == UITouchPhaseEnded)
    {
        // get the point for the touch:
        CGPoint touchPoint = [lastTouch locationInView:nil];
        
        // was the keyboard visible during the touch?
        if (keyboardVisible)
        {
            ttEvent *event;
            switch([self getKeyPressedAtPoint:touchPoint])
            {
                case SpecialKeyShift:
                    // log event
                    event = [[ttEvent alloc]initWithEventType:SpecialKeyPressed andPhase:self.session.currentPhase andSubPhase:self.session.currentSubPhase];
                    event.point = touchPoint;
                    event.notes = [NSString stringWithFormat:@"Left Shift Key Pressed at %.0f:%.0f", touchPoint.x, touchPoint.y];
                    [self.session addEvent:event];
                    break;
                    
                case SpecialKeyShiftRight:
                    // log event
                    event = [[ttEvent alloc]initWithEventType:SpecialKeyPressed andPhase:self.session.currentPhase andSubPhase:self.session.currentSubPhase];
                    event.point = touchPoint;
                    event.notes = [NSString stringWithFormat:@"Right Shift Key Pressed at %.0f:%.0f", touchPoint.x, touchPoint.y];
                    [self.session addEvent:event];
                    break;
                    
                
                case SpecialKeyKeyboardChange:
                    // log event
                    event = [[ttEvent alloc]initWithEventType:SpecialKeyPressed andPhase:self.session.currentPhase andSubPhase:self.session.currentSubPhase];
                    event.point = touchPoint;
                    event.notes = [NSString stringWithFormat:@"Left Keyboard Change Key Pressed at %.0f:%.0f", touchPoint.x, touchPoint.y];
                    [self.session addEvent:event];
                    break;
                    
                case SpecialKeyKeyboardChangeRight:
                    // log event
                    event = [[ttEvent alloc]initWithEventType:SpecialKeyPressed andPhase:self.session.currentPhase andSubPhase:self.session.currentSubPhase];
                    event.point = touchPoint;
                    event.notes = [NSString stringWithFormat:@"Right Keyboard Change Key Pressed at %.0f:%.0f", touchPoint.x, touchPoint.y];
                    [self.session addEvent:event];
                    break;
                    
                case SpecialKeyDelete:
                    // log event
                    event = [[ttEvent alloc]initWithEventType:SpecialKeyPressed andPhase:self.session.currentPhase andSubPhase:self.session.currentSubPhase];
                    event.point = touchPoint;
                    event.notes = [NSString stringWithFormat:@"Delete Key Pressed at %.0f:%.0f", touchPoint.x, touchPoint.y];
                    [self.session addEvent:event];
                    break;
                    
                case SpecialKeyReturn:
                    // log event
                    event = [[ttEvent alloc]initWithEventType:SpecialKeyPressed andPhase:self.session.currentPhase andSubPhase:self.session.currentSubPhase];
                    event.point = touchPoint;
                    event.notes = [NSString stringWithFormat:@"Return Key Pressed at %.0f:%.0f", touchPoint.x, touchPoint.y];
                    [self.session addEvent:event];
                    break;
                    
                case SpecialKeyHideKeyboard:
                    // log event
                    event = [[ttEvent alloc]initWithEventType:SpecialKeyPressed andPhase:self.session.currentPhase andSubPhase:self.session.currentSubPhase];
                    event.point = touchPoint;
                    event.notes = [NSString stringWithFormat:@"Hide Keyboard Key Pressed at %.0f:%.0f", touchPoint.x, touchPoint.y];
                    [self.session addEvent:event];
                    break;
                    
                case SpecialKeyUndo:
                    // log event
                    event = [[ttEvent alloc]initWithEventType:SpecialKeyPressed andPhase:self.session.currentPhase andSubPhase:self.session.currentSubPhase];
                    event.point = touchPoint;
                    event.notes = [NSString stringWithFormat:@"Undo/Redo Key Pressed at %.0f:%.0f", touchPoint.x, touchPoint.y];
                    [self.session addEvent:event];
                    break;
                
                case SpecialKeyNone:
                default:
                    event = [[ttEvent alloc]initWithEventType:KeyboardTouch andPhase:self.session.currentPhase andSubPhase:self.session.currentSubPhase];
                    event.point = touchPoint;
                    event.notes = [NSString stringWithFormat:@"Keyboard Touch event at %.0f:%.0f", touchPoint.x, touchPoint.y];
                    [self.session addEvent:event];
                    break;
            }
        }
        else
        {
            ttEvent *event;
            event = [[ttEvent alloc]initWithEventType:KeyboardTouch andPhase:self.session.currentPhase andSubPhase:self.session.currentSubPhase];
            event.point = touchPoint;
            event.notes = [NSString stringWithFormat:@"Keyboard Touch event at %.0f:%.0f", touchPoint.x, touchPoint.y];
            [self.session addEvent:event];
        }
    }
    [super sendEvent:event];
}

-(SpecialKey)getKeyPressedAtPoint:(CGPoint)point
{
    return [[ttKeyHitDetector Instance]GetKeyAtPoint:point];
}

-(void)determineKeyboardStateAfterKeyPress:(SpecialKey)key
{
    // this will try to keep track of the keyboard state
    switch(currentKeyboardMode)
    {
        case Alphabetic:
            if (key == SpecialKeyKeyboardChange)
            {
                currentKeyboardMode = Numeric;
            }
            break;
            
        case Numeric:
            if (key == SpecialKeyShift)
            {
                currentKeyboardMode = Symbol;
            }
            else if (key == SpecialKeyKeyboardChange)
            {
                currentKeyboardMode = Alphabetic;
            }
            break;
            
        case Symbol:
            if (key == SpecialKeyShift)
            {
                currentKeyboardMode = Numeric;
            }
            else if (key == SpecialKeyKeyboardChange)
            {
                currentKeyboardMode = Alphabetic;
            }
            break;
            
        default:
            break;
    }
}


// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    keyboardVisible = YES;
    ttEvent *event = [[ttEvent alloc]initWithEventType:KeyboardShown andPhase:self.session.currentPhase andSubPhase:self.session.currentSubPhase];
    event.notes = @"Keyboard shown";
    [self.session addEvent:event];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasHidden:(NSNotification*)aNotification
{
    keyboardVisible = NO;
    ttEvent *event = [[ttEvent alloc]initWithEventType:KeyboardHidden andPhase:self.session.currentPhase andSubPhase:self.session.currentSubPhase];
    event.notes = @"Keyboard hidden";
    [self.session addEvent:event];
}

@end
