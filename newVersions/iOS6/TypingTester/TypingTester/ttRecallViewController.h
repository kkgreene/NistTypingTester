//
//  ttRecallViewController.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/21/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ttSession;

@interface ttRecallViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIBarButtonItem *donButton;

@property (nonatomic, weak) ttSession* session;

-(IBAction)done;


@end
