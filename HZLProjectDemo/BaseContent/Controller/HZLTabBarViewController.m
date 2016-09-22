//
//  HZLTabBarViewController.m
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 9/21/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "HZLTabBarViewController.h"
#import  "MeViewController.h"
#import "RemindViewController.h"
#import "DiscoverViewController.h"
#import "TrendViewController.h"
@interface HZLTabBarViewController ()

@end

@implementation HZLTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatViewControllers];
    
}

- (void)creatViewControllers
{
    
    [self setUpChildVC:[[TrendViewController alloc] init] name:@"动态" image:@"icon_home_normal_26" selectedImage:@"icon_home_selected_26"];
    [self setUpChildVC:[[DiscoverViewController alloc] init] name:@"发现" image:@"icon_weizhan1" selectedImage:@"icon_weizhan_selected1"];
    [self setUpChildVC:[[RemindViewController alloc] init] name:@"提醒" image:@"icon_ranked_normal_26" selectedImage:@"icon_ranked_selected_26"];
    [self setUpChildVC:[[MeViewController alloc] init] name:@"我" image:@"icon_user_26" selectedImage:@"icon_user_selected_26"];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
    
    
    
    
    
    
}
- (void)setUpChildVC:(UIViewController *)vc name:(NSString *)name image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    
    
    vc.tabBarItem.title = name;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.title = name;
    
    [self addChildViewController:nav];
    
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
