//
//  CustomProgressView.h
//  MOMO
//
//  Created by 黄梓伦 on 6/11/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, ZLProgressViewClockWiseType) {
    ZLPorgressViewClockWiseYes,
    ZLPorgressClockWiseNo
};

@interface CustomProgressView : UIView

@property (nonatomic, assign) CGFloat percentage;

@end
