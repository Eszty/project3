//
//  deviceTokenClass.m
//  ForeverAlone
//
//  Created by Bobby Odenhoven on 07-01-13.
//
//

#import "deviceTokenClass.h"

@implementation deviceTokenClass
@synthesize devicetoken;
static deviceTokenClass *instance = nil;

+(deviceTokenClass*)getInstance {
    @synchronized(self)
    {
        if(instance==nil)
        {
            
            instance= [deviceTokenClass new];
        }
    }
    return instance;
}
@end
