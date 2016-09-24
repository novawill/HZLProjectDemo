//
//  HZLSegment.h
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 9/22/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZLFrame2.h"

@interface HZLSegment : UIView

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, assign) NSInteger selectedIndex2;

@property (nonatomic, assign) CGFloat fontSize;

@property (nonatomic, strong) UIColor *selectedColor;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, assign) CGFloat currentXOffset;

@property (nonatomic, assign) NSInteger selectedIndex3;
//根据文字长度自适应宽度
- (instancetype)initWithFlexibleWidthFrame:(HZLFrame)frame items:(NSArray *)items;

- (instancetype)initWithFlexibleWidthFrame:(HZLFrame)frame items:(NSArray *)items fontSize:(CGFloat)fontSize;

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items;

- (void)addTarget:(id)target withAction:(SEL)action;

@end
