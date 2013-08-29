//
//  ttThankYouViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/20/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttThankYouViewController.h"
#import "ttUtilities.h"
#import "ttSession.h"
#import "ttEvent.h"

@interface ttThankYouViewController ()

@end

@implementation ttThankYouViewController

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
    ttEvent* event = [[ttEvent alloc]initWithEventType:SubPhaseChange andPhase:ThankYou];
    [self.session addEvent:event];
	// Do any additional setup after loading the view.
    NSString *htmlFile = [[ttUtilities documentsDirectory] stringByAppendingPathComponent:@"thankYou.html"];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlFile];
    NSData *htmlData = [NSData dataWithContentsOfFile:htmlFile];
    [self.webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseURL];
}


-(IBAction)done
{
    [self performSegueWithIdentifier:@"BackToStart" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"BackToStart"])
    {
        // Add any clean up here...
    }
}

@end
