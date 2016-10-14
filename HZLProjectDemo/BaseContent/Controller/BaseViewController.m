//
//  BaseViewController.m
//  MOMO
//
//  Created by 黄梓伦 on 5/27/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "BaseViewController.h"
#import <Social/Social.h>
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customNavigationItem];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
}


#pragma mark - Show navigationItem which can perform RESideMenu methods
- (void)RESideNavigationItemWithLeftTile:(NSString *)leftTile RightTitle:(NSString *)rightTitle isShowRight:(BOOL)show
{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:leftTile
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(presentLeftMenuViewController:)];
    //Whether to show the right button
    if (show) {
        
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:rightTitle
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self
                                                                                action:@selector(presentRightMenuViewController:)];
    }
}

#pragma mark - NavigationItem which can perform custom methods
- (void)customNavigationItemMethodsTitle:(NSString *)title target:(id)target selector:(SEL)action isLeft:(BOOL)isleft
{
    if (isleft) {
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                                                style:UIBarButtonItemStylePlain
                                                                                target:target action:action];
    }else
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:target action:action];
    }
}

#pragma mark - NavigationItem which can perform custom methods with Image

- (void)customNavigationItemMethodsImage:(UIImage *)image target:(id)target selector:(SEL)action isLeft:(BOOL)isleft
{
    
    if (isleft) {
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:target
                                                                                action:action];
                                                 
    }else
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:target
                                                                                 action:action];
    }
    
}

#pragma mark - NavigationItem which can perform RESideMenu methods with Image

- (void)RESideNavigationItemWithLeftImage:(UIImage *)leftImage RightImage:(UIImage *)rightImage isShowRight:(BOOL)show
{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftImage
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(presentLeftMenuViewController:)];
                                             
    //Whether to show the right button
    if (show) {
        
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:rightImage
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self
                                                                                 action:@selector(presentRightMenuViewController:)];
    }

}

#pragma mark - addBackButton
- (void)addBackButtonWithImage:(UIImage *)image
{
    
    [self customNavigationItemMethodsImage:image target:self selector:@selector(backAction) isLeft:YES];
    
    
}
- (void)backAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark - customNavigationItem
//Overrided By childViewController
- (void)customNavigationItem{
    
    
    
    
    
}
#pragma mark - addNavigationTitle
- (void)addNavigationTitle:(NSString *)title andColor:(UIColor *)color
{
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    titleLabel.textColor = color;
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
   //Sets Navigation Title
    self.navigationItem.titleView = titleLabel;
}



#pragma mark - Setting httManager
- (AFHTTPSessionManager *)httpManager
{
    
    if (!_httpManager) {
        
        
        _httpManager = [AFHTTPSessionManager manager];
        
        _httpManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        _httpManager.responseSerializer.acceptableContentTypes = [_httpManager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
       
        _httpManager.requestSerializer = [AFJSONRequestSerializer new];
        
        //Add http-authorization to header
        [_httpManager.requestSerializer setValue:@"e573a54a012811e6beb85254001b74f1" forHTTPHeaderField:@"HTTP-AUTHORIZATION"];
        
        
    }
    
    return _httpManager;
    
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
