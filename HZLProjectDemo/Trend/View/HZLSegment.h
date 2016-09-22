//
//  HZLSegment.h
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 9/22/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  @author 黄梓伦, 16-09-22 17:09:24
 *
 *  直接导入"HZLFrame.h" 会出现CGHZLFrameMake符号重定义的链接器错误，所以将CGHZLFrameMake函数声明和定义放在实现函数的文件中或者将实现放在.m文件中
 */
#if 0
#import "HZLFrame.h"
#endif
typedef struct ZLFrame{
    
    CGFloat originX;
    CGFloat originY;
    CGFloat SizeHeight;
    
}HZLFrame;
HZLFrame CGHZLFrameMake(CGFloat x, CGFloat y, CGFloat height);


@interface HZLSegment : UIView

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, assign) NSInteger selectedIndex;

//根据文字长度自适应宽度
- (instancetype)initWithFlexibleWidthFrame:(HZLFrame)frame items:(NSArray *)items;

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items;

- (void)addTarget:(id)target withAction:(SEL)action;

@end
