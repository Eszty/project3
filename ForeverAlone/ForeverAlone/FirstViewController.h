//
//  FirstViewController.h
//  ForeverAlone
//
//  Created by Eszter Fodor on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlipsideViewController.h"

@interface FirstViewController : UIViewController <FlipsideViewControllerDelegate>

@property (nonatomic, retain) IBOutlet UITextField *username;
@property (nonatomic, retain) IBOutlet UITextField *password;
@property (nonatomic, strong) IBOutlet UIButton *login;


@property (nonatomic, strong) IBOutlet UIButton *reg;

- (IBAction)regist:(id)sender;
@end
