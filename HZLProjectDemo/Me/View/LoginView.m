//
//  LoginView.m
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 10/17/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView





+(instancetype)shareView
{
    
    LoginView * view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.9];
    
    return view;
}


@end
