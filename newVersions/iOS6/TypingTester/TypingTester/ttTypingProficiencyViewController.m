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

@interface ttTypingProficiencyViewController ()

@end

@implementation ttTypingProficiencyViewController
{
    ttSettings *settings;
    ttInputData *inputData;
    NSArray *inputStrings;
    unsigned int currentString;
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        settings = [ttSettings Instance];
        inputData = [ttInputData Instance];
        currentString = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.     
    inputStrings = [inputData getPhrasesForGroupId:1];
    //NSLog(@"%@", inputStrings);
    [self configureUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) configureUI
{
    ttProficiencyItem *item = [inputStrings objectAtIndex:currentString];
    self.phraseLabel1.text = item.text;
    self.progressLabel.text = [NSString stringWithFormat:@"Entry %i of %i", currentString+1, inputStrings.count];
    self.progressBar.progress = (currentString + 0.0F)/(inputStrings.count+0.0F);
    if (self.entryField.text.length > 0)
    {
        self.doneButton.enabled = YES;
    }
    else
    {
        self.doneButton.enabled = NO;
    }
}

#pragma mark - IBActions

-(IBAction)doneButtonPressed
{
    NSLog(@"Done button pressed");
    currentString++;
    if (currentString < inputStrings.count)
    {
        self.entryField.text = @"";
        [self configureUI];
    }
    else
    {
        // prepare for next screen
        [self performSegueWithIdentifier:@"Memorize" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Memorize"])
    {
        
    }
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



@end
