//
//  ttApplication.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/20/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttApplication.h"

@implementation ttApplication

-(void)sendEvent:(UIEvent *)event
{
    NSLog(@"UIApplication send event:%@", event.description);
    UITouch* lastTouch;
    
    // Check to see if this was  a touch event
    for(UITouch* touch in event.allTouches)
    {
        lastTouch = touch;
    }
    if(lastTouch != nil)
    {
        NSLog(@"Touch event detected by UIApplication:%@", lastTouch);
        // figure out the cooridinates of the touch
        // determine if a special key was pressed
    }
    [super sendEvent:event];
}


@end