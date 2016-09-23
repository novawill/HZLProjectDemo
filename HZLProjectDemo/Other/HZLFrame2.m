//
//  HZLFrame2.m
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 9/23/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "HZLFrame2.h"
HZLFrame CGHZLFrameMake(CGFloat x, CGFloat y, CGFloat height)
{
    HZLFrame rect;
    rect.originX = x;
    rect.originY = y;
    rect.SizeHeight = height;
    return rect;
}
@implementation HZLFrame2

@end
