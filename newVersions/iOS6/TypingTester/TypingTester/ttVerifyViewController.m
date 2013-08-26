//
//  ttVerifyViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/21/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttVerifyViewController.h"
#import "ttSession.h"
#import "ttSettings.h"
#import "ttEventInput.h"
#import "ttEvent.h"
#import "ttEventTouch.h"
#import "ttEntryViewController.h"
#import "ttPracticeViewController.h"

@interface ttVerifyViewController ()

@end

@implementation ttVerifyViewController

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

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"BackToPractice"])
    {
        ttPracticeViewController *controller = segue.destinationViewController;
        controller.session = self.session;
    }
    else if ([segue.identifier isEqualToString:@"Entry"])
    {
        ttEntryViewController *controller = segue.destinationViewController;
        controller.session = self.session;
    }
}


@end
