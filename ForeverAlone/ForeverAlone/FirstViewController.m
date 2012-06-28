//
//  FirstViewController.m
//  ForeverAlone
//
//  Created by Eszter Fodor on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#import "AppDelegate.h"
#import "DatabaseFunctions.h"
#import <CoreLocation/CoreLocation.h>


@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize usernameText;
@synthesize passwordText;
@synthesize login;
@synthesize reg;
@synthesize delegate;
@synthesize locationManager;

DatabaseFunctions* userDB;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    
    userDB = [[DatabaseFunctions alloc]init];
    
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    //[locationManager startUpdatingLocation];
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

#pragma mark - Flipside View

- (IBAction)regist:(id)sender
{
    FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];
}

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

//Close keyboard on 'return'
- (BOOL)textFieldShouldReturn:(UITextField *) theTextField {
    [theTextField resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {   
    [textField resignFirstResponder]; 
}

- (IBAction)userLogin:(id)sender
{
    
    NSString* name = [[NSString alloc] initWithFormat:@"%@", usernameText.text];
    NSString* pword = [[NSString alloc] initWithFormat:@"%@", passwordText.text];
    
    [userDB inlog:name passWord:pword];
    
    NSLog(@"Latitude: %@", locationManager.location.coordinate.latitude);
    NSLog(@"Longitude: %@", locationManager.location.coordinate.longitude);
}



/* Doesn't work, dont know why yet
  * closing keybaord on touch outside the textfield
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event touch:(UITextField*)textField
{
    [textField resignFirstResponder];
    //[self.password resignFirstResponder];
    
}
*/







@end
