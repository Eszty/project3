//
//  SecondViewController.m
//  ForeverAlone
//
//  Created by Eszter Fodor on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"
#import "AppDelegate.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

@synthesize navigation;
@synthesize back;
@synthesize avatar;     

AppDelegate* app;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Chat", @"Chat");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    /* Load the users avatar */
    [avatar setImage:[UIImage imageWithContentsOfFile:@"cat"]];
    NSLog(@"loaded avatar");
	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    navigation.topItem.title = app.userName;
}

//Go back to login
- (IBAction)goBack:(id)sender
{
    [self.tabBarController setSelectedIndex:0];
    
}




@end
