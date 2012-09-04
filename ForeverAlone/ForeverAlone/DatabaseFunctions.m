//
//  DatabaseFuncties.m
//  ForeverAlone
//
//  Created by Eszter Fodor on 6/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

/***** Class for login and register functions ******/

#import "DatabaseFunctions.h"


@interface DatabaseFunctions ()

@end

@implementation DatabaseFunctions



//Check username and password to login. 
- (BOOL)inlog:(NSString*)name passWord:(NSString*)pword
{
    //Get user input
    NSData *username = [name dataUsingEncoding:NSUTF8StringEncoding];
    NSData *password = [pword dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://sammyo.net/Rusic/index.php/login/login_function/%@/%@",name, pword]];
    
    //Send request to URL
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:username];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:password];
    
    //Get response from server
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    NSString *dataString = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
    
    //Check if login succesful
    NSString *searchString = @"unsuccesfull";
    NSRange range = [dataString rangeOfString:searchString];
    
    //Return YES if login is succesful else NO
    if (range.location == NSNotFound) {
        return YES;
    }
    else {
        return NO;
    }
}


//TODO: add picture (HOW?)
//Registration function
- (BOOL)registerUser:(NSString*)loginName password:(NSString*)pword image:(NSData*)imageData
{
    //Get user input
    NSData *username = [loginName dataUsingEncoding:NSUTF8StringEncoding];
    NSData *password = [pword dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *post = [NSString stringWithFormat:@"username=%@&password=%@", username, password];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://sammyo.net/alone/register.php"]];
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];                                    
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    NSString* boundary = @"akljsdflkadsfjfd";
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // append username
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"username\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", username] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //append password
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"password\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", password] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // add image data
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"avatarImage\"; filename=\"image.png\"\r\n", @"image.png"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithString:@"Content-Type: image/png\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%d", [body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    // set URL
    [request setURL:url];
    
    
    //Get response from server
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    NSString *dataString = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
    NSLog(@"response from server: %@", dataString);
    
    //Check if registration succesful
    NSString *searchString = @"unsuccesfull";
    NSRange range = [dataString rangeOfString:searchString];
    
    //Return YES if registration is succesful, else NO
    if (range.location == NSNotFound) {
        return YES;
    }
    else {
        return NO;
    }
    
}

@end
