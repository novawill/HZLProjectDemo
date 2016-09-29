//
//  headerView.m
//  MOMO
//
//  Created by 黄梓伦 on 6/16/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "headerView.h"

@implementation headerView

+ (instancetype)iniWith
{
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
    
    
}
@end
