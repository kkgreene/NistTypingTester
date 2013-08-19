//
//  ttUtilities.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/7/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttUtilities.h"

@implementation ttUtilities

+(NSString*) documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

+(bool) copySourceFile:(NSString*)source toDestination:(NSString*)destination  shouldOverwrite:(BOOL)overwrite
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError* error;
    if (overwrite == YES)
    {
        [fileManager copyItemAtPath:source toPath:destination error:&error];
    }
    else
    {
        if (![fileManager fileExistsAtPath:destination])
        {
            [fileManager copyItemAtPath:source toPath:destination error:&error];
        }
    }
    return YES;
}

@end
