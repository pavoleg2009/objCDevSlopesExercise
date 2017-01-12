//
//  VideoData.h
//  ObjC_test
//
//  Created by Oleg Pavlichenkov on 03/01/2017.
//  Copyright © 2017 Oleg Pavlichenkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoData : NSObject

@property (nonatomic, strong) NSString *videoId;
@property (nonatomic, strong) NSString *videoTitle;
@property (nonatomic, strong) NSString *videoDescription;
@property (nonatomic, strong) NSString *videoIframe;
@property (nonatomic, strong) NSString *thumbUrl;

@end
