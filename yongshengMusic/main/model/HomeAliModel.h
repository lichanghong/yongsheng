//
//  HomeAliModel.h
//  yongshengMusic
//
//  Created by 李长鸿 on 2018/9/6.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeAliItemEntity:NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *img;
@property (nonatomic,strong) NSString *target_url;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *after_ticket_price;
@property (nonatomic,strong) NSString *sale_num;

@end


@interface HomeAliModel : NSObject
@property (nonatomic,strong) NSArray <HomeAliItemEntity *>*aliModel;

 
@end
