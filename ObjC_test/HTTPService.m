//
//  HTTPService.m
//  ObjC_test
//
//  Created by Oleg Pavlichenkov on 03/01/2017.
//  Copyright © 2017 Oleg Pavlichenkov. All rights reserved.
//

#import "HTTPService.h"
#define URL_BASE "http://localhost:6069"
#define URL_TUTORIALS "/tutorials"

@implementation HTTPService

+ (id) instance {
    static HTTPService *sharedInstance = nil;
    
    @synchronized (self) {
        if (!sharedInstance)
            sharedInstance = [self new];
    }
    
    return sharedInstance;
}

- (void) getTutorials:(nullable onComplete)completionHandler {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%s", URL_BASE, URL_TUTORIALS]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // completion block
        
        if (data) {
            NSError *err; // error for parsing json
            NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
            if (!err) {
                completionHandler(json, nil);
            } else {
                completionHandler(nil, [NSString stringWithFormat:@"== Error parsing JSON: %@", err.debugDescription]);
            }
            
        } else {
            NSLog(@"== Error retriving JSON: %@", error.debugDescription);
        }
    }] resume];
}

@end
