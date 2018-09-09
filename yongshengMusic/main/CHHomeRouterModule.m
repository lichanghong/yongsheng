//
//  CHHomeRouterModule.m
//  yongshengMusic
//
//  Created by 李长鸿 on 2018/9/6.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "CHHomeRouterModule.h"
#import <AFWebViewController.h>
#import <CHBaseUtil.h>


NSString * API_Home = @"https://raw.githubusercontent.com/lichanghong/yongsheng/master/api/home.json";
NSString * API_Home_study = @"https://raw.githubusercontent.com/lichanghong/yongsheng/master/api/home_study.json";
NSString * API_Home_ali = @"https://raw.githubusercontent.com/lichanghong/yongsheng/master/api/home_ali.json";

NSString *const CHRouterHomeURLPattern = @"com.haihong://router/home";

@implementation CHHomeRouterModule


- (NSArray *)routerURLs
{
    return @[CHRouterHomeURLPattern];
}

- (CHRouterResponse *)handleURL:(NSString *)url handleInfo:(CHRouterHandleInfo *)handleInfo
{
    CHRouterResponse *response = [[CHRouterResponse alloc] init];
//    NSDictionary *parameters = handleInfo.parameters; // 入参
    
    UIViewController *targetViewController = nil;
    if ([url isEqualToString:CHRouterHomeURLPattern]) {
        AFWebViewController *webViewController = [AFWebViewController webViewControllerWithAddress:@"https://baidu.com"];
        webViewController.toolbarTintColor = [UIColor orangeColor]; // Does not work on iPad
        targetViewController = webViewController;
    }
    
    [self transitionViewController:targetViewController WithHandleInfo:handleInfo animated:YES];
    response.returnMessage = @"处理成功";
    
    //success block responseCallBack
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self handleCallbackWithURL:url responseActionName:@"editedCalendarInfo" responseActionParams:parameters];
//    });
    return response;
}


@end
