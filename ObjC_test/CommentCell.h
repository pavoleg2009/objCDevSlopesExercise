//
//  CommentCell.h
//  ObjC_test
//
//  Created by Oleg Pavlichenkov on 12/01/2017.
//  Copyright © 2017 Oleg Pavlichenkov. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommentData;

@interface CommentCell : UITableViewCell

@property (nonatomic, strong) CommentData *commentData;

- (void)updateUI;
    
@end
