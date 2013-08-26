//
//  ttRecallViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/21/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttRecallViewController.h"
#import "ttRecallTableViewController.h"
#import "ttSession.h"

@interface ttRecallViewController ()

@end

@implementation ttRecallViewController

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
    [self.session enteredPhase:Recall withNote:@"Entered Recall Phase"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"RecallTableView"])
    {
        ttRecallTableViewController *controller = segue.destinationViewController;
        controller.session = self.session;
    }
    else if ([segue.identifier isEqualToString:@"ThankYou"])
    {
        // end the session
        [self.session leftPhase:Recall withNote:@"Leaving Recall Phase"];
        [self.session sessionDidFinish];
    }
}

-(IBAction)done
{

}

@end
