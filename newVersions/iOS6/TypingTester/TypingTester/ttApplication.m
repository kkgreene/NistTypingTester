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
    [super sendEvent:event];
}

@end
