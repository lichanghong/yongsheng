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
        [self.mImageView setContentMode:UIViewContentModeScaleAspectFill];
        [self.mImageView setClipsToBounds:YES];
        
        self.titleLabel     = [[UILabel alloc]init];
        self.titleLabel.numberOfLines = 0;
        [self.titleLabel setFont:[UIFont systemFontOfSize:15]];
        
        self.priceLabel  = [[UILabel alloc]init];
        [self.priceLabel setFont:[UIFont systemFontOfSize:14]];

        self.subpriceLabel  = [[UILabel alloc]init];
        [self.subpriceLabel setFont:[UIFont systemFontOfSize:16]];
        [self.subpriceLabel setTextColor:[UIColor redColor]];
        [self.subpriceLabel setTextAlignment:NSTextAlignmentRight];

        self.salesLabel  = [[UILabel alloc]init];
        [self.salesLabel setFont:[UIFont systemFontOfSize:13]];

        [self.contentView addSubview:self.mImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.priceLabel];
        [self.contentView addSubview:self.subpriceLabel];
        [self.contentView addSubview:self.salesLabel];
        
        self.mImageView.frame = CGRectMake(5, 5, 110, 110);
        self.titleLabel.frame      = CGRectMake(130, 10, KScreenWidth-140, 40);
        self.priceLabel.frame   = CGRectMake(130, 60, KScreenWidth-130, 20);
        self.subpriceLabel.frame   = CGRectMake(KScreenWidth/2.0, 60, KScreenWidth/2.0-20, 20);
        self.salesLabel.frame   = CGRectMake(130, 120-30, KScreenWidth-110, 20);
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
    
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",aliItemEntity.price] attributes:attribtDic];
    self.priceLabel.attributedText = attribtStr;
    
    self.subpriceLabel.text = [NSString stringWithFormat:@"%@",aliItemEntity.after_ticket_price];
    self.salesLabel.text = [NSString stringWithFormat:@"%@",aliItemEntity.sale_num];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
