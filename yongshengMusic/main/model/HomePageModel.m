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
    return @{@"banners" : [HomeBannerItem class] };
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"banners"  : @"banner"};
}

@end
@implementation HomeBannerItem

@end
