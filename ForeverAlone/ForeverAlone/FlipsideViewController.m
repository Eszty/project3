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

@interface FlipsideViewController ()

@end


@implementation FlipsideViewController

@synthesize delegate;
@synthesize back;
@synthesize firstName;
@synthesize lastName;
@synthesize userName;
@synthesize passWord;
@synthesize regist;
@synthesize picButton;

DatabaseFunctions* userDB;

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

- (IBAction)registerUser:(id)sender
{
    //TODO: send user information & picture to database
}


- (BOOL) startMediaBrowserFromViewController: (UIViewController*) controller
                               usingDelegate: (id <UIImagePickerControllerDelegate,
                                               UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
        || (controller == nil))
        return NO;
    
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    // Displays saved pictures and movies, if both are available, from the
    // Camera Roll album.
    mediaUI.mediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:
     UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    mediaUI.allowsEditing = NO;
    
    [controller presentModalViewController: mediaUI animated: YES];
    return YES;
}

- (IBAction) showSavedMediaBrowser:(id)sender {
    [self startMediaBrowserFromViewController: self
                                usingDelegate: self];
}

//Close keyboard on 'return'
- (BOOL)textFieldShouldReturn:(UITextField *) theTextField {
    [theTextField resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {   
    [textField resignFirstResponder]; 
}


- (IBAction)registration:(id)sender
{
    NSString* first = [[NSString alloc] initWithFormat:@"%@", firstName.text];
    NSString* last = [[NSString alloc] initWithFormat:@"%@", lastName.text];
    NSString* user = [[NSString alloc] initWithFormat:@"%@", userName.text];
    NSString* pword = [[NSString alloc] initWithFormat:@"%@", passWord.text];
    
    //TODO picture!
    
    [userDB registerUser:first lastName:last user:user password:pword];
}

















@end
