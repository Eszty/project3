//
//  FlipsideViewController.m
//  ForeverAlone
//
//  Created by Eszter Fodor on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

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

int flag;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Flipside", @"Flipside");
        self.tabBarItem.image = [UIImage imageNamed:@"flipside"];
    }
    
    userDB = [[DatabaseFunctions alloc]init];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
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

#pragma mark - Actions

- (IBAction)goBack:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
    
}


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


-(void)imagePickerController:(UIImagePickerController *)picker
      didFinishPickingImage : (UIImage *)image
                 editingInfo:(NSDictionary *)editingInfo
{
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

- (IBAction)registration:(id)sender
{
    NSString* user = [[NSString alloc] initWithFormat:@"%@", userName.text];
    NSString* pword = [[NSString alloc] initWithFormat:@"%@", passWord.text];
    
    //TODO picture!!
    
    if ([userDB registerUser:user password:pword])
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
