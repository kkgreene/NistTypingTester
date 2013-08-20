//
//  ttPracticeViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/20/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttPracticeViewController.h"
#import "ttSettings.h"
#import "ttEventTouch.h"
#import "ttEventInput.h"

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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint pos = [touch locationInView: [UIApplication sharedApplication].keyWindow];
    ttEventTouch *touchEvent =  [[ttEventTouch alloc]initWithPoint:pos andPhase:Proficiency];
    NSLog(@"Touch on Practice View: %.3f, %.3f", pos.x, pos.y);
    [self.session addEvent:touchEvent];
    [self.entryField resignFirstResponder];
}

#pragma -mark UITextFieldDelegate methods

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    ttEventInput *inputEvent = [[ttEventInput alloc] initWithEventType:Input andPhase:UnknownPhase];
    inputEvent.location = range.location;
    inputEvent.length = range.length;
    inputEvent.enteredCharacters = string;
    inputEvent.currentValue = newString;
    [self.session addEvent:inputEvent];
    if (newString.length > 0)
    {
        self.doneButton.enabled = YES;
    }
    else
    {
        self.doneButton.enabled = NO;
    }
    NSLog(@"Change Location:%i, Length:%i, withString:%@", range.location, range.length, string);
    return YES;
}

// hides the keyboard when the user returns
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
