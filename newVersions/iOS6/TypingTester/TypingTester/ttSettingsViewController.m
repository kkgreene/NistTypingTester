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

    int StringsPerSession;
    int EntriesPerString;
    int ForcedPracticeRounds;
    bool ShowQuitButton;
    bool ShowSkipButton;
    bool RandomStringOrder;
    bool RandomStringSelection;
    int StringOrderKey;
    int StringSelectionKey;
    bool UseRandomStringOrderSeedKey;
    bool UseRandomStringSelectionSeedKey;
    NSString *QuitString;
    int SelectedGroup;
    NSArray *SelectedFilters;
    bool FirstRun;
    bool EnableHideButtonOnPracticeScreen;
    int proficiencyGroup;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    StringsPerSession = settings.StringsPerSession;
    EntriesPerString = settings.EntriesPerString;
    ForcedPracticeRounds = settings.ForcedPracticeRounds;
    ShowQuitButton = settings.ShowQuitButton;
    ShowSkipButton = settings.ShowSkipButton;
    RandomStringOrder = settings.RandomStringOrder;
    RandomStringSelection = settings.RandomStringSelection;
    StringOrderKey = settings.StringOrderKey;
    StringSelectionKey = settings.StringSelectionKey;
    UseRandomStringOrderSeedKey = settings.UseRandomStringOrderSeedKey;
    UseRandomStringSelectionSeedKey = settings.UseRandomStringSelectionSeedKey;
    QuitString = [settings.QuitString copy];
    SelectedGroup = settings.SelectedGroup;
    SelectedFilters = [NSArray arrayWithArray:settings.SelectedFilters];
    EnableHideButtonOnPracticeScreen = settings.EnableHideButtonOnPracticeScreen;
    proficiencyGroup = settings.proficiencyGroup;
    [self configureUI];
}

-(void)configureUI
{
    
}

#pragma mark IBActions

-(IBAction)cancel:(id)sender
{
    [self.delegate SettingViewControllerDidCancel:self];
}

-(IBAction)save:(id)sender
{
    // TODO::Add code to save the settings
    settings.StringsPerSession = StringsPerSession;
    settings.EntriesPerString = EntriesPerString;
    settings.ForcedPracticeRounds = ForcedPracticeRounds;
    settings.ShowQuitButton = ShowQuitButton;
    settings.ShowSkipButton = ShowSkipButton;
    settings.RandomStringOrder = RandomStringOrder;
    settings.RandomStringSelection = RandomStringSelection;
    settings.StringOrderKey = StringOrderKey;
    settings.StringSelectionKey = StringSelectionKey;
    settings.UseRandomStringOrderSeedKey = UseRandomStringOrderSeedKey;
    settings.UseRandomStringSelectionSeedKey = UseRandomStringSelectionSeedKey;
    settings.QuitString = QuitString;
    settings.SelectedGroup = SelectedGroup;
    settings.SelectedFilters = SelectedFilters;
    settings.EnableHideButtonOnPracticeScreen = EnableHideButtonOnPracticeScreen;
    settings.proficiencyGroup = proficiencyGroup;
    [self.delegate SettingsViewControllerDidSave:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SettingDetails"])
    {
        ttSettingsDetailViewController *controller = segue.destinationViewController;
        controller.delegate = self;
    }
}

#pragma mark - Settings Detail View Controller Delegate

-(void)settingsDetailViewControllerDidResetToDefault
{
    [self.delegate SettingsViewControllerDidSave:self];
}

-(void)settingsDetailViewControllerDidChangeNumberOfEntities:(int)numberOfEntities
{
    StringsPerSession = numberOfEntities;
}

-(void)settingsDetailViewControllerDidChangeNumberofRepetitions:(int)numberOfRepetitions
{
    EntriesPerString = numberOfRepetitions;
}

-(void)settingsDetailViewControllerDidChangeNumberOfForcedPracticeRounds:(int)numberOfRounds
{
    ForcedPracticeRounds = numberOfRounds;
}

-(void)settingsDetailViewControllerDidChangeRandomStringOrderSetting:(BOOL)randomStringOrder
{
    RandomStringOrder = randomStringOrder;
}

-(void)settingsDetailViewControllerDidChangeRandomStringSelectionSetting:(BOOL)randomStringSelection
{
    RandomStringSelection = randomStringSelection;
}

-(void)settingsDetailViewControllerDidChangeRandomStringOrderSeedValue:(int)seedValue
{
    StringOrderKey = seedValue;
}

-(void)settingsDetailViewControllerDidChangeRandomStringSelectionSeedValue:(int)seedValue
{
    StringSelectionKey = seedValue;
}

-(void)settingsDetailViewControllerDidChangeSelectedFilters:(NSArray*)selectedFilters
{
    SelectedFilters = [NSArray arrayWithArray:selectedFilters];
}

-(void)settingsDetailViewControllerDidChangeSelectedGroupId:(int)selectedGroup
{
    SelectedGroup = selectedGroup;
}


@end
