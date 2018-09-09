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
             @"iconList" : [HomeBannerItem class],
             @"studentWork":[HomeStudentWorkEntity class],
              @"schoolNews": [HomeStudentWorkEntity class]
             };
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"banners"  : @"banner",
             @"iconList"  : @"icon_list",
             @"studentWork": @"student_work",
             @"schoolNews": @"school_news"
             };
}

@end
@implementation HomeBannerItem

@end
@implementation HomeStudentWorkEntity

@end

