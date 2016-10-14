//
//  MeViewController.m
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 9/21/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "MeViewController.h"

@interface MeViewController ()

@end

@implementation MeViewController
{
    
    UIImageView *_backImageView;
    UIButton *_loginBtn;
    UIButton *_settingBtn;
    UILabel *_descLabel;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    [self makeConstrains];
    
}
- (void)createUI
{
    
    
    _backImageView = [[UIImageView alloc] init];
    _backImageView.image = [UIImage imageNamed:@"IMG_8914.jpg"];
    [self.view addSubview:_backImageView];
    
    _loginBtn = [[UIButton alloc] init];
    _loginBtn.backgroundColor = [UIColor colorWithRed:0.14 green:0.64 blue:0.68 alpha:1.00];
    _loginBtn.layer.masksToBounds = YES;
    //_loginBtn.layer.cornerRadius =

}
- (void)makeConstrains
{
    
    __weak typeof(self) weakSelf = self;
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.edges.equalTo(weakSelf.view);
        
        
    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
