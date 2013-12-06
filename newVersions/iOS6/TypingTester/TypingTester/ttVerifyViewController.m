//
//  ttVerifyViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/21/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttVerifyViewController.h"
#import "ttSession.h"
#import "ttSettings.h"
#import "ttEvent.h"
#import "ttEntryViewController.h"
#import "ttPracticeViewController.h"
#import "ttTestEntity.h"
#import "ttRecallViewController.h"
#import "ttSettings.h"
#import "ttMemorizeViewController.h"

@interface ttVerifyViewController ()

@end

@implementation ttVerifyViewController
{
    ttTestEntity *entity;
    ttSettings *settings;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (settings.showBackgroundPattern)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Pattern - Cloth.png"]];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.session enteredSubPhase:Verify withNote:@"Entered Verify Phase"];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"BackToPractice"])
    {
        ttPracticeViewController *controller = segue.destinationViewController;
        controller.session = self.session;
    }
    else if ([segue.identifier isEqualToString:@"Entry"])
    {
        [self.session leftPhase:Memorize withNote:@"Leaving Memorize Phase"];
        ttEntryViewController *controller = segue.destinationViewController;
        controller.session = self.session;
    }
    else if ([segue.identifier isEqualToString:@"SkipToRecall"])
    {
        [self.session leftPhase:Memorize withNote:@"Leaving Memorize Phase, skipping to recall phase"];
        ttRecallViewController *controller = segue.destinationViewController;
        controller.session = self.session;
    }
    else if ([segue.identifier isEqualToString:@"BackToMemorize"])
    {
        [self.session nextEntity];
        ttMemorizeViewController *controller = segue.destinationViewController;
        controller.session = self.session;
    }
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

#pragma -mark IBActions
-(IBAction)back
{
    [self performSegueWithIdentifier:@"BackToPractice" sender:self];
}

-(IBAction)done
{
    [self.view endEditing:YES];
    ttTestEntity *currentEntity = [self.session.entities objectAtIndex:self.session.currentEntity];
    if ([self.entryField.text isEqualToString:currentEntity.entityString])
    {
        ttEvent *event = [[ttEvent alloc]initWithEventType:CorrectValueEntered andPhase:Memorize andSubPhase:Verify];
        event.targetString = entity.entityString;
        event.currentValue = self.entryField.text;
        [self.session addEvent:event];
        [self performSegueWithIdentifier:@"Entry" sender:self];
    }
    else if ([self.entryField.text isEqualToString:[ttSettings Instance].quitString])
    {
        ttEvent *event = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Memorize andSubPhase:Verify];
        event.targetString = entity.entityString;
        event.notes = @"Quit phrase entered";
        [self.session addEvent:event];
        [self performSegueWithIdentifier:@"SkipToRecall" sender:self];
    }
    else if ([self.entryField.text isEqualToString:[ttSettings Instance].skipString])
    {
        ttEvent *event = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Memorize andSubPhase:Verify];
        event.targetString = entity.entityString;
        event.notes = @"Skip phrase entered";
        [self.session addEvent:event];
        [self performSegueWithIdentifier:@"BackToMemorize" sender:self];
    }
    else
    {
        ttEvent *event = [[ttEvent alloc]initWithEventType:IncorrectValueEntered andPhase:Memorize andSubPhase:Verify];
        event.targetString = entity.entityString;
        event.currentValue = self.entryField.text;
        [self.session addEvent:event];
        self.incorrectText.hidden = NO;
        self.incorrectImage.hidden = NO;
    }
}

-(IBAction)backgroundButtonPressed
{
    [self.view endEditing:YES];
}

#pragma -mark UI configuration
-(void)configureUI
{
    entity = [self.session.entities objectAtIndex:self.session.currentEntity];
    int currentEntity = self.session.currentEntity;
    int totalEntities = self.session.entities.count;
    self.sessionProgressLabel.text = [NSString stringWithFormat:@"Password %i of %i", currentEntity+1, totalEntities];
    self.entityProgressLabel.text = [NSString stringWithFormat:@"Round 1 of 1"];
    // hide the incorrect icon and label
    self.incorrectImage.hidden = YES;
    self.incorrectText.hidden = YES;
}

#pragma -mark UITextFieldDelegate methods

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    ttEvent *inputEvent = [[ttEvent alloc] initWithEventType:Input andPhase:Memorize andSubPhase:Verify];
    inputEvent.location = range.location;
    inputEvent.length = range.length;
    inputEvent.enteredCharacters = string;
    inputEvent.currentValue = newString;
    inputEvent.targetString = entity.entityString;
    // determine if delete event occured
    if ([string isEqualToString:@""])
    {
        inputEvent.notes = @"Delete event detected";
    }
    else
    {
        inputEvent.notes = [NSString stringWithFormat:@"%@ entered", string];
    }
    [self.session addEvent:inputEvent];
    if (newString.length > 0)
    {
        self.doneButton.enabled = YES;
        self.doneButton_iPad.enabled = YES;
    }
    else
    {
        self.doneButton.enabled = NO;
        self.doneButton_iPad.enabled = NO;
    }
    //NSLog(@"Change Location:%i, Length:%i, withString:%@", range.location, range.length, string);
    // hides the incorrect icon and label
    self.incorrectImage.hidden = YES;
    self.incorrectText.hidden = YES;
    return YES;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    ttEvent *textFieldEntered = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Memorize andSubPhase:Verify];
    textFieldEntered.notes =[NSString stringWithFormat:@"TextField Became Active"];
    [self.session addEvent:textFieldEntered];
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    ttEvent *textFieldLeft= [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Memorize andSubPhase:Verify];
    textFieldLeft.notes = [NSString stringWithFormat:@"TextField No Longer Active"];
    [self.session addEvent:textFieldLeft];
}

@end
