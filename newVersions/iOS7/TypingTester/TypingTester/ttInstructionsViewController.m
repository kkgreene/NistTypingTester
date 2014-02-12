//
//  ttInstructionsViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/20/13.
//

#import "ttInstructionsViewController.h"
#import "ttUtilities.h"
#import "ttMemorizeViewController.h"
#import "ttPracticeViewController.h"
#import "ttLocalHtmlFile.h"
#import "ttSettings.h"
#import "ttEvent.h"
#import "ttUtilities.h"

@interface ttInstructionsViewController ()

@end

@implementation ttInstructionsViewController
{
    ttSettings *settings;
}


-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        settings = [ttSettings Instance];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    ttLocalHtmlFile *file = [[ttLocalHtmlFile alloc]initWithFilenameBase:@"instructions"];
    [self.webView loadData:file.data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:file.url];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // add event that we entered the instructions
    [self.session enteredPhase:Introduction withNote:@"Entering Introduction Phase"];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.session leftPhase:Introduction withNote:@"Leaving Introduction Phase"];
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

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    // log a rotation
    ttEvent *event = [[ttEvent alloc]initWithEventType:OrientationChange andPhase:UnknownPhase];
    event.notes = [NSString stringWithFormat:@"Did rotate from %@ to %@", [ttUtilities stringForOrienatation:fromInterfaceOrientation], [ttUtilities stringForOrienatation:self.interfaceOrientation]];
    [self.session addEvent:event];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // check to see if we are on the first entity
    if (self.session.currentEntity == -1) [self.session nextEntity];
    if ([segue.identifier isEqualToString:@"InstructionsToForcedPractice"])
    {
        ttPracticeViewController *controller = segue.destinationViewController;
        controller.session = self.session;
    }
    else if ([segue.identifier isEqualToString:@"InstructionsToFreePractice"])
    {
        ttMemorizeViewController *controller = segue.destinationViewController;
        controller.session = self.session;
    }
}

-(IBAction)nextScreen
{
    if (settings.disableFreePractice == YES)
    {
        [self performSegueWithIdentifier:@"InstructionsToForcedPractice" sender:self];
    }
    else
    {
        [self performSegueWithIdentifier:@"InstructionsToFreePractice" sender:self];
    }
    
}


@end
