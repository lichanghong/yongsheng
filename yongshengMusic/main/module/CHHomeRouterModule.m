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
NSString * API_Home_study = @"https://raw.githubusercontent.com/lichanghong/yongsheng/master/api/home_study2.json";
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
    NSDictionary *parameters = handleInfo.parameters; // 入参
    NSArray *imgs = [parameters safeArrayForKey:@"imgs"];
    UIViewController *targetViewController = nil;
    if ([url isEqualToString:CHRouterHomeURLPattern]) {
        NSMutableString *html = [NSMutableString string];
        for (int i=0; i<imgs.count; i++) {
            NSString *img = [[NSString alloc]initWithFormat:@"<img src=\"%@\"/> <br/>",[imgs safeObjectAtIndex:i]];
            [html appendString:img];
        }
 
        AFWebViewController *webViewController = [AFWebViewController
         webViewControllerWithHTMLString:html andBaseURL:nil];
        webViewController.navigationItem.title = [parameters safeStringForKey:@"pagetitle"];
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
