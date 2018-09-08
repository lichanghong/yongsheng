//
//  CHAliProductTableViewCell.m
//  yongshengMusic
//
//  Created by 李长鸿 on 2018/9/6.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "CHAliProductTableViewCell.h"
#import <CHBaseUtil/UIView+CHFrame.h>
#import "HomeAliModel.h"
#import <UIImageView+WebCache.h>

@implementation CHAliProductTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        self.mImageView = [[UIImageView alloc]init];
        self.titleLabel     = [[UILabel alloc]init];
        self.priceLabel  = [[UILabel alloc]init];
        self.subpriceLabel  = [[UILabel alloc]init];
        self.salesLabel  = [[UILabel alloc]init];
        [self.contentView addSubview:self.mImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.priceLabel];
        [self.contentView addSubview:self.subpriceLabel];
        [self.contentView addSubview:self.salesLabel];
        self.mImageView.frame = CGRectMake(10, 5, 95, 70);
        self.titleLabel.frame      = CGRectMake(120, 15, KScreenWidth-110, 20);
        self.priceLabel.frame   = CGRectMake(120, 45, KScreenWidth-110, 20);
        self.subpriceLabel.frame   = CGRectMake(180, 45, KScreenWidth-110, 20);
        self.salesLabel.frame   = CGRectMake(120, 65, KScreenWidth-110, 20);
    }
    return self;
}

- (void)setAliItemEntity:(HomeAliItemEntity *)aliItemEntity
{
    if (!aliItemEntity) {
        return;
    }
    _aliItemEntity = aliItemEntity;
    [self.mImageView sd_setImageWithURL:[NSURL URLWithString:aliItemEntity.img]];
    self.titleLabel.text = aliItemEntity.title;
    self.priceLabel.text = aliItemEntity.price;
    self.subpriceLabel.text = aliItemEntity.after_ticket_price;
    self.salesLabel.text = aliItemEntity.sale_num;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
