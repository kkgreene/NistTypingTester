//
//  ttTypingProficiencyViewController.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/1/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ttSession;

@interface ttTypingProficiencyViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UILabel *progressLabel;
@property (nonatomic, weak) IBOutlet UILabel *phraseLabel1;
@property (nonatomic, weak) IBOutlet UITextField *entryField;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, weak) IBOutlet UIButton *doneButton_iPad;
@property (nonatomic, weak) IBOutlet UIProgressView *progressBar;


@property (nonatomic, strong) ttSession *session;


-(IBAction) doneButtonPressed;
-(IBAction)backgroundButtonPressed;

@end
