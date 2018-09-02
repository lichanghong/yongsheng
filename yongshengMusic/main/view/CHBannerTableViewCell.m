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


@implementation CHBannerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray* urls = @[@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3632476635,370760416&fm=27&gp=0.jpg",
                          @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1520944054455&di=cc47835e24392e6ffa51463539524301&imgtype=0&src=http%3A%2F%2Fpic2.ooopic.com%2F10%2F57%2F50%2F93b1OOOPIC4d.jpg",
                          @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2275205136,3989077551&fm=27&gp=0.jpg",
                          @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1521024592371&di=f05bd0d4e516f152bf7587ac7c8ebf5b&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01164155448e950000019ae95d8b93.jpg"
                          ];
        NSArray *titles = @[@"我就是李长鸿 ",
                            @"没错，这东西，我写的！",
                            @"很贱吧？你打我啊。。。",
                            @"呵呵，怕了吧~",
                            @"滚回家睡大觉吧，不然呢~"
                            ];
        
        SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KScreenWidth, 180) delegate:nil placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        cycleScrollView2.titlesGroup = titles;
        cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        [self.contentView addSubview:cycleScrollView2];
        
        //         --- 模拟加载延迟
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            cycleScrollView2.imageURLStringsGroup = urls;
        });
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
