//
//  ttConstants.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/8/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

NSString *const ttcStringsForTestKey = @"StringsForTest";
NSString *const ttcEntriesPerTestKey = @"EntriesPerTest";
NSString *const ttcForcedPracticeRoundsKey = @"ForcedPracticeRounds";
NSString *const ttcShowQuitButtonKey = @"ShowQuitButton";
NSString *const ttcShowSkipButtonKey = @"ShowSkipButton";
NSString *const ttcRandomStringOrderKey = @"RandomStringOrder";
NSString *const ttcRandomStringSelectionKey = @"RandomStringSelection";
NSString *const ttcQuitStringKey = @"QuitString";
NSString *const ttcStringOrderSeedKey = @"StringOrderSeed";
NSString *const ttcStringSelectionSeedKey = @"StringSelectionSeed";
NSString *const ttcUseRandomStringOrderSeedKey = @"UseRandomStringOrderSeed";
NSString *const ttcUseRandomStringSelectionSeedKey = @"UseRandomStringSelectionSeed";
NSString *const ttcSelectedFiltersKey = @"SelectedFilters";
NSString *const ttcSelectedGroupKey = @"SelectedGroup";
NSString *const ttcFirstRunKey = @"FirstRun";
NSString *const ttcEnableHideButtonOnPracticeScreenKey = @"EnableHideButtonOnPracticeScreen";
NSString *const ttcProficiencyGroupKey = @"ProficiencyGroup";

const int ttcStringsForTestDefaultValue = 10;
const int ttcEntriesPerTestDefaultValue = 10;
const int ttcForcedPracticeRoundsDefaultValue = 3;
const int ttcStringOrderSeedDefaultValue = 1;
const int ttcStringSelectionSeedDefaultValue = 1;
const int ttcSelectedGroupValue = 1;
const int ttcProficiencyGroupValue = 1;

const bool ttcShowQuitButtonDefaultValue = NO;
const bool ttcShowSkipButtonDefaultValue = NO;
const bool ttcRandomStringOrderDefaultValue = NO;
const bool ttcRandomStringSelectionDefaultValue = NO;
const bool ttcUseRandomStringOrderSeedDefaultValue = NO;
const bool ttcUseRandomStringSelectionSeedDefaultValue = NO;
const bool ttcEnableHideButtonOnPracticeScreenValue = NO;

NSString *const ttcQuitStringDefaultValue = @"I QUIT";


NSString *const ttcPhaseStringArray[] = {@"Unknown Phase", @"Proficiency Phase", @"Introduction Phase", @"Memorize Phase",
                                         @"Entry Phase", @"Recall Phase", @"Thank You Phase"};
NSString *const ttcSubPhaseStringArray[] = {@"Unknown SubPhase", @"Free Practice", @"Forced Practice", @"Verify", @"Entity Change", @"None"};
NSString *const ttcEventTypeStringArray[] = {@"Unknown Event", @"Input", @"Phase Begin", @"Phase End", @"Touch", @"Sub Phase Change",
                                             @"Proficiency String Shown", @"Entity Displayed", @"Control Activated", @"Special Key Pressed",
                                             @"Orientation Change", @"Keyboard Shown", @"Keyboard Hidden", @"Keyboard Touch", @"Incorrect Value Entered",
                                             @"Correct Value Entered"};
NSString *const ttcSpecialKeyStringArray[] = {@"Unknown Key", @"Shift Key", @"Keyboard Change Key"};
NSString *const ttcKeyboardModeStringArray[] = {@"Alphabetic", @"Numeric", @"Symbol", @"Unknown"};


// hitbox for special key detection
CGRect const ttcHitboxShiftKeyIos6Portrait = { {0,375}, {49,49} };
CGRect const ttcHitboxSwitchKeyIos6Portrait = { {0,425}, {79,49} };
CGRect const ttcHitboxShiftKeyIos6Landscape = { {0,244}, {65,37} };
CGRect const ttcHitboxSwitchKeyIos6Landscape = { {0,283}, {95,37} };
CGRect const ttcHitboxShiftKeyIos7Portrait = { {0,375}, {49,49} };
CGRect const ttcHitboxSwitchKeyIos7Portrait = { {0,425}, {79,49} };
CGRect const ttcHitboxShiftKeyIos7Landscape = { {0,244}, {65,37} };
CGRect const ttcHitboxSwitchKeyIos7Landscape = { {0,283}, {95,37} };

CGRect const ttcHitboxShiftKeyIos6Portrait_iPad = { {0,896}, {66,62} };
CGRect const ttcHitboxShiftKey2Ios6Portrait_iPad = { {685,896}, {83,62} };
CGRect const ttcHitboxSwitchKeyIos6Portrait_iPad = { {0,959}, {200,62} };
CGRect const ttcHitboxSwitchKey2Ios6Portrait_iPad = { {612,961}, {88,59} };
CGRect const ttcHitboxShiftKeyIos6Landscape_iPad = { {0,595}, {88,84} };
CGRect const ttcHitboxShiftKey2Ios6Landscape_iPad = { {908,595}, {116,84} };
CGRect const ttcHitboxSwitchKeyIos6Landscape_iPad = { {0,680}, {270,88} };
CGRect const ttcHitboxSwitchKey2Ios6Landscape_iPad = { {816,680}, {116,88} };
CGRect const ttcHitboxShiftKeyIos7Portrait_iPad = { {0,896}, {66,62} };
CGRect const ttcHitboxShiftKey2Ios7Portrait_iPad = { {685,896}, {83,62} };
CGRect const ttcHitboxSwitchKeyIos7Portrait_iPad = { {0,959}, {200,62} };
CGRect const ttcHitboxSwitchKey2Ios7Portrait_iPad = { {612,961}, {88,59} };
CGRect const ttcHitboxShiftKeyIos7Landscape_iPad = { {0,595}, {88,84} };
CGRect const ttcHitboxShiftKey2Ios7Landscape_iPad = { {908,595}, {116,84} };
CGRect const ttcHitboxSwitchKeyIos7Landscape_iPad = { {0,680}, {270,88} };
CGRect const ttcHitboxSwitchKey2Ios7Landscape_iPad = { {816,680}, {116,88} };

CGRect const ttcHitBoxNull = { {0,0},{0,0} };