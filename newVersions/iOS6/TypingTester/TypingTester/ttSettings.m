//
//  ttSettings.m
//  A singleton object to manage the program settings.
//
//  Created by Matthew Kerr on 8/8/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttSettings.h"
#import "ttConstants.h"
#import "ttUtilities.h"

@implementation ttSettings
{
    
}

static ttSettings *instance = nil;

+(ttSettings*) Instance
{
    static dispatch_once_t _singletonPredicate;
    
    dispatch_once(&_singletonPredicate, ^{ instance = [[self alloc] init];});
    
    return instance;
}

-(id) init
{
    self = [super init];
    if (self)
    {

    }
    return self;
}


#pragma mark DefaultValuesSection

// resets the default values, will not erase any custom settings (yet)
-(void) resetToDefaults
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:ttcStringsForTestDefaultValue forKey:ttcStringsForTestKey];
    [prefs setInteger:ttcEntriesPerTestDefaultValue forKey:ttcEntriesPerTestKey];
    [prefs setInteger:ttcForcedPracticeRoundsDefaultValue forKey:ttcForcedPracticeRoundsKey];
    [prefs setBool:ttcShowQuitButtonDefaultValue forKey:ttcShowQuitButtonKey];
    [prefs setBool:ttcShowSkipButtonDefaultValue forKey:ttcShowQuitButtonKey];
    [prefs setBool:ttcRandomStringOrderDefaultValue forKey:ttcRandomStringOrderKey];
    [prefs setBool:ttcRandomStringSelectionDefaultValue forKey:ttcRandomStringSelectionKey];
    [prefs setObject:ttcQuitStringDefaultValue forKey:ttcQuitStringKey];
    [prefs setInteger:ttcStringOrderSeedDefaultValue forKey:ttcStringOrderSeedKey];
    [prefs setInteger:ttcStringSelectionSeedDefaultValue forKey:ttcStringSelectionSeedKey];
    [prefs setBool:ttcUseRandomStringOrderSeedDefaultValue forKey:ttcUseRandomStringOrderSeedKey];
    [prefs setBool:ttcUseRandomStringSelectionSeedDefaultValue forKey:ttcUseRandomStringSelectionSeedKey];
    [prefs setInteger:ttcSelectedGroupValue forKey:ttcSelectedGroupKey];
    [prefs setObject:[[NSArray alloc]init] forKey:ttcSelectedFiltersKey];
    [prefs setBool:YES forKey:ttcFirstRunKey];
}

#pragma mark Custom setter/getter pairs

-(int) StringsPerSession
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs integerForKey:ttcStringsForTestKey];
}

-(void) setStringsPerSession:(int)StringsPerSession
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:StringsPerSession forKey:ttcStringsForTestKey];
}

-(int) EntriesPerString
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs integerForKey:ttcEntriesPerTestKey];
}

-(void) setEntriesPerString:(int)EntriesPerString
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:EntriesPerString forKey:ttcEntriesPerTestKey];
}

-(int) ForcedPracticeRounds
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs integerForKey:ttcForcedPracticeRoundsKey];
}

-(void) setForcedPracticeRounds:(int)ForcedPracticeRounds
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:ForcedPracticeRounds forKey:ttcForcedPracticeRoundsKey];
}

-(bool) ShowQuitButton
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs boolForKey:ttcShowQuitButtonKey];
}

-(void) setShowQuitButton:(bool)ShowQuitButton
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:ShowQuitButton forKey:ttcShowQuitButtonKey];
}

-(bool) ShowSkipButton
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs boolForKey:ttcShowSkipButtonKey];
}

-(void) setShowSkipButton:(bool)ShowSkipButton
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:ShowSkipButton forKey:ttcShowSkipButtonKey];
}

-(bool) RandomStringOrder
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs boolForKey:ttcRandomStringOrderKey];
}

-(void) setRandomStringOrder:(bool)RandomStringOrder
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:RandomStringOrder forKey:ttcRandomStringOrderKey];
}

-(bool) RandomStringSelection
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs boolForKey:ttcRandomStringSelectionKey];
}

-(void) setRandomStringSelection:(bool)RandomStringSelection
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:RandomStringSelection forKey:ttcRandomStringSelectionKey];
}

-(int) StringOrderSeedKey
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs integerForKey:ttcStringOrderSeedKey];
}

