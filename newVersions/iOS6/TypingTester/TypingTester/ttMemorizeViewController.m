//
//  ttMemorizeViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/19/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttMemorizeViewController.h"
#import "ttEventTouch.h"
#import "ttEventInput.h"

@interface ttMemorizeViewController ()

@end

@implementation ttMemorizeViewController

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
