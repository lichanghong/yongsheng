//
//  HomeCourceModel.h
//  yongshengMusic
//
//  Created by 李长鸿 on 2018/9/8.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HomeCourceItem;
@interface HomeCourceModel : NSObject
@property (nonatomic,strong) NSArray <HomeCourceItem *>*cource;

@end

@interface HomeCourceItem : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSArray *imgs;

@end