-(void) setStringOrderKey:(int)StringOrderKey
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:StringOrderKey forKey:ttcStringOrderSeedKey];
}

-(int) StringSelectionSeedKey
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs integerForKey:ttcStringSelectionSeedKey];
}

-(void) setStringSelectionKey:(int)StringSelectionKey
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:StringSelectionKey forKey:ttcStringSelectionSeedKey];
}

-(bool) UseRandomStringOrderSeedKey
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs boolForKey:ttcStringOrderSeedKey];
}

-(void) setUseRandomStringOrderSeedKey:(bool)UseRandomStringOrderSeedKey
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:UseRandomStringOrderSeedKey forKey:ttcUseRandomStringOrderSeedKey];
}

-(bool) UseRandomStringSelectionSeedKey
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs boolForKey:ttcStringSelectionSeedKey];
}

-(void)setUseRandomStringSelectionSeedKey:(bool)UseRandomStringSelectionSeedKey
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:UseRandomStringSelectionSeedKey forKey:ttcUseRandomStringSelectionSeedKey];
}

-(NSString*) QuitString
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs stringForKey:ttcQuitStringKey];
    
}

-(void) setQuitString:(NSString *)QuitString
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:QuitString forKey:ttcQuitStringKey];
}

-(NSArray*) SelectedFilters
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs stringArrayForKey:ttcSelectedFiltersKey];
}

-(void) setSelectedFilters:(NSArray *)SelectedFilters
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:SelectedFilters forKey:ttcSelectedFiltersKey];
}

-(int) SelectedGroup
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs integerForKey:ttcSelectedGroupKey];
}

-(void) setSelectedGroup:(int)SelectedGroup
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:SelectedGroup forKey:ttcSelectedGroupKey];
}

-(bool) FirstRun
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs boolForKey:ttcFirstRunKey];
}

-(void) setFirstRun:(bool)FirstRun
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:FirstRun forKey:ttcFirstRunKey];
}


#pragma mark setup functions

+(void) copyInitialFiles
{
    [self copyToDocumentsResourceFileNamed:@"welcome" ofType:@"html" toFileName:@"welcome.html" shouldOverwrite:NO];
    [self copyToDocumentsResourceFileNamed:@"instructionsIphone" ofType:@"html" toFileName:@"instructionsIphone.html" shouldOverwrite:NO];
    [self copyToDocumentsResourceFileNamed:@"instructionsIpad" ofType:@"html" toFileName:@"instructionsIpad.html" shouldOverwrite:NO];
    [self copyToDocumentsResourceFileNamed:@"thankYou" ofType:@"html" toFileName:@"thankYou.html" shouldOverwrite:NO];
    [self copyToDocumentsResourceFileNamed:@"inputStrings" ofType:@"xml" toFileName:@"inputStrings.xml" shouldOverwrite:NO];
}

+(void) copyToDocumentsResourceFileNamed:(NSString*)sourceName ofType:(NSString*)type toFileName:(NSString*)destinationName shouldOverwrite:(BOOL)overwrite
{
    NSString *documentsDirectory = [ttUtilities documentsDirectory];
    NSString *destinationFile = [documentsDirectory stringByAppendingPathComponent:destinationName];
    NSString *sourceFile = [[NSBundle mainBundle] pathForResource:sourceName ofType:type];
    [ttUtilities copySourceFile:sourceFile toDestination:destinationFile shouldOverwrite:overwrite];
}

+(void) resetInitialFiles
{
    [self copyToDocumentsResourceFileNamed:@"welcome" ofType:@"html" toFileName:@"welcome.html" shouldOverwrite:YES];
    [self copyToDocumentsResourceFileNamed:@"instructionsIphone" ofType:@"html" toFileName:@"instructionsIphone.html" shouldOverwrite:YES];
    [self copyToDocumentsResourceFileNamed:@"instructionsIpad" ofType:@"html" toFileName:@"instructionsIpad.html" shouldOverwrite:YES];
    [self copyToDocumentsResourceFileNamed:@"thankYou" ofType:@"html" toFileName:@"thankYou.html" shouldOverwrite:YES];
    [self copyToDocumentsResourceFileNamed:@"inputStrings" ofType:@"xml" toFileName:@"inputStrings.xml" shouldOverwrite:YES];
}



@end
