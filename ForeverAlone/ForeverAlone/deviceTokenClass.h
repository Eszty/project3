//
//  deviceTokenClass.h
//  ForeverAlone
//
//  Created by Bobby Odenhoven on 07-01-13.
//
//

#import <Foundation/Foundation.h>

@interface deviceTokenClass : NSObject {
    NSString *deviceToken;
}
@property(nonatomic, retain) NSString *devicetoken;
+(deviceTokenClass*)getInstance;
@end
