//
//  HZLSegment2.m
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 9/22/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "HZLSegment2.h"
#import "HZLFrame2.h"
#define ViewTag 100
#define DefaultColor [UIColor colorWithRed:0.4 green:0.3 blue:0.7 alpha:1]
#define ButtonY 22
#define ButtonTag 100
#define FixMargin 20

@interface HZLSegment2()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *viewLengthArray;

@property (nonatomic, strong) NSMutableArray *btnArray;

@property (nonatomic, strong) id target;

@property (nonatomic, assign) SEL action;

@property (nonatomic, assign) CGFloat fixWidth;

@end

@implementation HZLSegment2{
    
    UIView *_slider;
    CGFloat _totalWidth;
    CGFloat _buttonMargin;
    NSInteger _selectedIndex;
    BOOL _isFlexibleWidth;
    BOOL _isFirstLayoutSubView;
    
}

- (void)addTarget:(id)target action:(SEL)action
{
    
    _target = target;
    _action = action;
    
}
- (NSMutableArray *)viewLengthArray
{
    if (!_viewLengthArray) {
        
        _viewLengthArray = [[NSMutableArray alloc] init];
    }
    return _viewLengthArray;
    
}
- (instancetype)initWithFlexibleWidthFrame:(HZLFrame)frame items:(NSArray *)items withWidth:(CGFloat)width
{
    
    _fixWidth = width;
    
    return [self initWithFlexibleWidthFrame:frame items:items];
    
    
}

- (instancetype)initWithFlexibleWidthFrame:(HZLFrame)frame items:(NSArray *)items
{
 
    CGRect newFrame = CGRectMake(frame.originX, frame.originY, 20, frame.SizeHeight);
    
    if (self = [super initWithFrame:newFrame]) {
        
        
        _items = items;
        _isFlexibleWidth = YES;
        /**
         *  @author 黄梓伦, 16-09-22 17:09:10
         *
         *  根据items的各个按钮标题长度自适应HZLSegment2的宽度
         */
         [self addUpViewTotalLength];
         [self setNewFrame];
        _isFirstLayoutSubView = YES;
        
    }
   
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items
{
    if (self = [super initWithFrame:frame]) {
        
        
        _items = items;
        _isFlexibleWidth = NO;
        _isFirstLayoutSubView = YES;
              
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    
    NSException *exception = [NSException exceptionWithName:@"HZLSegment2不能使用initWithFrame方法" reason:@"必须初始化按钮标题" userInfo:nil];
    
    @throw exception;

}

- (void)layoutSubviews
{
    if (_isFirstLayoutSubView) {
        if (!_isFlexibleWidth) {
            
            [self addUpViewTotalLength];
            
        }
        [self creatView];
    }
}

- (void)setNewFrame
{
    
    
    CGFloat newWidth = _totalWidth;
    CGRect rect = CGRectMake(self.frame.origin.x, self.frame.origin.y, newWidth, self.frame.size.height);
    
    self.frame = rect;
    
}
- (void)creatView
{
    NSMutableArray *originXArray = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0;i < _items.count;i++) {
#if 0
        UIView *view = (UIView *)_items[i];
        
        view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        
        view.tag = ViewTag + i;
        
        if (i == 0) {
            
            [view setFrame:CGRectMake(0, 0, [_viewLengthArray[i] doubleValue], self.bounds.size.height )];
            view.center = CGPointMake(view.center.x, self.center.y);
            [originXArray addObject:@0];
        }else
        {
            CGFloat originX = [originXArray[i -1] doubleValue] + [_viewLengthArray[i-1] doubleValue];
            [originXArray addObject:[NSNumber numberWithDouble:originX]];
            [view setFrame:CGRectMake(originX, 0, [_viewLengthArray[i] doubleValue], self.bounds.size.height)];
            view.center = CGPointMake(view.center.x, self.center.y);
            
        }
#elif 1
        
        UIView *view = (UIView *)_items[i];
        
        view.tag = ViewTag + i;
        
        if (i == 0) {
            
            [view setFrame:CGRectMake(0, 0, _fixWidth, self.bounds.size.height )];
            view.center = CGPointMake(view.center.x, self.center.y);
            [originXArray addObject:@0];
        }else
        {
            CGFloat originX = [originXArray[i -1] doubleValue] +_fixWidth;
            [originXArray addObject:[NSNumber numberWithDouble:originX]];
            [view setFrame:CGRectMake(originX, 0, _fixWidth, self.bounds.size.height)];
            view.center = CGPointMake(view.center.x, self.center.y);
            
        }
#endif

        [self addSubview:view];
    }
}
- (void)addUpViewTotalLength
{
    _totalWidth = 0;
    [self.viewLengthArray removeAllObjects];
    for (NSUInteger i = 0;i < _items.count;i++) {
#if 0
        CGFloat viewLength ;
        UIView *view = (UIView *)_items[i];
        viewLength = view.frame.size.width;
        _totalWidth += viewLength;
        [self.viewLengthArray addObject:[NSNumber numberWithDouble:viewLength]];
#elif 1
      
        _totalWidth += _fixWidth;
        
#endif
    }
}



- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    
    _isFirstLayoutSubView = NO;
    [self layoutSubviews];
    if (selectedIndex > _items.count -1 ) {
        
        NSException *exception = [[NSException alloc] initWithName:@"数组越界" reason:@"selectedIndex大于items数组个数" userInfo:nil];
        @throw exception;
    }
    UIView *changedView = (UIView *)[self viewWithTag:ViewTag + selectedIndex];
    _selectedIndex = selectedIndex;
    self.currentXOffset = changedView.center.x;
    if ([self.target respondsToSelector:self.action]) {
    
        [self.target performSelector:self.action withObject:self];
    }
    
}







@end
