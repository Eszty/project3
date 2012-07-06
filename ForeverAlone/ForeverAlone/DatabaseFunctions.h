//
//  DatabaseFuncties.h
//  ForeverAlone
//
//  Created by Eszter Fodor on 6/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

/***** Class for login and register functions ******/

#import <UIKit/UIKit.h>

@interface DatabaseFunctions : NSObject


- (BOOL)inlog:(NSString*)name passWord:(NSString*)pword;
- (BOOL)registerUser:(NSString*)loginName password:(NSString*)pword;

@end
