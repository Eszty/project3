//
//  FirstViewController.h
//  ForeverAlone
//
//  Created by Eszter Fodor on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlipsideViewController.h"
#import <CoreLocation/CoreLocation.h>


@interface FirstViewController : UIViewController <FlipsideViewControllerDelegate, UITextFieldDelegate, CLLocationManagerDelegate>

@property (nonatomic, retain) IBOutlet CLLocationManager *locationManager;

@property (unsafe_unretained, nonatomic) IBOutlet id<FlipsideViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UITextField *usernameText;
@property (nonatomic, retain) IBOutlet UITextField *passwordText;
@property (nonatomic, strong) IBOutlet UIButton *login;
@property (nonatomic, strong) IBOutlet UIButton *reg;



- (IBAction)regist:(id)sender;
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (BOOL)textFieldShouldReturn:(UITextField *) theTextField;
- (void)textFieldDidEndEditing:(UITextField *)textField;
- (IBAction)userLogin:(id)sender;
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation;
@end
