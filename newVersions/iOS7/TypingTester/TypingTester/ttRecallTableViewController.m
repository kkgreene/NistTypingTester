//
//  ttRecallTableViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/26/13.
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
        // intialize the dictionary
        for (int i = 0; i < self.session.entities.count;i++)
        {
            [enteredStrings setObject:@"" forKey:[NSString stringWithFormat:@"Field %i", i]];
        }
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

-(IBAction)done
{
    ttEvent *doneButtonEvent = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Memorize andSubPhase:Verify];
    doneButtonEvent.notes = @"Next button pressed";
    [self.session addEvent:doneButtonEvent];
    [self.delegate RecallTableViewController:self didFinishWithValues:[self getStrings]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // if on iPad add 1 more extra row for the button at the bottom
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return self.session.entities.count + 1;
    }
    else
    {
        return self.session.entities.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RecallCell";
    // if we are on one of the rows for entity entry
    if (indexPath.row < self.session.entities.count)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        // Configure the cell...
        NSString *fieldId = [NSString stringWithFormat:@"Field %i", (int)indexPath.row];
        ttTextFieldWithName *field = (ttTextFieldWithName*)[cell viewWithTag:1000];
        field.name = fieldId;
        //set delegate to nil so we don't collect events for any changes caused here
        field.delegate = nil;
        // see if the text should be different than what is currently displayed
        if (![[enteredStrings objectForKey:fieldId] isEqualToString:field.text])
        {
            // set the text to whatever the current value is
            field.text = [enteredStrings objectForKey:fieldId];
        }
        // set up the delegate so we can capture upcoming changes
        field.delegate = self;
        return cell;
    }
    else // otherwise
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) // add a button to the last cell on iPad ...
        {
            static NSString *CellIdentifier = @"RecallDoneCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            return cell;
        }
    }
    return nil;
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
