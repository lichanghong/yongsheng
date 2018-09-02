//
//  HomeBanner.h
//  yongshengMusic
//
//  Created by lichanghong on 9/2/18.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HomeBannerItem;
@interface HomePageModel : NSObject
@property (nonatomic,strong) NSArray <HomeBannerItem *>*banners;

@end

@interface HomeBannerItem:NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *img;
@property (nonatomic,strong) NSString *url;

@end
