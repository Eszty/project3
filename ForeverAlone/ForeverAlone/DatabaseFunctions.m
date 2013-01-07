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

@implementation DatabaseFunctions;



//Check username and password to login. 
- (NSString*)inlog:(NSString*)name passWord:(NSString*)pword
{    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://sammyo.net/alone/login.php"]];
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    // set Content-Type in HTTP header
    NSString* boundary = @"akljsdflkadsfjfd";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // append username
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"username\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", name] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //append password
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"password\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", pword] dataUsingEncoding:NSUTF8StringEncoding]];
    
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
    //NSLog(@"response from server: %@", dataString);
    
    /* Check if login was successful */
    NSString* error_found = @"no_error";
    NSString *searchString = @"wrong_password";
    NSRange range = [dataString rangeOfString:searchString];
    
    if (range.location != NSNotFound) {
        error_found = @"Wrong password provided";
    }
    
    searchString = @"wrong_user_pass";
    range = [dataString rangeOfString:searchString];
    
    if (range.location != NSNotFound) {
        error_found = @"Wrong username and/or password";
    }
    return error_found;
}


//Registration function
- (NSString*)registerUser:(NSString*)loginName password:(NSString*)pword image:(NSData*)imageData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *devicetoken = [defaults objectForKey:@"device_token"];
    NSLog(@"devicetoken in register(): %@", devicetoken);
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
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", loginName] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //append password
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"password\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", pword] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    // append device token
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"devicetoken\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", devicetoken] dataUsingEncoding:NSUTF8StringEncoding]];
    
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
    
    /* Check if login was successful */
    NSString *error_found = @"no_error";
    /* Look for empty username/password error */
    NSString *searchString = @"no_username_or_password";
    NSRange range = [dataString rangeOfString:searchString];
    
    if (range.location != NSNotFound) {
        error_found = @"Please provide a username and password.";
    }
    
    /* Check if username is already taken */
    searchString = @"username_taken";
    range = [dataString rangeOfString:searchString];
    
    if (range.location != NSNotFound) {
        error_found = @"This username has already been taken. Please choose another one.";
    }
    
    /* Check if username is of invalid length */
    searchString = @"username_invalid_length";
    range = [dataString rangeOfString:searchString];
    
    if (range.location != NSNotFound) {
        error_found = @"Username must be between 4 and 30 characters.";
    }
    
    /* Check if avatar image was received and saved */
    searchString = @"no_image received";
    range = [dataString rangeOfString:searchString];
    
    if (range.location != NSNotFound) {
        error_found = @"no_image";
    }
    
    return error_found;    
}

@end
