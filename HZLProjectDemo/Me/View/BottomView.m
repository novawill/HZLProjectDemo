//
//  BottomView.m
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 10/16/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "BottomView.h"

@implementation BottomView

+(instancetype)shareView
{
    
    BottomView * view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    
    return view;
}

@end
