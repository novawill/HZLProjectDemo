//
//  BaseViewController.h
//  MOMO
//
//  Created by 黄梓伦 on 5/27/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

//Show navigationItem which can perform RESideMenu methods
- (void)RESideNavigationItemWithLeftTile:(NSString *)leftTile
                              RightTitle:(NSString *)rightTitle
                             isShowRight:(BOOL)show;

//NavigationItem which can perform custom methods
- (void)customNavigationItemMethodsTitle:(NSString *)title
                                  target:(id)target
                                selector:(SEL)action
                                  isLeft:(BOOL)isleft;

//NavigationItem which can perform custom methods with Image
- (void)customNavigationItemMethodsImage:(UIImage *)image
                                  target:(id)target
                                selector:(SEL)action
                                  isLeft:(BOOL)isleft;

//NavigationItem which can perform RESideMenu methods with Image
- (void)RESideNavigationItemWithLeftImage:(UIImage *)leftImage
                               RightImage:(UIImage *)rightImage
                              isShowRight:(BOOL)show;

//Custom NavigationItem
- (void)customNavigationItem;

//addNavigationTitle
- (void)addNavigationTitle:(NSString *)title andColor:(UIColor *)color;

//addBackButton
- (void)addBackButtonWithImage:(UIImage *)image;
- (void)backAction;

//Request Manager
@property (nonatomic, strong)  AFHTTPSessionManager *httpManager;
@end
