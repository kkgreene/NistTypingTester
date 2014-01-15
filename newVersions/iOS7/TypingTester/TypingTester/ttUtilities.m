//
//  ttUtilities.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/7/13.
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
        // TODO :: Add error checking
        [fileManager removeItemAtPath:destination error:&error];
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

+(NSString*) stringForOrienatation:(UIInterfaceOrientation)orientation
{
    switch(orientation)
    {
        case UIInterfaceOrientationLandscapeLeft:
            return @"Landscape Left";
            
        case UIInterfaceOrientationLandscapeRight:
            return @"Landscape Right";
            
        case UIInterfaceOrientationPortrait:
            return @"Portrait";
            
        case UIInterfaceOrientationPortraitUpsideDown:
            return @"Portrait (Upside Down)";
            
        default:
            return @"Unknown Orientation";
    }
}

+(NSString*) getProgramVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle]infoDictionary];
    NSString *name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *build = [infoDictionary objectForKey:@"CFBundleVersion"];
    return [NSString stringWithFormat:@"%@ v%@ (build %@)", name, version, build];
}

@end
