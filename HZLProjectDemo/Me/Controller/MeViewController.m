//
//  MeViewController.m
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 9/21/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "MeViewController.h"
#import "BottomView.h"
#import "LoginView.h"
#import "LoginedModel.h"
#import "LoginedView.h"
@interface MeViewController ()

@property (nonatomic, strong) UIView *settingView;


@end

@implementation MeViewController
{
    
    UIImageView *_backImageView;
    UIButton *_loginBtn;
    UIButton *_settingBtn;
    UILabel *_descLabel;
    UIButton *_settingCancelBtn;
    UIView *_settingBkView1;
    LoginView *_loginView;
    LoginedModel *_model;
    
}
- (UIView *)settingView
{
    if (!_settingView) {
        
        _settingView = [[UIView alloc] init];
        
    }
    return _settingView;
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
    _loginBtn.layer.cornerRadius = 50;
    [_loginBtn setTitle:@"登录MONO" forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    _loginBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _loginBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:25];
    _loginBtn.tintColor = [UIColor whiteColor];
    [self.view addSubview:_loginBtn];
    
    _descLabel = [[UILabel alloc] init];
    _descLabel.font = [UIFont systemFontOfSize:20];
    [_descLabel setTextColor:[UIColor yellowColor]];
    _descLabel.textAlignment = NSTextAlignmentCenter;
    _descLabel.text = @"这个世界疯狂，没人性，腐败。您却一直清醒，温柔，一尘不染。";
    _descLabel.numberOfLines = 0;
    [self.view addSubview:_descLabel];
    
    _settingBtn = [[UIButton alloc] init];
    [_settingBtn setImage:[UIImage imageNamed:@"icon-setting"] forState:UIControlStateNormal];
    [_settingBtn addTarget:self action:@selector(showSettingView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_settingBtn];
    
}
- (void)showSettingView
{
    
    self.settingView.backgroundColor = [UIColor colorWithRed:0.60 green:0.60 blue:0.60 alpha:1.00];
    
    self.settingView.frame = CGRectMake(0, ScreenH, ScreenW, ScreenH);
    
    [self.view addSubview:self.settingView];
    
    [self layoutSettingView];
    
    [UIView animateWithDuration:0.5 animations:^{
       
        self.settingView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
        
    }];
    
}
- (void)layoutSettingView
{
      __weak typeof(self) weakSelf = self;
    _settingCancelBtn = [[UIButton alloc] init];
    
    [_settingCancelBtn setImage:[UIImage imageNamed:@"cpprofile_btn_close"] forState:UIControlStateNormal];
    
    [self.settingView addSubview:_settingCancelBtn];
    
    [_settingCancelBtn addTarget:self action:@selector(closeSettingView) forControlEvents:UIControlEventTouchUpInside];
    
    _settingBkView1 = [[UIView alloc] init];
    
    _settingBkView1.backgroundColor = [UIColor blackColor];
    
    [self.settingView addSubview:_settingBkView1];
    
    UIButton * leftBtn = [[UIButton alloc] init];
    
    [leftBtn setImage:[UIImage imageNamed:@"icon-cp-msg"] forState:UIControlStateNormal];
    
    [_settingBkView1 addSubview:leftBtn];
    
    UILabel *topLabel = [[UILabel alloc] init];
    
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:@"你还没有登录"];
    
    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(4, 2)];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 4)];
    topLabel.attributedText = attributeStr;
    
    [topLabel sizeToFit];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(login)];
    
    [topLabel addGestureRecognizer:tapGesture];
    topLabel.userInteractionEnabled = YES;
    [_settingBkView1 addSubview:topLabel];
    
    BottomView *bottomView = [BottomView shareView];
    bottomView.backgroundColor = [UIColor colorWithRed:0.18 green:0.19 blue:0.21 alpha:1.00];
    
   
    
    
    
    [self.settingView addSubview:bottomView];
    
    UITapGestureRecognizer *cleanTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cleanCaches)];
    
    [bottomView.cleanLabel addGestureRecognizer:cleanTap];
    bottomView.cleanLabel.userInteractionEnabled = YES;
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_settingBkView1.mas_top).offset(5);
        make.left.equalTo(_settingBkView1.mas_left).offset(5);
        make.width.equalTo(@45);
        make.height.equalTo(@45);
    }];
    
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.mas_equalTo(leftBtn.mas_centerY);
        
        make.left.equalTo(leftBtn.mas_right).offset(5);
        
    }];
    
    [_settingBkView1 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(weakSelf.settingView.mas_left).offset(25);
        make.right.mas_equalTo(weakSelf.settingView.mas_right).offset(-25);
        make.height.equalTo(@60);
        make.top.equalTo(weakSelf.settingView.mas_top).offset(124);
        
    }];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(_settingBkView1.centerX);
        make.width.equalTo(_settingBkView1.mas_width);
        make.top.mas_equalTo(_settingBkView1.mas_bottom);
        
        
    }];
    
    [_settingCancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(weakSelf.settingView.mas_centerX);
        make.top.mas_equalTo(bottomView.mas_bottom).offset(20);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.bottom.mas_equalTo(weakSelf.settingView.mas_bottom).offset(-74);
        
    }];
}
- (void)cleanCaches
{
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    
    NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];
    
    NSLog ( @"cachpath = %@" , cachPath);
    
    CGFloat cachesSize = 0;
    
    for ( NSString * p in files) {
        
        NSError * error = nil ;
        
        NSString * path = [cachPath stringByAppendingPathComponent :p];
        
        
        if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
            
            cachesSize += [[[NSFileManager defaultManager] attributesOfItemAtPath :path error : nil ] fileSize ];
            cachesSize /= (1024.0 * 1024.0);
            
            [[ NSFileManager defaultManager ] removeItemAtPath :path error :&error];
            
        }
        
    }
    [KVNProgress showSuccessWithStatus:[NSString stringWithFormat:@"清除了%.2lfM缓存",cachesSize]];
}
- (void)login
{
    _loginView = [LoginView shareView];
    _loginView.frame = self.view.bounds;
    [self.view addSubview:_loginView];
    [_loginView.cancelLoginBtn addTarget:self action:@selector(cancelLoginView) forControlEvents:UIControlEventTouchUpInside];
     UITapGestureRecognizer *sinaTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sinaLogin)];
    [_loginView.sinaLabel addGestureRecognizer:sinaTap];
    
    
}
- (void)sinaLogin
{
    [AVOSCloudSNS setupPlatform:AVOSCloudSNSSinaWeibo withAppKey:@"2381053662" andAppSecret:@"a3e7b443bc09968f3a65cf6d2315ab48" andRedirectURI:@"www.weibo.com"];
    [AVOSCloudSNS loginWithCallback:^(id object, NSError *error) {
        
        if (error) {
            
            [KVNProgress showErrorWithStatus:@"授权失败"];
            
        }else
        {
            _model = [[LoginedModel alloc] init];
            _model.userName = object[@"username"];
           _model.avatarUrl = object[@"avatar"];
            _model.desc = object[@"description"];
            
            [self createLoginedView];
            
        }
        
    }toPlatform:AVOSCloudSNSSinaWeibo];
}
- (void)createLoginedView
{
    
    LoginedView *view = [LoginedView shareView];
    view.model = _model;
    view.frame = self.view.bounds;
    [self.view addSubview:view];
    [self.navigationController setNavigationBarHidden:YES];
    
}
- (void)cancelLoginView
{
    
    [_loginView removeFromSuperview];
    
}
- (void)closeSettingView
{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        
        self.settingView.frame = CGRectMake(0, ScreenH, ScreenW, ScreenH);
        
    }];
}
- (void)makeConstrains
{
    
    __weak typeof(self) weakSelf = self;
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.edges.equalTo(weakSelf.view);
        
        
    }];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.centerY.mas_equalTo(weakSelf.view.mas_centerY).offset(50);
        make.width.equalTo(@100);
        make.height.equalTo(@100);
        
    }];
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.top.mas_equalTo(_loginBtn.mas_bottom);
        make.left.mas_equalTo(weakSelf.view.mas_left).offset(20);
        make.right.mas_equalTo(weakSelf.view.mas_right).offset(-20);
    }];
    [_settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(weakSelf.view.mas_right).offset(-20);
        make.top.mas_equalTo(weakSelf.view.mas_top).offset(84);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
        
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
