//
//  MeViewController.h
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 9/21/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeViewController : UIViewController
@property (nonatomic, copy) void(^refreshUserInfo)();
@end
