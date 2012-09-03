//
//  FlipsideViewController.m
//  ForeverAlone
//
//  Created by Eszter Fodor on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

/****** Class for registration ******/

#import "FlipsideViewController.h"
#import "AppDelegate.h"
#import "FirstViewController.h"
#import "DatabaseFunctions.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface FlipsideViewController ()

@end


@implementation FlipsideViewController

@synthesize delegate;
@synthesize back;

@synthesize userName;
@synthesize passWord;
@synthesize regist;
@synthesize picButton;

DatabaseFunctions* userDB;
UIImagePickerController *mediaUI;
UIImage* avatarImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Flipside", @"Flipside");
        self.tabBarItem.image = [UIImage imageNamed:@"flipside"];
    }
    
    //Initiate DabaseFunctions object
    userDB = [[DatabaseFunctions alloc]init];
    
    return self;
}

- (void)viewDidLoad
{
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

#pragma mark - Actions

//Back button action
- (IBAction)goBack:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
    
}

//Select picture from library
-(IBAction)selectExitingPicture
{
    if([UIImagePickerController isSourceTypeAvailable:
        UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker= [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentModalViewController:picker animated:YES];
        [picker release];
    }
}

//Controller for image picker
-(void)imagePickerController:(UIImagePickerController *)picker
      didFinishPickingImage : (UIImage *)image
                 editingInfo:(NSDictionary *)editingInfo
{
    avatarImage = image;
    [picButton setBackgroundImage:image forState:UIControlStateNormal];
    [picker dismissModalViewControllerAnimated:YES];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)  picker
{
    [picker dismissModalViewControllerAnimated:YES];
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
    [self.passWord resignFirstResponder];
    [self.userName resignFirstResponder];
}

//Registration button action
- (IBAction)registration:(id)sender
{
    //get user input
    NSString* user = [[NSString alloc] initWithFormat:@"%@", userName.text];
    NSString* pword = [[NSString alloc] initWithFormat:@"%@", passWord.text];    
    NSData* imagedata = UIImagePNGRepresentation(avatarImage);
    
    //TODO picture!!
    
    //Send user input to server
    //If registration succesful, user can log in or quit the application
    if ([userDB registerUser:user password:pword image:imagedata])
    {
        UIAlertView *registered = [[UIAlertView alloc] initWithTitle:@"You're registered" 
                                                       message:@"You can now log in" 
                                                      delegate:self
                                             cancelButtonTitle:@"Quit"
                                             otherButtonTitles:@"OK", nil];
        [registered show]; 
        
    }
    else {
        UIAlertView *fail = [[UIAlertView alloc] initWithTitle:@"Registration failed" 
                                                             message:@"Invalid username" 
                                                            delegate:self
                                                   cancelButtonTitle:@"Quit"
                                                   otherButtonTitles:@"OK", nil];
        [fail show]; 
    }
}

//Function for controlling alert buttons
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    //If user clicked OK go to login
    if (buttonIndex == 1)
    {
        [self.delegate flipsideViewControllerDidFinish:self];    
    }
    //Else quit application
    else
    {
        exit(0);
    }
}















@end
