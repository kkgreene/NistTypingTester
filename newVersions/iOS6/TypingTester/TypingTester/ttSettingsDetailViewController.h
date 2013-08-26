//
//  ttSettingsDetailViewController.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/12/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ttSettingsDetailViewController;

@protocol SettingsDetailViewControllerDelegate <NSObject>


-(void)settingsDetailViewControllerDidResetToDefault;
-(void)settingsDetailViewControllerDidChangeNumberOfEntities:(int)numberOfEntities;
-(void)settingsDetailViewControllerDidChangeNumberofRepetitions:(int)numberOfRepetitions;
-(void)settingsDetailViewControllerDidChangeNumberOfForcedPracticeRounds:(int)numberOfRounds;
-(void)settingsDetailViewControllerDidChangeRandomStringOrderSetting:(BOOL)randomStringOrder;
-(void)settingsDetailViewControllerDidChangeRandomStringSelectionSetting:(BOOL)randomStringSelection;
-(void)settingsDetailViewControllerDidChangeRandomStringOrderSeedValue:(int)seedValue;
-(void)settingsDetailViewControllerDidChangeRandomStringSelectionSeedValue:(int)seedValue;
-(void)settingsDetailViewControllerDidChangeSelectedFilters:(NSArray*)selectedFilters;
-(void)settingsDetailViewControllerDidChangeSelectedGroupId:(int)selectedGroup;

@end

@interface ttSettingsDetailViewController : UITableViewController <UIAlertViewDelegate, UITextFieldDelegate>

@property (nonatomic, weak) id <SettingsDetailViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *numberOfEntities;
@property (weak, nonatomic) IBOutlet UITextField *numberOfRepetitions;
@property (weak, nonatomic) IBOutlet UITextField *numberOfProficiencyPhrases;
@property (weak, nonatomic) IBOutlet UITextField *numberOfForcedPracticeRounds;
@property (weak, nonatomic) IBOutlet UISwitch *randomStringOrder;
@property (weak, nonatomic) IBOutlet UITextField *randomStringOrderSeedValue;
@property (weak, nonatomic) IBOutlet UISwitch *randomStringSelection;
@property (weak, nonatomic) IBOutlet UITextField *randomStringSelectionSeedValue;
@property (weak, nonatomic) IBOutlet UITextField *groupId;


@end
