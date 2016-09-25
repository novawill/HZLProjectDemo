//
//  HZLNetManager.h
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 9/25/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface HZLNetManager : AFHTTPSessionManager

+ (instancetype)defaultManager;


//Get方法
- (void)requestDataByGetWithURL:(NSString *)url success:(void(^)(id response))response failure:(void(^)(NSError * error))failure;

@end
