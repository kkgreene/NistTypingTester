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

@interface ttEntryViewController ()

@end

@implementation ttEntryViewController

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
    [self.session enteredPhase:Entry withNote:@"Started Entry Phase"];
    [self configureUI];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Recall"])
    {
        [self.session leftPhase:Entry withNote:@"Leaving Entry Phase"];
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

#pragma mark - UI Configuration

-(void) configureUI
{
    int totalEntites = self.session.entities.count;
    int currentEntity = self.session.currentEntity;
    int currentEntry = self.session.currentEntryForEntity;
    int totalEntries = [[ttSettings Instance]EntriesPerString];
    self.sessionProgressBar.progress = (float)(currentEntity)/(float)(totalEntites);
    self.sessionProgressLabel.text = [NSString stringWithFormat:@"Entity %i of %i",currentEntity+1, totalEntites];
    self.entityProgressBar.progress = (float)currentEntry/(float)totalEntries;
    self.entityProgressLabel.text = [NSString stringWithFormat:@"Entry %i of %i", currentEntry+1, totalEntries];
}

#pragma mark - IBAction
-(IBAction)done
{
    self.session.currentEntryForEntity++;
    int currentEntry = self.session.currentEntryForEntity;
    int totalEntriesRequired = [[ttSettings Instance]EntriesPerString];
    // have we entered the string X # of times?
    if (currentEntry < totalEntriesRequired)
    {
        // no so we need to enter it again
        self.entryField.text = @"";
        self.doneButton.enabled = NO;
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

#pragma mark - UITextFieldDelegate methods
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

@end
