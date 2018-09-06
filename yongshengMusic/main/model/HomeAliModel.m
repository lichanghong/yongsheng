//
//  HomeAliModel.m
//  yongshengMusic
//
//  Created by 李长鸿 on 2018/9/6.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "HomeAliModel.h"

@implementation HomeAliModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"aliModel" : [HomeAliItemEntity class]
             };
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"aliModel"  : @"products"
           
             };
}
@end

@implementation HomeAliItemEntity

@end

