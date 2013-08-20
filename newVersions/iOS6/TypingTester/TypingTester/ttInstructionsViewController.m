//
//  ttInstructionsViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/20/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttInstructionsViewController.h"
#import "ttUtilities.h"
#import "ttMemorizeViewController.h"
#import "ttEventTouch.h"

@interface ttInstructionsViewController ()

@end

@implementation ttInstructionsViewController


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
    NSString *htmlFile = [[ttUtilities documentsDirectory] stringByAppendingPathComponent:@"instructionsIphone.html"];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlFile];
    NSData *htmlData = [NSData dataWithContentsOfFile:htmlFile];
    [self.webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseURL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Memorize"])
    {
        ttMemorizeViewController *controller = segue.destinationViewController;
        controller.session = self.session;
    }
}

#pragma -mark touch events
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint pos = [touch locationInView: [UIApplication sharedApplication].keyWindow];
    ttEventTouch *touchEvent =  [[ttEventTouch alloc]initWithPoint:pos andPhase:Proficiency];
    NSLog(@"Touch on Practice View: %.3f, %.3f", pos.x, pos.y);
    [self.session addEvent:touchEvent];
}

@end
