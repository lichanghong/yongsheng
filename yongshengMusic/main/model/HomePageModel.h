//
//  HomeBanner.h
//  yongshengMusic
//
//  Created by lichanghong on 9/2/18.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HomeBannerItem,HomeStudentWorkEntity;
@interface HomePageModel : NSObject
@property (nonatomic,strong) NSArray <HomeBannerItem *>*banners;
@property (nonatomic,strong) NSArray <HomeBannerItem *>*iconList;
@property (nonatomic,strong) NSArray <HomeStudentWorkEntity *>*studentWork;

@end

@interface HomeBannerItem:NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *img;
@property (nonatomic,strong) NSString *url;

@end

@interface HomeStudentWorkEntity:NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *img;
@property (nonatomic,strong) NSString *url;user_selfie
@property (nonatomic,strong) NSString *user_selfie
@property (nonatomic,strong) NSString *nick_name;

@end
