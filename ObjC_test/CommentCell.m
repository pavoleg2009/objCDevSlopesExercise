//
//  CommentCell.m
//  ObjC_test
//
//  Created by Oleg Pavlichenkov on 12/01/2017.
//  Copyright © 2017 Oleg Pavlichenkov. All rights reserved.
//

#import "CommentCell.h"
#import "CommentData.h"

@interface CommentCell()

@property (weak, nonatomic) IBOutlet UILabel *commentContentLabel;

@end


@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateUI {
    if (self.commentData) {
        self.commentContentLabel.text = self.commentData.commentContent;

    }
}

@end
