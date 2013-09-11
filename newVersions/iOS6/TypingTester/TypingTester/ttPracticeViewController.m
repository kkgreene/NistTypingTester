//
//  ttPracticeViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/20/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttPracticeViewController.h"
#import "ttMemorizeViewController.h"
#import "ttVerifyViewController.h"
#import "ttSettings.h"
#import "ttEventTouch.h"
#import "ttEventInput.h"
#import "ttTestEntity.h"

@interface ttPracticeViewController ()

@end

@implementation ttPracticeViewController
{
    NSString *currentString;
    NSString *maskedString;
    BOOL maskEntityDisplay;
    ttSettings *settings;
    int practiceStringNumber;
    int totalEntities;
    int entityNumber;
    int numberOfRequiredPractices;
}


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        maskEntityDisplay = NO;
        maskedString = @"*";
        settings = [ttSettings Instance];
        numberOfRequiredPractices = 1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    totalEntities = self.session.entities.count;
    entityNumber = self.session.currentEntity;
    numberOfRequiredPractices = settings.forcedPracticeRounds;
    [self configureUI];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.session enteredSubPhase:ForcedPractice withNote:@"Entering Forced Practice SubPhase"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Pattern - Cloth.png"]];
}

-(NSUInteger)supportedInterfaceOrientations
{
    switch(UI_USER_INTERFACE_IDIOM())
    {
        case UIUserInterfaceIdiomPad:
            return UIInterfaceOrientationMaskAll;
            
        case UIUserInterfaceIdiomPhone:
            return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskAll;
}


#pragma -mark UI Configuration

-(void)configureUI
{
    // display the string
    ttTestEntity *e = [self.session.entities objectAtIndex:entityNumber];
    currentString = e.entityString;
    // configure the display of the text
    [self configureEntityDisplay];
    // enable/disable the done button
    if (self.entryField.text.length > 0)
    {
        self.doneButton.enabled = YES;
        self.doneButton_iPad.enabled = YES;
    }
    else
    {
        self.doneButton.enabled = NO;
        self.doneButton_iPad.enabled = YES;
    }
    // configure optional button visibility
    self.visibilityButton.hidden = !settings.enableHideButtonOnPracticeScreen;
    self.skipButton.hidden = !settings.showSkipButton;
    // update the progress labels
    practiceStringNumber = self.session.CurrentPracticeRoundForEntity;
    self.sessionProgressBar.progress = (float)(entityNumber)/(float)(totalEntities);
    self.sessionProgressLabel.text = [NSString stringWithFormat:@"Entity %i of %i",entityNumber+1,totalEntities];
    
    if (self.session.CurrentPracticeRoundForEntity < settings.forcedPracticeRounds)
    {
        self.entityProgressBar.progress = (float)(practiceStringNumber)/(float)numberOfRequiredPractices;
        self.entitiyProgressLabel.text = [NSString stringWithFormat:@"Round %i of %i", practiceStringNumber+1, numberOfRequiredPractices];
    }
    else
    {
        self.entityProgressBar.progress = 1.0;
        self.entitiyProgressLabel.text = [NSString stringWithFormat:@"Complete"];
        self.doneButton.enabled = YES;
        self.doneButton_iPad.enabled = YES;
    }
    
    
    // hiode the incorrect labels
    self.correctIndicator.hidden = YES;
    self.correctTextLable.hidden = YES;
}

-(void)configureEntityDisplay
{
    // set up the entity text to display
    if (maskEntityDisplay == YES) self.entity.text = maskedString;
    else self.entity.text = currentString;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"BackToMemorize"])
    {
        ttMemorizeViewController* controller = segue.destinationViewController;
        controller.session = self.session;
    }
    else if ([segue.identifier isEqualToString:@"Verify"])
    {
        ttVerifyViewController* controller = segue.destinationViewController;
        controller.session = self.session;
    }
}

-(void) askGoToVerify
{
    UIAlertView *proceed = [[UIAlertView alloc]initWithTitle:@"Finish Practicing" message:@"Are you ready to proceed to the next step?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [proceed show];
}

#pragma -mark IBActions

-(IBAction)visibilityButtonPressed
{
    // toggle visibility of the entity field
    maskEntityDisplay = !maskEntityDisplay;
    self.visibilityButton.selected = maskEntityDisplay;
    [self configureEntityDisplay];
}

-(IBAction)skipButtonPressed
{
    // TODO :: add handling for skip button
}

-(IBAction)doneButtonPressed
{
    [self.view endEditing:YES];
    // check to see if the entered string matches the target string
    if([currentString isEqualToString:self.entryField.text])
    {
        self.session.CurrentPracticeRoundForEntity++;
        if (self.session.CurrentPracticeRoundForEntity >= settings.forcedPracticeRounds)
        {
            [self askGoToVerify];
        }
        self.entryField.text = @"";
        [self configureUI];
    }
    else    // entry does not match practice string
    {
        self.correctIndicator.hidden = NO;
        self.correctTextLable.hidden = NO;
        if (self.session.CurrentPracticeRoundForEntity >= settings.forcedPracticeRounds)
        {
            [self askGoToVerify];
        }
    }
}

-(IBAction)backgroundButtonPressed
{
    [self.view endEditing:YES];
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
    if (newString.length > 0 || self.session.CurrentPracticeRoundForEntity >= settings.forcedPracticeRounds)
    {
        self.doneButton.enabled = YES;
        self.doneButton_iPad.enabled = YES;
    }
    else
    {
        self.doneButton.enabled = NO;
        self.doneButton_iPad.enabled = NO;
    }
    NSLog(@"Change Location:%i, Length:%i, withString:%@", range.location, range.length, string);
    // hids the incorrect icon and label
    self.correctTextLable.hidden = YES;
    self.correctIndicator.hidden = YES;
    return YES;
}

// hides the keyboard when the user returns
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Alert View Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title= [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"Yes"])
    {
        [self performSegueWithIdentifier:@"Verify" sender:self];
    }
}


@end
