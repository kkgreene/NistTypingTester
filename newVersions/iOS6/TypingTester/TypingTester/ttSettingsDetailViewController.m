//
//  ttSettingsDetailViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/12/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttSettingsDetailViewController.h"
#import "ttSettings.h"

@interface ttSettingsDetailViewController ()

@end

@implementation ttSettingsDetailViewController
{
    ttSettings* settings;
    BOOL resetSettingsMode;
    BOOL resetFileMode;
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        settings = [ttSettings Instance];
        resetFileMode = NO;
        resetSettingsMode = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureSettingsDisplay];
    // allow single tap outside a text field to hide the keypad
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:gestureRecognizer];
}

# pragma mark - Private functions
-(void) configureSettingsDisplay
{
    self.numberOfEntities.text = [NSString stringWithFormat:@"%i",  settings.StringsPerSession];
    self.numberOfRepetitions.text = [NSString stringWithFormat:@"%d", settings.EntriesPerString];
    self.numberOfForcedPracticeRounds.text = [NSString stringWithFormat:@"%i", settings.ForcedPracticeRounds];

}

- (void) hideKeyboard
{
    [self.numberOfEntities resignFirstResponder];
    [self.numberOfForcedPracticeRounds resignFirstResponder];
    [self.numberOfProficiencyPhrases resignFirstResponder];
    [self.numberOfRepetitions resignFirstResponder];
    [self.randomStringOrderSeedValue resignFirstResponder];
    [self.randomStringSelectionSeedValue resignFirstResponder];
}

-(void) confirmSettingsReset
{
    resetSettingsMode = YES;
    UIAlertView *warning = [[UIAlertView alloc]initWithTitle:@"Reset all settings" message:@"Are you sure you want to reset the settings?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Reset", nil];
    [warning show];
    resetSettingsMode = NO;
}

-(void) confirmFileReset
{
    resetFileMode = YES;
    UIAlertView *warning = [[UIAlertView alloc]initWithTitle:@"Revert to original data files" message:@"Are you sure you want to replace the existing data files with the default ones?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Revert", nil];
    [warning show];
    resetFileMode = NO;
}

-(BOOL) isStringNumeric:(NSString*)value
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^\\d+$"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                           error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:value
                                                        options:0
                                                        range:NSMakeRange(0, [value length])];
    return (numberOfMatches > 0);
}


#pragma mark - Table view data source


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) // we selected a reset action
    {
        switch(indexPath.row)
        {
            case 0:             // reset all the settings
                [self confirmSettingsReset];
                break;
                
            case 1:             // copy the original data files back in
                [self confirmFileReset];
                break;
        }
        [self configureSettingsDisplay];
    }
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 3) return YES;
    return NO;
}

#pragma mark - Alert View Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title= [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"Reset"])
    {
        [settings resetToDefaults];
    }
    else if ([title isEqualToString:@"Revert"])
    {
        [ttSettings resetInitialFiles];
    }
}

#pragma mark - UITextField Delegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    switch (textField.tag)
    {
        case 1000:
            if ([self isStringNumeric:newString] == NO)
            {
                self.numberOfEntities.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:.5];
                return NO;
            }
            else
            {
                self.numberOfEntities.backgroundColor = [UIColor clearColor];
                [self.delegate settingsDetailViewControllerDidChangeNumberOfEntities:[newString integerValue]];
                return YES;
            }
            break;
            
        default:
            break;
    }
    return YES;
}


@end
