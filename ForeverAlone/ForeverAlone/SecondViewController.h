//
//  SecondViewController.h
//  ForeverAlone
//
//  Created by Eszter Fodor on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSArray *chatlist;
}

@property (nonatomic, retain) IBOutlet UINavigationBar *navigation;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *back;
@property (nonatomic, retain) IBOutlet UIImageView *avatar;
@property (nonatomic, retain) IBOutlet UILabel *username;
@property (nonatomic, retain) IBOutlet NSArray *chatlist;

- (void)viewWillAppear:(BOOL)animated;
- (IBAction)goBack:(id)sender;

@end
