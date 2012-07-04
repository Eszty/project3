//
//  DatabaseFuncties.h
//  ForeverAlone
//
//  Created by Eszter Fodor on 6/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface DatabaseFunctions : NSObject

@property (nonatomic, retain) IBOutlet CLLocationManager *locationManager;

- (BOOL)inlog:(NSString*)name passWord:(NSString*)pword;
//- (void)registerUser:(NSString*)firstName surName:(NSString*)surName userName:(NSString*)username passWord:(NSString*)password;
- (BOOL)registerUser:(NSString*)loginName password:(NSString*)pword;

@end
