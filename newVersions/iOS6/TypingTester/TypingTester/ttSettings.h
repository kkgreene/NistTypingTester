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

@property (nonatomic, assign) int entitiesPerSession;
@property (nonatomic, assign) int entriesPerEntitiy;
@property (nonatomic, assign) int forcedPracticeRounds;
@property (nonatomic, assign) bool showQuitButton;
@property (nonatomic, assign) bool showSkipButton;
@property (nonatomic, assign) bool randomStringOrder;
@property (nonatomic, assign) bool randomStringSelection;
@property (nonatomic, assign) int stringOrderSeed;
@property (nonatomic, assign) int stringSelectionSeed;
@property (nonatomic, assign) bool useRandomStringOrderSeed;
@property (nonatomic, assign) bool useRandomStringSelectionSeed;
@property (nonatomic, copy) NSString *quitString;
@property (nonatomic, assign) bool useGroupId;
@property (nonatomic, assign) int selectedGroup;
@property (nonatomic, copy) NSArray *selectedFilters;
@property (nonatomic, copy) NSArray *excludedFilters;
@property (nonatomic, assign) bool firstRun;
@property (nonatomic, assign) bool enableHideButtonOnPracticeScreen;
@property (nonatomic, assign) bool enableSkipButton;
@property (nonatomic, assign) bool enableQuitButton;
@property (nonatomic, assign) int  proficiencyGroup;

@property (nonatomic, assign) unsigned int effectiveOrderSeed;
@property (nonatomic, assign) unsigned int effectiveSelectionSeed;

@property (nonatomic, assign) bool showBackgroundPattern;


+(ttSettings*) Instance;

-(void) registerDefaults;
-(void) resetToDefaults;

+(void) copyInitialFiles;
+(void) resetInitialFiles;

-(NSString*)getSettings;





@end
