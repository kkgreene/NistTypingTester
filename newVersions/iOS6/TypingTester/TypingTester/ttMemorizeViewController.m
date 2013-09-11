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
#import "ttEventTouch.h"
#import "ttEventInput.h"
#import "ttTestEntity.h"

@interface ttMemorizeViewController ()

@end

@implementation ttMemorizeViewController
{
    unsigned int currentEntity;
    unsigned int totalEntites;
    ttTestEntity *entity;
}

-(id) initWithCoder:(NSCoder *)aDecoder
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
    // set a border on the work area text field
    self.workArea.layer.borderWidth = 1.0f;
    self.workArea.layer.borderColor = [[UIColor grayColor]CGColor];
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

-(void) configureUI
{
    currentEntity = self.session.currentEntity;
    totalEntites = self.session.entities.count;
    entity = [self.session.entities objectAtIndex:currentEntity];
    self.passwordLabel.text = entity.entityString;
    self.workArea.text = self.session.workAreaContents;
    self.progressDisplay.progress = (float)(currentEntity)/(float)totalEntites;
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
    ttEventInput *inputEvent = [[ttEventInput alloc] initWithEventType:Input andPhase:Memorize];
    inputEvent.location = range.location;
    inputEvent.length = range.length;
    inputEvent.enteredCharacters = [self EscapeString:text];
    inputEvent.currentValue = [self EscapeString:newString];
    [self.session addEvent:inputEvent];
    NSLog(@"Change Location:%i, Length:%i, withString:%@", range.location, range.length, text);
    return YES;
}

-(NSString*)EscapeString:(NSString*)input
{
    NSString *ret = [input stringByReplacingOccurrencesOfString:@"\n" withString:@"{CR/LF}"];
    return ret;
}


#pragma -mark touch events
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint pos = [touch locationInView: [UIApplication sharedApplication].keyWindow];
    ttEventTouch *touchEvent =  [[ttEventTouch alloc]initWithPoint:pos andPhase:Proficiency];
    NSLog(@"Touch on Memorize View: %.3f, %.3f", pos.x, pos.y);
    [self.session addEvent:touchEvent];
    [self.workArea resignFirstResponder];
}

@end
