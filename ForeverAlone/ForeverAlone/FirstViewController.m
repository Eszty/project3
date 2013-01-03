//
//  FirstViewController.m
//  ForeverAlone
//
//  Created by Eszter Fodor on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

/***** Controller class for inlog page ******/

#import "FirstViewController.h"
#import "AppDelegate.h"
#import "DatabaseFunctions.h"
#import <CoreLocation/CoreLocation.h>
#import "SecondViewController.h"


@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize usernameText;
@synthesize passwordText;
@synthesize login;
@synthesize reg;
@synthesize delegate;
@synthesize locationManager;
@synthesize location;
@synthesize startLocation;

DatabaseFunctions* userDB;
AppDelegate *app;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Login", @"Login");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    
    //Create instance of DatabaseFunctions class
    userDB = [[DatabaseFunctions alloc]init];
    
    return self;
}
							
- (void)viewDidLoad
{
    
    app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
    //Initiate location manager
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    startLocation = nil;
    
    [super viewDidLoad];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

//Action for register button
//Switch to flipside (registration)
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

//Close keyboard when tapped outside textfields
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
    [self.passwordText resignFirstResponder];
    [self.usernameText resignFirstResponder];
}


//Login function
- (IBAction)userLogin:(id)sender
{
    //Get user input
    NSString* name = [[NSString alloc] initWithFormat:@"%@", usernameText.text];
    NSString* pword = [[NSString alloc] initWithFormat:@"%@", passwordText.text];
    
    //If login is succesful...    
    NSString *registered = [userDB inlog:name passWord:pword];
    if ([registered isEqualToString:@"no_error"])
    {
        //Change title of navigation bar (chat window) to username
        app.userName = name;
        SecondViewController *second = [[SecondViewController alloc]init];
        [second viewWillAppear:YES];
        
        //Close keyboard
        [self textFieldShouldReturn:passwordText];
        [self textFieldShouldReturn:usernameText];
        
        //Switch to chat
        [self.tabBarController setSelectedIndex:1];
        
        //Start getting location
        [locationManager startUpdatingLocation];
        
    }
    //Else show alert
    else {
        UIAlertView *fail = [[UIAlertView alloc] initWithTitle:@"Not logged in" 
                                                        message:registered
                                                       delegate:nil
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK", nil];
        [fail show]; 
        
    }
    
    //Delete text from textfields
    usernameText.text = @"";
    passwordText.text = @"";
    
}

//Function for getting the location
-(void)locationManager:(CLLocationManager *)manager
   didUpdateToLocation:(CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation
{
    NSString *currentLatitude = [[NSString alloc] 
                                 initWithFormat:@"%g", 
                                 newLocation.coordinate.latitude];
    NSLog(@"Latitude: %@", currentLatitude); //Print current latitude
    
    NSString *currentLongitude = [[NSString alloc] 
                                  initWithFormat:@"%g",
                                  newLocation.coordinate.longitude];
    NSLog(@"Longitude: %@", currentLongitude); //Print current longitude
    
    
    
    [currentLatitude release];
    [currentLongitude release];
}




@end
