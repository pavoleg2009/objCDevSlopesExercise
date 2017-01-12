//
//  ShowVideoVC.h
//  ObjC_test
//
//  Created by Oleg Pavlichenkov on 03/01/2017.
//  Copyright © 2017 Oleg Pavlichenkov. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VideoData;

@interface ShowVideoVC : UIViewController <UIWebViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) VideoData *videoData;

- (void) updateUI;

@end
