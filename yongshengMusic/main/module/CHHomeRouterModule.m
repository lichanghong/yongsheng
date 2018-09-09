//
//  CHHomeRouterModule.m
//  yongshengMusic
//
//  Created by 李长鸿 on 2018/9/6.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "CHHomeRouterModule.h"
#import <CHBaseUtil.h>
#import <UIImageView+WebCache.h>
#import <AXWebViewController.h>


NSString * API_Home = @"https://raw.githubusercontent.com/lichanghong/yongsheng/master/api/home.json";
NSString * API_Home_study = @"https://raw.githubusercontent.com/lichanghong/yongsheng/master/api/home_study.json";
NSString * API_Home_ali = @"https://raw.githubusercontent.com/lichanghong/yongsheng/master/api/home_ali.json";

NSString *const CHRouterHomeURLPattern = @"com.haihong://router/home";
NSString *const CHRouterPurchaseURLPattern = @"com.haihong://router/purchase";

@implementation CHHomeRouterModule


- (NSArray *)routerURLs
{
    return @[CHRouterHomeURLPattern,CHRouterPurchaseURLPattern];
}

- (CHRouterResponse *)handleURL:(NSString *)url handleInfo:(CHRouterHandleInfo *)handleInfo
{
    CHRouterResponse *response = [[CHRouterResponse alloc] init];
    NSDictionary *parameters = handleInfo.parameters; // 入参
    UIViewController *targetViewController = nil;
    if ([url isEqualToString:CHRouterHomeURLPattern]) {
        NSArray *imgs = [parameters safeArrayForKey:@"imgs"];
        NSInteger show = [parameters safeIntegerForKey:@"show_bar"];
        NSMutableString *html = [NSMutableString string];
        for (int i=0; i<imgs.count; i++) {
            NSString *img = [[NSString alloc]initWithFormat:@"<img src=\"%@\"/> <br/>",[imgs safeObjectAtIndex:i]];
            [html appendString:img];
        }
        
        AXWebViewController *webVC = [[AXWebViewController alloc]initWithHTMLString:html baseURL:nil];
        if (show != 0) {
            webVC.showsToolBar = YES;
            webVC.navigationType = AXWebViewControllerNavigationToolItem;
        }
        webVC.navigationItem.title = [parameters safeStringForKey:@"pagetitle"];
        webVC.navigationController.navigationBar.translucent = NO;
        targetViewController = webVC;
    }
   else if ([url isEqualToString:CHRouterPurchaseURLPattern]) {
       NSString *target_url = [parameters safeStringForKey:@"target_url"];
       AXWebViewController *webVC = [[AXWebViewController alloc]initWithAddress:target_url];
       webVC.showsToolBar = YES;
       webVC.navigationType = AXWebViewControllerNavigationToolItem;
       webVC.navigationItem.title = [parameters safeStringForKey:@"pagetitle"];
       webVC.navigationController.navigationBar.translucent = NO;
       targetViewController = webVC;
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
