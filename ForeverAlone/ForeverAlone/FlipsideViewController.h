//
//  FlipsideViewController.h
//  ForeverAlone
//
//  Created by Eszter Fodor on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end


@interface FlipsideViewController : UIViewController < UIImagePickerControllerDelegate ,UINavigationControllerDelegate>



@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;

@property (nonatomic, retain) UIBarButtonItem *back;
@property (nonatomic, strong) UITextField *firstName;
@property (nonatomic, strong) UITextField *lastName;
@property (nonatomic, strong) UITextField *email;
@property (nonatomic, strong) UIButton *regist;
@property (nonatomic, strong) UIButton *picButton;


- (IBAction)goBack:(id)sender;
- (IBAction)registerUser:(id)sender;

- (IBAction)showSavedMediaBrowser:(id)sender;
- (BOOL) startMediaBrowserFromViewController: (UIViewController*) controller
                               usingDelegate: (id <UIImagePickerControllerDelegate,
                                               UINavigationControllerDelegate>) delegate;

@end


