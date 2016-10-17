//
//  LoginView.h
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 10/17/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView
@property (weak, nonatomic) IBOutlet UIButton *cancelLoginBtn;

@property (weak, nonatomic) IBOutlet UILabel *sinaLabel;
@property (weak, nonatomic) IBOutlet UILabel *qqLabel;
@property (weak, nonatomic) IBOutlet UILabel *wechatLabel;


+(instancetype)shareView;

@end
