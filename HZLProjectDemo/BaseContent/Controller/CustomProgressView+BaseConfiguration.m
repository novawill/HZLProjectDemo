//
//  CustomProgressView+BaseConfiguration.m
//  MOMO
//
//  Created by 黄梓伦 on 6/11/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "CustomProgressView+BaseConfiguration.h"

#define DEGREES_TO_RADOANS(x) (M_PI * (x) / 180.0)  //Angle to radian

@implementation CustomProgressView (BaseConfiguration)
+ (UIColor *)startColor {
    
    return [UIColor blueColor];
}

+ (UIColor *)centerColor {
    
    return [UIColor redColor];
}

+ (UIColor *)endColor {
    
    return [UIColor whiteColor];
}





+ (CGFloat)startAngle
{
    
    return DEGREES_TO_RADOANS(180);
}

+ (CGFloat)endAngle
{
    return DEGREES_TO_RADOANS(0);
}


+ (CGFloat)lineWidth {
    
    return 20;
}


+(ZLProgressViewClockWiseType)clockWiseType
{
    return YES;
}

@end
