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

@interface ttTypingProficiencyViewController ()

@end

@implementation ttTypingProficiencyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

-(IBAction)doneButtonPressed
{
    NSLog(@"Done button pressed");
}

#pragma mark - Touch Tracking
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint pos = [touch locationInView: [UIApplication sharedApplication].keyWindow];
    ttEventTouch *touchEvent =  [[ttEventTouch alloc]initWithPoint:pos andPhase:Proficiency];
    NSLog(@"Position of touch: %.3f, %.3f", pos.x, pos.y);
    [self.session addEvent:touchEvent];
    [self.entryField resignFirstResponder];
    
}

#pragma mark - UI Text Field Delegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    ttEventInput *inputEvent = [[ttEventInput alloc] initWithEventType:Input andPhase:UnknownPhase];
    inputEvent.location = range.location;
    inputEvent.length = range.length;
    inputEvent.enteredCharacters = string;
    inputEvent.currentValue = newString;
    [self.session addEvent:inputEvent];
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



@end
