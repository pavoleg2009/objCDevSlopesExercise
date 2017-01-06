//
//  VideoCell.h
//  ObjC_test
//
//  Created by Oleg Pavlichenkov on 03/01/2017.
//  Copyright © 2017 Oleg Pavlichenkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoData.h"

@interface VideoCell : UITableViewCell
@property (nonatomic, strong) VideoData *videoData;
- (void) updateUI;
@end
