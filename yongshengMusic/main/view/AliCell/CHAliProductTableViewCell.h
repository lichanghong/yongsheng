//
//  CHAliProductTableViewCell.h
//  yongshengMusic
//
//  Created by 李长鸿 on 2018/9/6.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeAliItemEntity;
@interface CHAliProductTableViewCell : UITableViewCell

@property (nonatomic,strong)HomeAliItemEntity *aliItemEntity;


@property (nonatomic,strong)UIImageView *mImageView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UILabel *subpriceLabel;
@property (nonatomic,strong)UILabel *salesLabel;

@end
