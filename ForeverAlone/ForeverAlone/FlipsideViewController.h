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


@interface FlipsideViewController : UIViewController


@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;

@property (nonatomic, retain) UIBarButtonItem *back;

- (IBAction)goBack:(id)sender;


@end


