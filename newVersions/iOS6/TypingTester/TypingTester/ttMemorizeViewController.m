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
    NSLog(@"View Did load");
    [self configureUI];
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
        self.session.workAreaContents = self.workArea.text;
    }
}

#pragma -mark UITextViewDelegate methods
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}

//-(void)textViewDidChangeSelection:(UITextView *)textView
//{
//    UITextRange *selectedText = [textView selectedTextRange];
//}

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
