//
//  CHNetRequest.m
//  yongshengMusic
//
//  Created by lichanghong on 9/2/18.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "CHNetRequest.h"
#import <AFNetworking.h>

@implementation CHNetRequest

+ (void)requestSuccess:(void (^)(id))success failure:(void (^)(NSError *))fail
{
    [AFHTTPSessionManager manager] GET:<#(nonnull NSString *)#> parameters:<#(nullable id)#> progress:<#^(NSProgress * _Nonnull downloadProgress)downloadProgress#> success:<#^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)success#> failure:<#^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)failure#>
    success(@"");
}


@end
