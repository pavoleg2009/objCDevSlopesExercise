//
//  VideoCell.m
//  ObjC_test
//
//  Created by Oleg Pavlichenkov on 03/01/2017.
//  Copyright © 2017 Oleg Pavlichenkov. All rights reserved.
//

#import "VideoCell.h"

@interface VideoCell()
@property (weak, nonatomic) IBOutlet UIImageView *thumbImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIView *cellView;


@end

@implementation VideoCell



- (void)awakeFromNib {
    [super awakeFromNib]; // there is no this line in tutorial
    
    self.cellView.layer.cornerRadius = 2.0;
    self.cellView.layer.shadowColor = [UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:1.0].CGColor;
    self.cellView.layer.shadowOpacity = 0.8;
    self.cellView.layer.shadowRadius = 5.0;
    self.cellView.layer.shadowOffset = CGSizeMake(0.0, 2.0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) updateUI {
    
    if (self.videoData) {
        self.titleLabel.text = self.videoData.videoTitle;
        self.descriptionLabel.text = self.videoData.videoDescription;
    
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.videoData.thumbUrl]]];
        self.thumbImage.image = image;
    }
    
}

@end
