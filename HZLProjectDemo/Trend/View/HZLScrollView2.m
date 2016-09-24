//
//  HZLScrollView2.m
//  TestScrollTitileBar
//
//  Created by 黄梓伦 on 9/23/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "HZLScrollView2.h"
#import "HZLSegment2.h"
@interface HZLScrollView2()

@property (nonatomic, strong) HZLSegment2 *seg;

@property (nonatomic, strong) id target;

@property (nonatomic, assign) SEL action;

@end
@implementation HZLScrollView2
{
    BOOL isFirstLayoutSubview;
   
}
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items
{
    
    if (self = [super initWithFrame:frame]) {
        
        _items = items;
        isFirstLayoutSubview = YES;
        self.autoresizesSubviews = NO;
    }
    
    return self;
}

- (void)layoutSubviews
{
    if (isFirstLayoutSubview) {
        
        [self addHZLSegmenet];
    }
    
}


- (void)updateContentOffSet
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
        
        
    }
}
- (void)addHZLSegmenet
{
    
    
    _seg  = [[HZLSegment2 alloc] initWithFlexibleWidthFrame:CGHZLFrameMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.height) items:_items withWidth:self.bounds.size.width];
    [_seg addTarget:self action:@selector(newPage)];
    _seg.backgroundColor = [UIColor clearColor];
    _seg.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.autoresizesSubviews = YES;
    [self addSubview:_seg];
    self.contentSize = CGSizeMake(CGRectGetWidth(_seg.frame), -5);
    self.bounces = NO;
    self.pagingEnabled = YES;
    self.showsVerticalScrollIndicator = FALSE;
    self.showsHorizontalScrollIndicator = FALSE;
    isFirstLayoutSubview = NO;
    
}


- (void)setTitleColor:(UIColor *)titleColor
{
    [self layoutSubviews];
    _titleColor = titleColor;
  
    
    
}

- (void)setSelectedColor:(UIColor *)selectedColor
{
    [self layoutSubviews];
    _selectedColor = selectedColor;
       
}

- (void)addTarget:(id)target action:(SEL)action
{
    
    _target = target;
    _action = action;
   
}
- (void)onclicked
{
    if ([self.target respondsToSelector:self.action]) {
        
        
        [self.target performSelector:_action withObject:self];
        
    }
}
- (void)setSelectedIndex:(NSInteger)selectedIndex
{

    [self layoutSubviews];
    _selectedIndex = selectedIndex;
    _seg.selectedIndex = selectedIndex;
    if (selectedIndex > _items.count - 1) {
        
        NSException *exception = [[NSException alloc] initWithName:@"数组越界" reason:@"selectedIndex大于items数组个数" userInfo:nil];
        @throw exception;
    }
    
}

- (void)newPage
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
