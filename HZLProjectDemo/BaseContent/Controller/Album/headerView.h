//
//  headerView.h
//  MOMO
//
//  Created by 黄梓伦 on 6/16/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface headerView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

+ (instancetype)iniWith;

@end
