//
//  CustomProgressView+BaseConfiguration.h
//  MOMO
//
//  Created by 黄梓伦 on 6/11/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "CustomProgressView.h"

@interface CustomProgressView (BaseConfiguration)


// start angle in clockwise status
+ (CGFloat)startAngle;


+ (CGFloat)endAngle;

+ (CGFloat)lineWidth;


+ (UIColor *)startColor;


+ (UIColor *)centerColor;


+ (UIColor *)endColor;





/**
 *  @author 黄梓伦, 16-06-11 11:06:41
 *
 *  Determines whether it is clockwise or not
 *
 *  @return YES for clockwise,vice versa
 */
+ (ZLProgressViewClockWiseType)clockWiseType;
@end
