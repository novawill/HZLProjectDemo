//
//  HZLScrollView.m
//  TestScrollTitileBar
//
//  Created by 黄梓伦 on 9/23/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "HZLScrollView.h"
#import "HZLSegment.h"
@interface HZLScrollView()

@property (nonatomic, strong) HZLSegment *seg;

@property (nonatomic, strong) id target;

@property (nonatomic, assign) SEL action;

@end
@implementation HZLScrollView
{
    BOOL isFirstLayoutSubview;
   
}
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items
{
    
    if (self = [super initWithFrame:frame]) {
        
        _items = items;
        isFirstLayoutSubview = YES;
    }
    
    return self;
}

- (void)layoutSubviews
{
    if (isFirstLayoutSubview) {
        
        [self addHZLSegmenet];
    }
}
- (void)addHZLSegmenet
{
    
    
    _seg = [[HZLSegment alloc] initWithFlexibleWidthFrame:CGHZLFrameMake(self.bounds.origin.x, -20, CGRectGetHeight(self.bounds)) items:_items];
    [_seg addTarget:self withAction:@selector(onclicked)];
    [self addSubview:_seg];
    self.contentSize = CGSizeMake(CGRectGetWidth(_seg.frame), -5);
    self.bounces = NO;
    self.showsVerticalScrollIndicator = FALSE;
    self.showsHorizontalScrollIndicator = FALSE;
    isFirstLayoutSubview = NO;
    
}


- (void)setFontSize:(CGFloat)fontSize
{
    [self layoutSubviews];
    _fontSize = fontSize;
    _seg.fontSize = fontSize;
    self.contentSize = CGSizeMake(CGRectGetWidth(_seg.frame), -5);
    
}
- (void)setTitleColor:(UIColor *)titleColor
{
    [self layoutSubviews];
    _titleColor = titleColor;
    _seg.titleColor = titleColor;
    
    
}
- (void)setSelectedColor:(UIColor *)selectedColor
{
    [self layoutSubviews];
    _selectedColor = selectedColor;
    _seg.selectedColor = selectedColor;
    
}

- (void)addTarget:(id)target action:(SEL)action
{
    
    _target = target;
    _action = action;
   
}
- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    
    
    [self layoutSubviews];
    if (selectedIndex > _items.count - 1) {
        
        NSException *exception = [[NSException alloc] initWithName:@"数组越界" reason:@"selectedIndex大于items数组个数" userInfo:nil];
        @throw exception;
    }
    _selectedIndex = selectedIndex;
    _seg.selectedIndex = selectedIndex;
    
}
- (void)setSelectedIndex2:(NSInteger)selectedIndex2
{
    
    [self layoutSubviews];
    if (selectedIndex2 > _items.count - 1) {
        
        NSException *exception = [[NSException alloc] initWithName:@"数组越界" reason:@"selectedIndex大于items数组个数" userInfo:nil];
        @throw exception;
    }
    _selectedIndex = selectedIndex2;
    _seg.selectedIndex2 = selectedIndex2;
    [self updateCenter];
    
    
}
- (void)updateCenter
{
    _selectedIndex2 = _seg.selectedIndex2;
    
    CGFloat onClickedXToRight = self.contentSize.width - _seg.currentXOffset;
    
    
    CGFloat halfWidth = self.frame.size.width / 2;
    
    if ((_seg.currentXOffset >= halfWidth) && (onClickedXToRight >= halfWidth)) {
        
        
        CGFloat onClickedToLeft = _seg.currentXOffset - self.contentOffset.x;
        CGFloat neededOffset = halfWidth - onClickedToLeft;
        CGFloat currentOffsetY = self.contentOffset.y;
        CGFloat currentOffsetX = self.contentOffset.x;
        currentOffsetX -= neededOffset;
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.5 animations:^{
            
            [weakSelf setContentOffset:CGPointMake(currentOffsetX, currentOffsetY)];
        }];
        
        
    }else if (_seg.currentXOffset < halfWidth){
        
        
        __weak typeof(self) weakSelf = self;
        CGFloat currentOffsetY = self.contentOffset.y;
        [UIView animateWithDuration:0.5 animations:^{
            
            [weakSelf setContentOffset:CGPointMake(0, currentOffsetY)];
        }];
    }else
    {
        
        __weak typeof(self) weakSelf = self;
        CGFloat currentOffsetX = self.contentOffset.x;
        CGFloat currentOffsetY = self.contentOffset.y;
        currentOffsetX = self.contentSize.width - self.frame.size.width;
        [UIView animateWithDuration:0.5 animations:^{
            
            [weakSelf setContentOffset:CGPointMake(currentOffsetX, currentOffsetY)];
        }];
        
        
    }
}
- (void)onclicked
{
    _selectedIndex = _seg.selectedIndex;
    
    CGFloat onClickedXToRight = self.contentSize.width - _seg.currentXOffset;
  
    
    CGFloat halfWidth = self.frame.size.width / 2;
    
    if ((_seg.currentXOffset >= halfWidth) && (onClickedXToRight >= halfWidth)) {
        
        
        CGFloat onClickedToLeft = _seg.currentXOffset - self.contentOffset.x;
        CGFloat neededOffset = halfWidth - onClickedToLeft;
        CGFloat currentOffsetY = self.contentOffset.y;
        CGFloat currentOffsetX = self.contentOffset.x;
        currentOffsetX -= neededOffset;
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.5 animations:^{
            
            [weakSelf setContentOffset:CGPointMake(currentOffsetX, currentOffsetY)];
        }];
        
        
    }else if (_seg.currentXOffset < halfWidth){
        
        
        __weak typeof(self) weakSelf = self;
        CGFloat currentOffsetY = self.contentOffset.y;
        [UIView animateWithDuration:0.5 animations:^{
            
            [weakSelf setContentOffset:CGPointMake(0, currentOffsetY)];
        }];
    }else
    {
        
        __weak typeof(self) weakSelf = self;
        CGFloat currentOffsetX = self.contentOffset.x;
        CGFloat currentOffsetY = self.contentOffset.y;
        currentOffsetX = self.contentSize.width - self.frame.size.width;
        [UIView animateWithDuration:0.5 animations:^{
            
            [weakSelf setContentOffset:CGPointMake(currentOffsetX, currentOffsetY)];
        }];
        
        
    }
 
    if ([self.target respondsToSelector:self.action]) {
        
        
        [self.target performSelector:_action withObject:self];
        
    }
}

@end
