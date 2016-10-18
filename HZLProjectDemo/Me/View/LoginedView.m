//
//  LoginedView.m
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 10/18/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "LoginedView.h"
@interface LoginedView()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;


@end
@implementation LoginedView


- (void)setModel:(LoginedModel *)model
{
    _model = model;
    _avatarImageView.layer.masksToBounds = YES;
    _avatarImageView.layer.cornerRadius = 50;
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:_model.avatarUrl]];
    
    _userNameLabel.text = _model.userName;
    
    _descLabel.text = _model.desc;
    
    
}
+ (instancetype)shareView
{
    LoginedView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    
    return view;
    
    
    
}


@end
