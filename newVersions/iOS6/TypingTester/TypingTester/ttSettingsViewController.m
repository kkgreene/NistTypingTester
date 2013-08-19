//
//  ttSettingsViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 7/31/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttSettingsViewController.h"
#import "ttSettings.h"

@interface ttSettingsViewController ()

@end

@implementation ttSettingsViewController
{
    ttSettings* settings;
    int _numberOfEntities;
    int _numberOfEntriesPerEntitiy;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        settings = [ttSettings Instance];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _numberOfEntities = settings.StringsPerSession;
    _numberOfEntriesPerEntitiy = settings.EntriesPerString;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark IBActions

-(IBAction)cancel:(id)sender
{
    [self.delegate SettingViewControllerDidCancel:self];
}

-(IBAction)save:(id)sender
{
    // TODO::Add code to save the settings
    settings.StringsPerSession = _numberOfEntities;
    [self.delegate SettingsViewControllerDidSave:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SettingDetails"])
    {
        ttSettingsDetailViewController *controller = segue.destinationViewController;
        controller.delegate = self;
    }
}

#pragma mark - Settings Detail View Controller Delegate

-(void)settingsDetailViewControllerDidChangeNumberOfEntities:(int)numberOfEntities
{
    _numberOfEntities = numberOfEntities;
}


@end
