//
//  ttPracticeViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/20/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttPracticeViewController.h"
#import "ttSettings.h"

@interface ttPracticeViewController ()

@end

@implementation ttPracticeViewController
{
    NSString *currentString;
    NSString *maskedString;
    BOOL maskEntityDisplay;
    ttSettings *settings;
}


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        currentString = @"Password1234";
        maskEntityDisplay = NO;
        maskedString = @"************";
        settings = [ttSettings Instance];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self configureUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark UI Configuration

-(void)configureUI
{
    // enable/disable the done button
    if (self.entryField.text.length > 0) self.doneButton.enabled = YES;
    else self.doneButton.enabled = NO;
    // configure optional button visibility
    self.visibilityButton.hidden = !settings.EnableHideButtonOnPracticeScreen;
    self.skipButton.hidden = !settings.ShowSkipButton;
    // configure the initial display of the text
    [self configureEntityDisplay];
}

-(void)configureEntityDisplay
{
    // set up the entity text to display
    if (maskEntityDisplay == YES) self.entity.text = maskedString;
    else self.entity.text = currentString;
}

#pragma -mark IBActions

-(IBAction)visibilityButtonPressed
{
    // toggle visibility of the entity field
    maskEntityDisplay = !maskEntityDisplay;
    [self configureEntityDisplay];
}

-(IBAction)skipButtonPressed
{
    // TODO :: add handling for skip button
}

-(IBAction)doneButtonPressed
{

}

#pragma -mark touch events

#pragma -mark UITextFieldDelegate methods

@end
