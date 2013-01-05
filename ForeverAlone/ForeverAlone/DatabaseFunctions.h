//
//  DatabaseFuncties.h
//  ForeverAlone
//
//  Created by Eszter Fodor on 6/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

/***** Class for login and register functions ******/

#import <UIKit/UIKit.h>

@interface DatabaseFunctions : NSObject {
}

extern NSData *devicetoken;

- (NSString*)inlog:(NSString*)name passWord:(NSString*)pword;
- (NSString*)registerUser:(NSString*)loginName password:(NSString*)pword image:(NSData*)avatarImage;

@end
