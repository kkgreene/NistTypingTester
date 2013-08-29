//
//  ttApplication.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/20/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttApplication.h"
#import "ttConstants.h"

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
            switch([self getKeyPressedAtPoint:touchPoint])
            {
                case SpecialKeyShift:
                    // log event
                    NSLog(@"Shift Key Pressed at %3f, %3f", touchPoint.x, touchPoint.y);
                    break;
                
                case SpecialKeyKeyboardChange:
                    // log event
                    NSLog(@"Keyboard Change Key Pressed at %3f,%3f", touchPoint.x, touchPoint.y);
                    break;
                
                case SpecialKeyUnknown:
                default:
                    NSLog(@"Unidentified key pressed at point %3f,%3f", touchPoint.x, touchPoint.y);
                    break;
            }
        }
        else
        {
            NSLog(@"Touch event detected by UIApplication");
        }
    }
    [super sendEvent:event];
}

-(SpecialKey)getKeyPressedAtPoint:(CGPoint)point
{
    // this will try to figure out if a special key is pressed based on coordinates
    // determine the current version of iOS in order to get hitboxes
    // determine the current orientation to get hitboxes
    // see if the point is in one of the hitboxes
    CGRect shiftKeyHitbox = ttcHitboxShiftKeyIos6Portrait;
    CGRect switchKeyHitbox = ttcHitboxSwitchKeyIos6Portrait;
    
    if (CGRectContainsPoint(shiftKeyHitbox, point)) return SpecialKeyShift;
    if (CGRectContainsPoint(switchKeyHitbox, point)) return SpecialKeyKeyboardChange;
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
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasHidden:(NSNotification*)aNotification
{
    keyboardVisible = NO;
}

@end
