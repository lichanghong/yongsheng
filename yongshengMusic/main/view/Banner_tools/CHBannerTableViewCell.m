//
//  CHBannerTableViewCell.m
//  yongshengMusic
//
//  Created by lichanghong on 8/12/18.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "CHBannerTableViewCell.h"
#import <SDCycleScrollView.h>
#import <CHBaseUtil/UIView+CHFrame.h>
#import <CHBaseUtil/NSMutableArray+CHSafe.h>
#import "HomePageModel.h"

@interface CHBannerTableViewCell()
@property (nonatomic,strong)SDCycleScrollView *cycleScrollView2;
@end

@implementation CHBannerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KScreenWidth, 180) delegate:nil placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        self.cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        self.cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        [self.contentView addSubview:self.cycleScrollView2];
    }
    return self;
}

- (void)setBanners:(NSArray<HomeBannerItem *> *)banners
{
    _banners = banners;
    if (_banners) {
        NSMutableArray *titles = [NSMutableArray array];
        NSMutableArray *urls = [NSMutableArray array];
        for (HomeBannerItem *item in banners) {
            [titles safeAddObject:item.title];
            [urls safeAddObject:item.img];
        }
        self.cycleScrollView2.titlesGroup = titles;
        self.cycleScrollView2.imageURLStringsGroup = urls;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
