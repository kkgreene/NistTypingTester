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
#import "ttLocalHtmlFile.h"

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
    ttLocalHtmlFile *file = [[ttLocalHtmlFile alloc]initWithFilenameBase:@"thankYou"];
    [self.webView loadData:file.data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:file.url];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Pattern - Cloth.png"]];
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
