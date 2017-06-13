//
//  HZLNetManager.m
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 9/25/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "HZLNetManager.h"
@interface HZLNetManager()

@property (nonatomic, strong) AFHTTPSessionManager *requestDataManager;

@end
static HZLNetManager *manager = nil;
@implementation HZLNetManager


+ (instancetype)defaultManager
{
        
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
            if (!manager) {
                
                manager = [[HZLNetManager alloc] initPrivate];
            }
        });
    return manager;
}

- (instancetype)init
{
    NSException * ex = [[NSException alloc] initWithName:@"方法错误" reason:@"仅能使用单列方法" userInfo:nil];
    @throw ex;
    
    
}
- (instancetype)initPrivate
{
    
    
    if (self = [super init]) {
        
        _requestDataManager = [AFHTTPSessionManager manager];
        _requestDataManager.responseSerializer.acceptableContentTypes = [_requestDataManager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
        
        //Add http-authorization to header
        [_requestDataManager.requestSerializer setValue:@"e573a54a012811e6beb85254001b74f1" forHTTPHeaderField:@"HTTP-AUTHORIZATION"];
    }
    return self;
}

- (void)requestDataByGetWithURL:(NSString *)url success:(void (^)(id))response failure:(void (^)(NSError *))failure
{
   
    [_requestDataManager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        response(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);

    }];
    
}

@end
