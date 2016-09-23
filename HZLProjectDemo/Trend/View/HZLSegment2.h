//
//  HZLSegment2.h
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 9/22/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HZLFrame2.h"

@interface HZLSegment2 : UIView

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, assign) NSInteger selectedIndex;



@property (nonatomic, assign) CGFloat currentXOffset;
//根据文字长度自适应宽度
- (instancetype)initWithFlexibleWidthFrame:(HZLFrame)frame items:(NSArray *)items withWidth:(CGFloat)width;

- (instancetype)initWithFlexibleWidthFrame:(HZLFrame)frame items:(NSArray *)items;
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items;

- (void)addTarget:(id)target action:(SEL)action;




@end
