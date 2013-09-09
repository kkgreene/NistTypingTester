//
//  ttSettingsViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 7/31/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttSettingsViewController.h"
#import "ttSettings.h"

@interface ttSettingsViewController ()

@end

@implementation ttSettingsViewController
{
    ttSettings* settings;
    
    ttSettingsDetailViewController* child;

    int stringsPerSession;
    int entriesPerString;
    int forcedPracticeRounds;
    bool showQuitButton;
    bool showSkipButton;
    bool randomStringOrder;
    bool randomStringSelection;
    int stringOrderKey;
    int stringSelectionKey;
    bool useRandomStringOrderSeed;
    bool useRandomStringSelectionSeed;
    NSString *quitString;
    bool useGroupId;
    int selectedGroup;
    NSArray *selectedFilters;
    bool firstRun;
    bool enableHideButtonOnPracticeScreen;
    bool enableSkipButton;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        settings = [ttSettings Instance];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Pattern - Cloth.png"]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    stringsPerSession = settings.entitiesPerSession;
    entriesPerString = settings.entriesPerEntitiy;
    forcedPracticeRounds = settings.forcedPracticeRounds;
    showQuitButton = settings.showQuitButton;
    showSkipButton = settings.showSkipButton;
    randomStringOrder = settings.randomStringOrder;
    randomStringSelection = settings.randomStringSelection;
    stringOrderKey = settings.stringOrderSeed;
    stringSelectionKey = settings.stringSelectionSeed;
    useRandomStringOrderSeed = settings.useRandomStringOrderSeed;
    useRandomStringSelectionSeed = settings.useRandomStringSelectionSeed;
    quitString = [settings.quitString copy];
    useGroupId = settings.useGroupId;
    selectedGroup = settings.selectedGroup;
    selectedFilters = [NSArray arrayWithArray:settings.selectedFilters];
    enableHideButtonOnPracticeScreen = settings.enableHideButtonOnPracticeScreen;
    [self configureUI];
}

-(NSUInteger)supportedInterfaceOrientations
{
    switch(UI_USER_INTERFACE_IDIOM())
    {
        case UIUserInterfaceIdiomPad:
            return UIInterfaceOrientationMaskAll;
            
        case UIUserInterfaceIdiomPhone:
            return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskAll;
}

-(void)configureUI
{
    
}

#pragma mark IBActions

-(IBAction)backgroundButtonPressed:(id)sender
{
    [child hideKeyboard];
}

-(IBAction)cancel:(id)sender
{
    [self.delegate SettingViewControllerDidCancel:self];
}

-(IBAction)save:(id)sender
{
    // TODO :: See if there is a better way to do this...
    [child hideKeyboard];
    // TODO::Add code to save the settings
    settings.entitiesPerSession = stringsPerSession;
    settings.entriesPerEntitiy = entriesPerString;
    settings.forcedPracticeRounds = forcedPracticeRounds;
    settings.showQuitButton = showQuitButton;
    settings.showSkipButton = showSkipButton;
    settings.randomStringOrder = randomStringOrder;
    settings.randomStringSelection = randomStringSelection;
    settings.stringOrderSeed = stringOrderKey;
    settings.stringSelectionSeed = stringSelectionKey;
    settings.useRandomStringOrderSeed = useRandomStringOrderSeed;
    settings.useRandomStringSelectionSeed = useRandomStringSelectionSeed;
    settings.quitString = quitString;
    settings.useGroupId = useGroupId;
    settings.selectedGroup = selectedGroup;
    settings.selectedFilters = selectedFilters;
    settings.enableHideButtonOnPracticeScreen = enableHideButtonOnPracticeScreen;
    [self.delegate SettingsViewControllerDidSave:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SettingDetails"])
    {
        child = segue.destinationViewController;
        child.delegate = self;
    }
}

#pragma mark - Settings Detail View Controller Delegate

-(void)settingsDetailViewControllerDidResetToDefault
{
    [self.delegate SettingsViewControllerDidSave:self];
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController*)controller didChangeNumberOfEntries:(int)value
{
    stringsPerSession = value;
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeNumberOfRepetitions:(int)value
{
    entriesPerString = value;
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeNumberOfForcedPracticeRounds:(int)value
{
    forcedPracticeRounds = value;
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeRandomStringOrder:(BOOL)value
{
    randomStringOrder = value;
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeUseOrderSeed:(BOOL)value
{
    useRandomStringOrderSeed = value;
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeOrderSeedValue:(int)value
{
    stringOrderKey = value;
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeRandomStringSelection:(BOOL)value
{
    randomStringSelection = value;
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeUseSelectionSeed:(BOOL)value
{
    useRandomStringSelectionSeed = value;
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeSelectionSeedValue:(int)value
{
    stringSelectionKey = value;
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeUseGroupId:(BOOL)value
{
    useGroupId = value;
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeGroupId:(int)value
{
    selectedGroup = value;
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeQuitString:(NSString*)value
{
    quitString = value;
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeEnableHideOnPracticeScreen:(BOOL)value
{
    enableHideButtonOnPracticeScreen = value;
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeEnableSkipButton:(BOOL)value
{
    enableSkipButton = value;
}



@end
