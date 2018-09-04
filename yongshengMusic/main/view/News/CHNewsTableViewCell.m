//
//  CHNewsTableViewCell.m
//  yongshengMusic
//
//  Created by 李长鸿 on 2018/9/4.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "CHNewsTableViewCell.h"
#import <CHBaseUtil/UIView+CHFrame.h>

@implementation CHNewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        self.mImageView = [[UIImageView alloc]init];
        self.title     = [[UILabel alloc]init];
        self.subTitle  = [[UILabel alloc]init];
        [self.contentView addSubview:self.mImageView];
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.subTitle];
        self.mImageView.frame = CGRectMake(10, 5, 95, 70);
        self.title.frame      = CGRectMake(120, 15, KScreenWidth-110, 20);
        self.subTitle.frame   = CGRectMake(120, 45, KScreenWidth-110, 20);
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
