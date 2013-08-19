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
@property (nonatomic, weak) IBOutlet UILabel *phraseLabel2;
@property (nonatomic, weak) IBOutlet UITextField *entryField;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, strong) ttSession *session;


-(IBAction) doneButtonPressed;

@end
