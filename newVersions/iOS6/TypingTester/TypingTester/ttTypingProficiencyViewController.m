//
//  ttTypingProficiencyViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/1/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttTypingProficiencyViewController.h"
#import "ttEvent.h"
#import "ttEventTouch.h"
#import "ttEventInput.h"
#import "ttConstants.h"
#import "ttSession.h"
#import "ttInputData.h"
#import "ttSettings.h"
#import "ttProficiencyItem.h"
#import "ttInstructionsViewController.h"

@interface ttTypingProficiencyViewController ()

@end

@implementation ttTypingProficiencyViewController
{
    ttSettings *settings;
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        settings = [ttSettings Instance];
        [self.session enteredProficiencyPhase];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self configureUI];
}

-(void) configureUI
{
    int currentString = self.session.currentProficiencyString;
    int totalStrings = self.session.proficiencyStrings.count;
    ttProficiencyItem *item = [self.session.proficiencyStrings objectAtIndex:currentString];
    self.phraseLabel1.text = item.text;
    self.progressLabel.text = [NSString stringWithFormat:@"Entry %i of %i", currentString+1, totalStrings];
    self.progressBar.progress = (currentString + 0.0F)/(totalStrings+0.0F);
    if (self.entryField.text.length > 0)
    {
        self.doneButton.enabled = YES;
    }
    else
    {
        self.doneButton.enabled = NO;
    }
    // add the event indicating that a proficiency string was displayed
    ttEvent *event = [[ttEvent alloc]initWithEventType:ProficiencyStringShown andPhase:Proficiency];
    event.notes = [NSString stringWithFormat:@"%i/%i String:%@", currentString+1,totalStrings,item.text];
    [self.session addEvent:event];
}

#pragma mark - IBActions

-(IBAction)doneButtonPressed
{
    NSLog(@"Done button pressed");
    // create an event indicating that the button was pressed
    ttEvent *donePressed = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Proficiency];
    donePressed.notes = [NSString stringWithFormat:@"Done button pressed"];
    self.session.currentProficiencyString++;
    if (self.session.currentProficiencyString < self.session.proficiencyStrings.count)
    {
        self.entryField.text = @"";
        [self configureUI];
    }
    else
    {
        // prepare for next screen
        [self performSegueWithIdentifier:@"Instructions" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // pass the session pointer on ...
    if ([segue.identifier isEqualToString:@"Instructions"])
    {
        
        ttInstructionsViewController *controller = [segue destinationViewController];
        controller.session = self.session;
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.session leftPhase:Proficiency withNote:@"Typing Proficiency Phase Left"];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // indicate that the typing proficiency phase has been entered
    [self.session enteredPhase:Proficiency withNote:@"Typing Proficiency Phase Entered"];
}

#pragma mark - Touch Tracking

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // get the touch coordinates
    UITouch * touch = [touches anyObject];
    CGPoint pos = [touch locationInView: [UIApplication sharedApplication].keyWindow];
    NSLog(@"Touch on Proficiency View: %.3f, %.3f", pos.x, pos.y);
    // add the touch event to the log
    ttEventTouch *touchEvent =  [[ttEventTouch alloc]initWithPoint:pos andPhase:Proficiency];
    touchEvent.notes = [NSString stringWithFormat:@"Touch on Proficiency View: %.3f, %.3f", pos.x, pos.y];
    [self.session addEvent:touchEvent];
    // resign first responder to hide the keyboard
    [self.entryField resignFirstResponder];
}

#pragma mark - UI Text Field Delegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    ttEventInput *inputEvent = [[ttEventInput alloc] initWithEventType:Input andPhase:Proficiency];
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
    NSLog(@"textFieldShouldReturn");
    [textField resignFirstResponder];
    return YES;
}

-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    ttEvent *textFieldEntered = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Proficiency];
    textFieldEntered.notes =[NSString stringWithFormat:@"TextField Became Active"];
    [self.session addEvent:textFieldEntered];
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    ttEvent *textFieldLeft= [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Proficiency];
    textFieldLeft.notes = [NSString stringWithFormat:@"TextField No Longer Active"]; 
}

@end
