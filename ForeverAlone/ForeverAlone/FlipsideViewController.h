//
//  FlipsideViewController.h
//  ForeverAlone
//
//  Created by Eszter Fodor on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end


@interface FlipsideViewController : UIViewController < UIImagePickerControllerDelegate ,UINavigationControllerDelegate, UITextFieldDelegate>



//@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;

@property (unsafe_unretained, nonatomic) IBOutlet id<FlipsideViewControllerDelegate> delegate;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *back;

@property (nonatomic, retain) IBOutlet UITextField *userName;
@property (nonatomic, retain) IBOutlet UITextField *passWord;
@property (nonatomic, strong) IBOutlet UIButton *regist;
@property (nonatomic, strong) IBOutlet UIButton *picButton;


- (IBAction)goBack:(id)sender;


- (IBAction)showSavedMediaBrowser:(id)sender;
- (BOOL) startMediaBrowserFromViewController: (UIViewController*) controller
                               usingDelegate: (id <UIImagePickerControllerDelegate,
                                               UINavigationControllerDelegate>) delegate;

- (BOOL)textFieldShouldReturn:(UITextField *) theTextField;
- (void)textFieldDidEndEditing:(UITextField *)textField;
- (IBAction)registration:(id)sender;
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event touch:(UITextField*)textField;



@end


