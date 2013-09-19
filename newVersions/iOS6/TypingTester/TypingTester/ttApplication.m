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
                    event.notes = [NSString stringWithFormat:@"Shift Key Pressed at %.0f:%.0f", touchPoint.x, touchPoint.y];
                    [self.session addEvent:event];
                    //NSLog(@"Shift Key Pressed at %3f, %3f", touchPoint.x, touchPoint.y);
                    break;
                
                case SpecialKeyKeyboardChange:
                    // log event
                    event = [[ttEvent alloc]initWithEventType:SpecialKeyPressed andPhase:self.session.currentPhase andSubPhase:self.session.currentSubPhase];
                    event.point = touchPoint;
                    event.notes = [NSString stringWithFormat:@"Keyboard Change Key Pressed at %.0f:%.0f", touchPoint.x, touchPoint.y];
                    [self.session addEvent:event];
                    //NSLog(@"Keyboard Change Key Pressed at %3f,%3f", touchPoint.x, touchPoint.y);
                    break;
                
                case SpecialKeyUnknown:
                default:
                    event = [[ttEvent alloc]initWithEventType:KeyboardTouch andPhase:self.session.currentPhase andSubPhase:self.session.currentSubPhase];
                    event.point = touchPoint;
                    event.notes = [NSString stringWithFormat:@"Touch event at %.0f:%.0f", touchPoint.x, touchPoint.y];
                    [self.session addEvent:event];
                    //NSLog(@"Unidentified key pressed at point %3f,%3f", touchPoint.x, touchPoint.y);
                    break;
            }
        }
        else
        {
            ttEvent *event;
            event = [[ttEvent alloc]initWithEventType:KeyboardTouch andPhase:self.session.currentPhase andSubPhase:self.session.currentSubPhase];
            event.point = touchPoint;
            event.notes = [NSString stringWithFormat:@"Touch event at %.0f:%.0f", touchPoint.x, touchPoint.y];
            [self.session addEvent:event];
        }
    }
    [super sendEvent:event];
}

-(SpecialKey)getKeyPressedAtPoint:(CGPoint)point
{
    // this will try to figure out if a special key is pressed based on coordinates
    CGRect shiftKeyHitbox;
    CGRect switchKeyHitbox;
    CGRect shiftKey2Hitbox = ttcHitBoxNull;
    CGRect switchKey2Hitbox = ttcHitBoxNull;
    // determine the current device family
    // determine the current orientation
    BOOL isLandscape = NO;
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication]statusBarOrientation]))
    {
        isLandscape = YES;
    }
    
    NSString *iosVersion = [[UIDevice currentDevice]systemVersion];
    
    switch(UI_USER_INTERFACE_IDIOM())
    {
        case UIUserInterfaceIdiomPad: 
            if ([iosVersion hasPrefix:@"6."]) // ios 6
            {
                if (isLandscape)
                {
                    shiftKeyHitbox = ttcHitboxShiftKeyIos6Landscape_iPad;
                    switchKeyHitbox = ttcHitboxSwitchKeyIos6Landscape_iPad;
                    shiftKey2Hitbox = ttcHitboxShiftKey2Ios6Landscape_iPad;
                    switchKey2Hitbox = ttcHitboxSwitchKey2Ios6Landscape_iPad;
                }
                else
                {
                    shiftKeyHitbox = ttcHitboxShiftKeyIos6Portrait_iPad;
                    switchKeyHitbox = ttcHitboxSwitchKeyIos6Portrait_iPad;
                    shiftKey2Hitbox = ttcHitboxShiftKey2Ios6Portrait_iPad;
                    switchKey2Hitbox = ttcHitboxSwitchKey2Ios6Portrait_iPad;
                }
            }
            else if ([iosVersion hasPrefix:@"7."]) // ios 7
            {
                if (isLandscape)
                {
                    shiftKeyHitbox = ttcHitboxShiftKeyIos7Landscape_iPad;
                    switchKeyHitbox = ttcHitboxSwitchKeyIos7Landscape_iPad;
                }
                else
                {
                    shiftKeyHitbox = ttcHitboxShiftKeyIos7Portrait_iPad;
                    switchKeyHitbox = ttcHitboxSwitchKeyIos7Portrait_iPad;
                }
            }
            break;
            
        case UIUserInterfaceIdiomPhone:
            if ([iosVersion hasPrefix:@"6."]) // ios 6
            {
                if (isLandscape)
                {
                    shiftKeyHitbox = ttcHitboxShiftKeyIos6Landscape;
                    switchKeyHitbox = ttcHitboxSwitchKeyIos6Landscape;
                }
                else
                {
                    shiftKeyHitbox = ttcHitboxShiftKeyIos6Portrait;
                    switchKeyHitbox = ttcHitboxSwitchKeyIos6Portrait;
                }
            }
            else if ([iosVersion hasPrefix:@"7."]) // ios 7
            {
                if (isLandscape)
                {
                    shiftKeyHitbox = ttcHitboxShiftKeyIos7Landscape;
                    switchKeyHitbox = ttcHitboxSwitchKeyIos7Landscape;
                }
                else
                {
                    shiftKeyHitbox = ttcHitboxShiftKeyIos7Portrait;
                    switchKeyHitbox = ttcHitboxSwitchKeyIos7Portrait;
                }
            }
            break;
    }
    if (CGRectContainsPoint(shiftKeyHitbox, point) || CGRectContainsPoint(shiftKey2Hitbox, point)) return SpecialKeyShift;
    if (CGRectContainsPoint(switchKeyHitbox, point) || CGRectContainsPoint(switchKey2Hitbox, point)) return SpecialKeyKeyboardChange;
    return SpecialKeyUnknown;
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
