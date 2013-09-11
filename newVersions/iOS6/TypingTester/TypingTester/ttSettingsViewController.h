//
//  ttSettingsViewController.h
//  TypingTester
//
//  Created by Matthew Kerr on 7/31/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ttSettingsDetailViewController.h"

@class ttSettingsViewController;

@protocol SettingsViewControllerDelegate <NSObject>

-(void)SettingViewControllerDidCancel:(ttSettingsViewController*)controller;
-(void)SettingsViewControllerDidSave:(ttSettingsViewController*)controller;

@end


@interface ttSettingsViewController : UIViewController <SettingsDetailViewControllerDelegate>

@property (nonatomic, weak) id <SettingsViewControllerDelegate> delegate;

-(IBAction)cancel:(id)sender;
-(IBAction)save:(id)sender;
-(IBAction)backgroundButtonPressed:(id)sender;

@end
