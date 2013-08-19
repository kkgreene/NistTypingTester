//
//  ttReadyViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/1/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttReadyViewController.h"
#import "ttUtilities.h"
#import "ttTypingProficiencyViewController.h"
#import "ttSession.h"

@interface ttReadyViewController ()

@end

@implementation ttReadyViewController
{
    ttSession* session;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.participantNumberLabel.text = self.participantNumber;
    NSString *htmlFile = [[ttUtilities documentsDirectory] stringByAppendingPathComponent:@"welcome.html"];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlFile];
    NSData *htmlData = [NSData dataWithContentsOfFile:htmlFile];
    [self.readyTextArea loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseURL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"TypingProficiency"])
    {
        ttTypingProficiencyViewController *controller = [segue destinationViewController];
        // this is the start of the session so Initialize it
        session = [[ttSession alloc]initWithParticipantId:self.participantNumber];
        controller.session = session;
    }
}

-(IBAction)cancel:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
