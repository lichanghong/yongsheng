//
//  CHNetRequest.m
//  yongshengMusic
//
//  Created by lichanghong on 9/2/18.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "CHNetRequest.h"
#import <AFNetworking.h>
#import <NSDictionary+CHSafe.h>

@implementation CHNetRequest

+ (void)requestSuccess:(void (^)(id))success failure:(void (^)(NSError *))fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURL *url = [NSURL URLWithString:@"https://raw.githubusercontent.com/lichanghong/yongsheng/master/home.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
  
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:fullPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
       NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:filePath] options:NSJSONReadingMutableLeaves error:nil];
        if ( [resultDic safeIntegerForKey:@"errorCode"] == 0) {
            success([resultDic safeDictionaryForKey:@"responseData"]);
        }
        else
        {
            fail(error);
        }
    }];
    [task resume];
}



@end
