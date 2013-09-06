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
{
    ttRecallTableViewController *child;
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

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Pattern - Cloth.png"]];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.session enteredPhase:Recall withNote:@"Entered Recall Phase"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.session leftPhase:Recall withNote:@"Leaving Recall Phase"];
    // end the session
    [self.session sessionDidFinish];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"RecallTableView"])
    {
        child = segue.destinationViewController;
        child.session = self.session;
    }
    else if ([segue.identifier isEqualToString:@"ThankYou"])
    {
        
    }
}

-(IBAction)done
{

}

-(IBAction)backgroundButtonPressed
{
    [child hideKeyboard];
}

@end
