//
//  HZLScrollView.h
//  TestScrollTitileBar
//
//  Created by 黄梓伦 on 9/23/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZLScrollView : UIScrollView

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, assign) CGFloat fontSize;

@property (nonatomic, strong) UIColor *selectedColor;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, assign) NSInteger selectedIndex2;

@property (nonatomic, assign) NSInteger selectedIndex3;

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items;

- (void)addTarget:(id)target action:(SEL)action;

@end
