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

@end
