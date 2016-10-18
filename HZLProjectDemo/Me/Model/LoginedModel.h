//
//  LoginedModel.h
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 10/18/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginedModel : NSObject

@property (nonatomic, copy) NSString *avatarUrl;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, assign) NSInteger followingNum;

@property (nonatomic, assign) NSInteger followedNum;

@property (nonatomic, copy) NSString *desc;

@end
