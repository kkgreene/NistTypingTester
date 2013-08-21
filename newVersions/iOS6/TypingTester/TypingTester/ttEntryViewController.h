//
//  ttEntryViewController.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/21/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ttEntryViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UILabel *sessionProgressLabel;
@property (nonatomic, weak) IBOutlet UIProgressView *sessionProgressBar;
@property (nonatomic, weak) IBOutlet UILabel *entityProgressLabel;
@property (nonatomic, weak) IBOutlet UIProgressView *entityProgressBar;
@property (nonatomic, weak) IBOutlet UITextField *entryField;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *doneButton;

-(IBAction)done;

@end
