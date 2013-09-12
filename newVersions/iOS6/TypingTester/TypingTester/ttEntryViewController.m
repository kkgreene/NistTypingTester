//
//  ttEntryViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/21/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttEntryViewController.h"
#import "ttSettings.h"
#import "ttSession.h"
#import "ttEvent.h"
#import "ttEventInput.h"
#import "ttEventTouch.h"
#import "ttRecallViewController.h"
#import "ttMemorizeViewController.h"
#import "ttTestEntity.h"

@interface ttEntryViewController ()

@end

@implementation ttEntryViewController
{
    ttTestEntity *entity;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
    
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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Pattern - Cloth.png"]];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.session enteredPhase:Entry withNote:@"Started Entry Phase"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.session leftPhase:Entry withNote:@"Leaving Entry Phase"];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Recall"])
    {
        ttRecallViewController *controller = segue.destinationViewController;
        controller.session = self.session;
    }
    else if ([segue.identifier isEqualToString:@"MemorizeNextEntity"])
    {
        [self.session moveToNextEntity];
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

#pragma mark - UI Configuration

-(void) configureUI
{
    entity = [self.session.entities objectAtIndex:self.session.currentEntity];
    int totalEntites = self.session.entities.count;
    int currentEntity = self.session.currentEntity;
    int currentEntry = self.session.currentEntryForEntity;
    int totalEntries = [[ttSettings Instance]entriesPerEntitiy];
    self.sessionProgressBar.progress = (float)(currentEntity)/(float)(totalEntites);
    self.sessionProgressLabel.text = [NSString stringWithFormat:@"Entity %i of %i",currentEntity+1, totalEntites];
    self.entityProgressBar.progress = (float)currentEntry/(float)totalEntries;
    self.entityProgressLabel.text = [NSString stringWithFormat:@"Entry %i of %i", currentEntry+1, totalEntries];
}

#pragma mark - IBAction
-(IBAction)done
{
    [self.view endEditing:YES];
    // check for quit string entered
    if ([self.entryField.text isEqualToString:[ttSettings Instance].quitString])
    {
        ttEvent *event = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Entry];
        event.notes = @"Quit string entered";
        [self.session addEvent:event];
        // if so go to recall
        [self performSegueWithIdentifier:@"Recall" sender:self];
        return;
    }
    // check for correct/incorrect entry
    if ([self.entryField.text isEqualToString:entity.entityString])
    {
        ttEvent *event = [[ttEvent alloc]initWithEventType:CorrectValueEntered andPhase:Entry];
        event.targetString = entity.entityString;
        event.notes = [NSString stringWithFormat:@"Entry:%i for Entity:%i", self.session.currentEntity, self.session.currentEntryForEntity];
        [self.session addEvent:event];
    }
    else
    {
        ttEvent *event = [[ttEvent alloc]initWithEventType:IncorrectValueEntered andPhase:Entry];
        event.targetString = entity.entityString;
        event.notes = [NSString stringWithFormat:@"Entry:%i for Entity:%i", self.session.currentEntity, self.session.currentEntryForEntity];
        [self.session addEvent:event];
    }
    self.session.currentEntryForEntity++;
    int currentEntry = self.session.currentEntryForEntity;
    int totalEntriesRequired = [[ttSettings Instance]entriesPerEntitiy];
    // have we entered the string X # of times?
    if (currentEntry < totalEntriesRequired)
    {
        // no so we need to enter it again
        self.entryField.text = @"";
        self.doneButton.enabled = NO;
        self.doneButton_iPad.enabled = NO;
        [self configureUI];
    }
    else
    {
        // yes
        // have we entered the required number of entities?
        int currentEntity = self.session.currentEntity + 1;
        int totalEntites = self.session.entities.count;
        // have we entered X number of strings?
        if (currentEntity >= totalEntites)
        {
            // if so go to recall
            [self performSegueWithIdentifier:@"Recall" sender:self];
        }
        else
        {
            // no so move on to next entity
            [self performSegueWithIdentifier:@"MemorizeNextEntity" sender:self];
        }
    }
}

-(IBAction)backgroundButtonPressed
{
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate methods
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    ttEventInput *inputEvent = [[ttEventInput alloc] initWithEventType:Input andPhase:UnknownPhase];
    inputEvent.location = range.location;
    inputEvent.length = range.length;
    inputEvent.enteredCharacters = string;
    inputEvent.currentValue = newString;
    inputEvent.targetString = entity.entityString;
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
    NSLog(@"Change Location:%i, Length:%i, withString:%@", range.location, range.length, string);
    return YES;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
