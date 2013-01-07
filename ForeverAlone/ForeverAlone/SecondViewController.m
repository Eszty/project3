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
@synthesize username;
@synthesize chatlist;

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
    
    /* Load the users avatar and username */
    avatar.image = [UIImage imageNamed:@"cat"];
    username.text = [@"Welcome " stringByAppendingString:app.userName];
    
    /* Load the chatlist */
    NSArray *chatbots = [[NSArray alloc] initWithObjects:@"Chatbot #1", @"Chatbot #2", @"Chatbot #3", nil];
    chatlist = chatbots;
}

/* Returns number of rows in the chatlist */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [chatlist count];
}

/* Create the chatlists cells */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SimpleTableIdentifier"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SimpleTableIdentifier"];        
    }
    UIImage *cellImage = [UIImage imageNamed:@"chatman.png"];
    cell.imageView.image = cellImage;
    cell.textLabel.text = [chatlist objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = @"Tap to chat";
    return cell;
}

/* Gets fired when a row in chatlist is tapped */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Chatbot"
                                                    message: @"Ik ben Chatman. Super snel met MSN. Er is niemand die me niet kent."
                                                    delegate:self
                                                    cancelButtonTitle:@"Close"
                                                    otherButtonTitles:nil];
    
    [alert show];
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
}

//Go back to login
- (IBAction)goBack:(id)sender
{
    [self.tabBarController setSelectedIndex:0];
    
}




@end
