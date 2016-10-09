//
//  PicTitleBtn.m
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 10/6/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "PicTitleBtn.h"

@implementation PicTitleBtn

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    
    
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height * 2 / 3.0f);
    
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    
    
    return CGRectMake(0, contentRect.size.height * 2 / 3.0f, contentRect.size.width, contentRect.size.height / 3.0f);
    
    
}
@end
