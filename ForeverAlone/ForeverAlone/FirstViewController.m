//
//  FirstViewController.m
//  ForeverAlone
//
//  Created by Eszter Fodor on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#import "AppDelegate.h"
#import "mysql.h"
#import "stdio.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize usernameText;
@synthesize passwordText;
@synthesize login;
@synthesize reg;
@synthesize delegate;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
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

- (IBAction)dbTest:(id)sender
{
    NSString *name = [NSString stringWithFormat:@"%@", usernameText.text];
    NSString *pword = [NSString stringWithFormat:@"%@", passwordText.text];
    
    NSData *username = [name dataUsingEncoding:NSUTF8StringEncoding];
    NSData *password = [pword dataUsingEncoding:NSUTF8StringEncoding];
    
    //NSURL *url = [NSURL URLWithString:@"http://sammyo.net/Rusic/index.php/login/register/%@/%@",username, password];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://sammyo.net/Rusic/index.php/login/register/%@/%@",name, pword]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:username];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:password];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    NSString *dataString = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
    
    NSLog(@"responseData: %@", dataString);
    
    
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
