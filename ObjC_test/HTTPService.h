//
//  HTTPService.h
//  ObjC_test
//
//  Created by Oleg Pavlichenkov on 03/01/2017.
//  Copyright © 2017 Oleg Pavlichenkov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^onComplete)(NSArray * __nullable dataArray, NSString * __nullable errorMessage);

@interface HTTPService : NSObject

+ (id) instance;
- (void) getTutorials:(nullable onComplete)completionHandler;
- (void) getCommentsForTutorialWith:(NSString *)tutorialId :(nullable onComplete)completionHandler;

@end
