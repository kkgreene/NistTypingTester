//
//  ttPracticeViewController.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/20/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ttSession.h"

@interface ttPracticeViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UILabel *sessionProgressLabel;
@property (nonatomic, weak) IBOutlet UILabel *entitiyProgressLabel;
@property (nonatomic, weak) IBOutlet UIProgressView *sessionProgressBar;
@property (nonatomic, weak) IBOutlet UIProgressView *entityProgressBar;
@property (nonatomic, weak) IBOutlet UILabel *entity;
@property (nonatomic, weak) IBOutlet UITextField *entryField;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *backButton;
@property (nonatomic, weak) IBOutlet UIButton *visibilityButton;
@property (nonatomic, weak) IBOutlet UIButton *skipButton;
@property (nonatomic, weak) IBOutlet UIImageView *correctIndicator;
@property (nonatomic, weak) IBOutlet UILabel *correctTextLable;


@property (nonatomic, weak) ttSession *session;


-(IBAction)visibilityButtonPressed;
-(IBAction)skipButtonPressed;
-(IBAction)doneButtonPressed;


@end
