//
//  ttMemorizeViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/19/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "ttMemorizeViewController.h"
#import "ttPracticeViewController.h"
#import "ttTestEntity.h"
#import "ttSettings.h"

@interface ttMemorizeViewController ()

@end

@implementation ttMemorizeViewController
{
    unsigned int currentEntity;
    unsigned int totalEntites;
    ttTestEntity *entity;
    ttSettings *settings;
}

-(id) initWithCoder:(NSCoder *)aDecoder
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
    // set a border on the work area text field
    self.workArea.layer.borderWidth = 1.0f;
    self.workArea.layer.borderColor = [[UIColor grayColor]CGColor];
    // check to see if we are on the first entity
    if (self.session.currentEntity == -1) [self.session nextEntity];
    [self configureUI];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // log phase entry
    [self.session enteredPhase:Memorize withNote:@"Entering Memorize Phase"];
    [self.session enteredSubPhase:FreePractice withNote:@"Entering Free Practice"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (settings.showBackgroundPattern)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Pattern - Cloth.png"]];
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

-(void) configureUI
{
    currentEntity = self.session.currentEntity;
    totalEntites = self.session.entities.count;
    entity = [self.session.entities objectAtIndex:currentEntity];
    self.passwordLabel.text = entity.entityString;
    self.workArea.text = self.session.workAreaContents;
    self.progressLabel.text = [NSString stringWithFormat:@"Entity %i of %i", currentEntity+1, totalEntites];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Practice"])
    {
        ttPracticeViewController* controller = segue.destinationViewController;
        controller.session = self.session;
        self.session.workAreaContents = self.workArea.text; // store the work area contents
    }
}

-(IBAction)backgroundButtonPressed
{
    [self.view endEditing:YES];
}

#pragma -mark UITextViewDelegate methods
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *newString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    ttEvent *inputEvent = [[ttEvent alloc] initWithEventType:Input andPhase:Memorize andSubPhase:FreePractice];
    inputEvent.location = range.location;
    inputEvent.length = range.length;
    inputEvent.enteredCharacters = [self EscapeString:text];
    inputEvent.currentValue = [self EscapeString:newString];
    inputEvent.targetString = entity.entityString;
    if ([text isEqualToString:@""])
    {
        inputEvent.notes = @"Delete event detected";
    }
    else
    {
        inputEvent.notes = [NSString stringWithFormat:@"%@ entered", [self EscapeString:text]];
    }
    [self.session addEvent:inputEvent];
    return YES;
}

-(NSString*)EscapeString:(NSString*)input
{
    NSString *ret = [input stringByReplacingOccurrencesOfString:@"\n" withString:@"{CR/LF}"];
    return ret;
}


#pragma -mark touch events

@end
