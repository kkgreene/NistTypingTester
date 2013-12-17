//
//  ttRecallTableViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/26/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttRecallTableViewController.h"
#import "ttSettings.h"
#import "ttSession.h"
#import "ttEvent.h"
#import "ttTextFieldWithName.h"

@interface ttRecallTableViewController ()

@end

@implementation ttRecallTableViewController
{
    NSMutableDictionary *enteredStrings;
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        enteredStrings = [[NSMutableDictionary alloc]initWithCapacity:self.session.entities.count];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // allow single tap outside a text field to hide the keypad
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:gestureRecognizer];

}

-(NSUInteger)supportedInterfaceOrientations
{
    switch(UI_USER_INTERFACE_IDIOM())
    {
        case UIUserInterfaceIdiomPad:
            return UIInterfaceOrientationMaskAll;
            
        case UIUserInterfaceIdiomPhone:
            return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskAll;
}

-(void) hideKeyboard
{
    [self.view endEditing:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.session.entities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RecallCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    NSString *fieldId = [NSString stringWithFormat:@"Field %i", indexPath.row];
    ttTextFieldWithName *field = (ttTextFieldWithName*)[cell viewWithTag:1000];
    field.name = fieldId;
    field.delegate = self;
    [enteredStrings setObject:@"" forKey:fieldId];
    return cell;
}

-(NSString*) getStrings
{
    NSMutableString *returnString = [[NSMutableString alloc]init];
    for(int i = 0; i < self.session.entities.count; i++)
    {
        NSString *fieldId = [NSString stringWithFormat:@"Field %i", i];
        NSString *value = [enteredStrings objectForKey:fieldId];
        [returnString appendFormat:@"%@ : %@\n", fieldId, value];
    }
    return [returnString copy];
}
#pragma mark - Table view delegate


#pragma mark - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    ttEvent *inputEvent = [[ttEvent alloc] initWithEventType:Input andPhase:Recall andSubPhase:NoSubPhase];
    inputEvent.location = range.location;
    inputEvent.length = range.length;
    inputEvent.enteredCharacters = string;
    inputEvent.currentValue = newString;
    ttTextFieldWithName *field = (ttTextFieldWithName*)textField;
    // determine if delete event occured
    if ([string isEqualToString:@""])
    {
        inputEvent.notes = [NSString stringWithFormat:@"Delete event detected in %@", [field name]];
    }
    else
    {
        inputEvent.notes = [NSString stringWithFormat:@"%@ entered in %@", string, field.name];
    }
    [self.session addEvent:inputEvent];
    
    [enteredStrings setObject:newString forKey:[field.name copy]];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    ttTextFieldWithName *field = (ttTextFieldWithName*)textField;
    ttEvent *textFieldEntered = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Recall andSubPhase:NoSubPhase];
    textFieldEntered.notes =[NSString stringWithFormat:@"TextField Became Active : %@", [field name]];
    [self.session addEvent:textFieldEntered];
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    ttTextFieldWithName *field = (ttTextFieldWithName*)textField;
    ttEvent *textFieldLeft= [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Recall andSubPhase:NoSubPhase];
    textFieldLeft.notes = [NSString stringWithFormat:@"TextField No Longer Active : %@", [field name]];
    [self.session addEvent:textFieldLeft];
}


@end
