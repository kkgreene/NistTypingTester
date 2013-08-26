//
//  ttRecallTableViewController.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/26/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ttSession;

@interface ttRecallTableViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic, weak) ttSession *session;

@end
