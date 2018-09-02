//
//  CHBannerTableViewCell.h
//  yongshengMusic
//
//  Created by lichanghong on 8/12/18.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "CHBaseTableViewCell.h"

@class HomeBannerItem;
@interface CHBannerTableViewCell : CHBaseTableViewCell
@property (nonatomic,strong)NSArray <HomeBannerItem *> *banners;
@end
