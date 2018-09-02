//
//  HomeBanner.m
//  yongshengMusic
//
//  Created by lichanghong on 9/2/18.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "HomePageModel.h"

@implementation HomePageModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"banners" : [HomeBannerItem class],
             @"iconList" : [HomeBannerItem class]
             };
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"banners"  : @"banner",
             @"iconList"  : @"icon_list",
             };
}

@end
@implementation HomeBannerItem

@end
