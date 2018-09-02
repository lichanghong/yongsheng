//
//  CHNetRequest.h
//  yongshengMusic
//
//  Created by lichanghong on 9/2/18.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHNetRequest : NSObject

+ (void)requestSuccess:(void(^)(id result))success failure:(void(^)(NSError *error))fail;

@end
