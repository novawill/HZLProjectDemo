//
//  LoginedView.h
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 10/18/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginedModel.h"
@interface LoginedView : UIView

@property (nonatomic, strong) LoginedModel *model;

+ (instancetype)shareView;

@end
