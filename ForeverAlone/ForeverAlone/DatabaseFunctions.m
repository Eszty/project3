//
//  DatabaseFuncties.m
//  ForeverAlone
//
//  Created by Eszter Fodor on 6/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DatabaseFunctions.h"
#import <CoreLocation/CoreLocation.h>

@interface DatabaseFunctions ()

@end

@implementation DatabaseFunctions

@synthesize locationManager;


//Check username and password to login. 
- (void)inlog:(NSString*)name passWord:(NSString*)pword
{
    NSData *username = [name dataUsingEncoding:NSUTF8StringEncoding];
    NSData *password = [pword dataUsingEncoding:NSUTF8StringEncoding];
    
    //TODO: change url to actual login url
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://sammyo.net/Rusic/index.php/login/login_function/%@/%@",name, pword]];
    
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

//BUG: wordt twee keer aangeroepen Why?!? Don't get it...
- (void)registerUser:(NSString*)loginName password:(NSString*)pword
{
    NSData *username = [loginName dataUsingEncoding:NSUTF8StringEncoding];
    NSData *password = [pword dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://sammyo.net/Rusic/index.php/login/register/%@/%@",loginName, pword]];
    
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














@end
