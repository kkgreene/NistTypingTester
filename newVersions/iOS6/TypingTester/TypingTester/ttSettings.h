//
//  ttSettings.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/8/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ttSettings : NSObject
{
    
}

@property (nonatomic, assign) int StringsPerSession;
@property (nonatomic, assign) int EntriesPerString;
@property (nonatomic, assign) int ForcedPracticeRounds;
@property (nonatomic, assign) bool ShowQuitButton;
@property (nonatomic, assign) bool ShowSkipButton;
@property (nonatomic, assign) bool RandomStringOrder;
@property (nonatomic, assign) bool RandomStringSelection;
@property (nonatomic, assign) int StringOrderKey;
@property (nonatomic, assign) int StringSelectionKey;
@property (nonatomic, assign) bool UseRandomStringOrderSeedKey;
@property (nonatomic, assign) bool UseRandomStringSelectionSeedKey;
@property (nonatomic, copy) NSString *QuitString;
@property (nonatomic, assign) int SelectedGroup;
@property (nonatomic, strong) NSArray *SelectedFilters;
@property (nonatomic, assign) bool FirstRun;
@property (nonatomic, assign) bool EnableHideButtonOnPracticeScreen;
@property (nonatomic, assign) int proficiencyGroup;


+(ttSettings*) Instance;

-(void) resetToDefaults;
-(NSDictionary*) getDefaults;

+(void) copyInitialFiles;
+(void) resetInitialFiles;

@end
