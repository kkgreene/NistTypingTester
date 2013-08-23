//
//  ttVerifyViewController.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/21/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ttSession;

@interface ttVerifyViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UILabel *progressLabel;
@property (nonatomic, weak) IBOutlet UIProgressView *progressBar;
@property (nonatomic, weak) IBOutlet UITextField *entryField;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *backButton;

@property (nonatomic, weak) ttSession *session;

-(IBAction)done;
-(IBAction)back;

@end
