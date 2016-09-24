//
//  HZLSegment.m
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 9/22/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "HZLSegment.h"

#define ButtonTag 100
#define DefaultColor [UIColor colorWithRed:0.4 green:0.3 blue:0.7 alpha:1]
#define ButtonTag 100
#define FixMargin 20


@interface HZLSegment()

@property (nonatomic, strong) NSMutableArray *titleLengthArray;

@property (nonatomic, strong) NSMutableArray *btnArray;

@property (nonatomic, strong) id target;

@property (nonatomic, assign) SEL action;





@end

@implementation HZLSegment{
    
    UIView *_slider;
    CGFloat _totalWidth;
    CGFloat _buttonMargin;
    NSInteger _selectedIndex;
    CGFloat _buttonY;
    BOOL _isFlexibleWidth;
    BOOL _isFirstLayoutSubView;
    
}

- (NSMutableArray *)btnArray
{
    if (!_btnArray) {
        
        _btnArray = [[NSMutableArray alloc] init];
    }
    return _btnArray;
}

- (NSMutableArray *)titleLengthArray
{
    if (!_titleLengthArray) {
        
        _titleLengthArray = [[NSMutableArray alloc] init];
    }
    return _titleLengthArray;
    
}

- (instancetype)initWithFlexibleWidthFrame:(HZLFrame)frame items:(NSArray *)items fontSize:(CGFloat)fontSize
{
    CGRect newFrame = CGRectMake(frame.originX, frame.originY, 20, frame.SizeHeight);
    
    if (self = [super initWithFrame:newFrame]) {
        
        
        _items = items;
        _isFlexibleWidth = YES;
        _fontSize = fontSize;
        _selectedColor = DefaultColor;
        _titleColor = [UIColor grayColor];
        _buttonY = 22;
        /**
         *  @author 黄梓伦, 16-09-22 17:09:10
         *
         *  根据items的各个按钮标题长度自适应HZLSegment的宽度
         */
        [self addUpTitleLength];
        [self setNewFrame];
        _isFirstLayoutSubView = YES;
        
    }
    
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items
{
    if (self = [super initWithFrame:frame]) {
        
        
        _items = items;
        _fontSize = 15;
        _buttonY = 22;
        _selectedColor = DefaultColor;
        _titleColor = [UIColor grayColor];
        _isFlexibleWidth = NO;
        _isFirstLayoutSubView = YES;
    }
    return self;
}
- (instancetype)initWithFlexibleWidthFrame:(HZLFrame)frame items:(NSArray *)items
{
    
    return [self initWithFlexibleWidthFrame:frame items:items fontSize:15];;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    
    NSException *exception = [NSException exceptionWithName:@"HZLSegment不能使用initWithFrame方法" reason:@"必须初始化按钮标题" userInfo:nil];
    
    @throw exception;
    
}

- (void)layoutSubviews
{
    if (_isFirstLayoutSubView) {
        if (!_isFlexibleWidth) {
            
            [self addUpTitleLength];
            [self calculateMargin];
        }
        
        
        [self creatButton];
        [self creatSlider];
        
    }
}

- (void)setNewFrame
{
    _buttonMargin = FixMargin;
    CGFloat newWidth = FixMargin * (_items.count +1) + _totalWidth;
    CGRect rect = CGRectMake(self.frame.origin.x, self.frame.origin.y, newWidth, self.frame.size.height);
    self.frame = rect;
}


- (void)creatSlider
{
    UIButton *btn = (UIButton *)[self viewWithTag:ButtonTag + _selectedIndex];
    _slider = [[UIView alloc] initWithFrame:CGRectMake(btn.frame.origin.x, self.bounds.size.height - 4,[_titleLengthArray[_selectedIndex] floatValue], 4)];
    
    _slider.backgroundColor =  _selectedColor;
    
    [self addSubview:_slider];
}
- (void)creatButton
{
    NSMutableArray *originXArray = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0;i < _items.count;i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setTitle:_items[i] forState:UIControlStateNormal];
        
        [btn setTitleColor:_titleColor forState:UIControlStateNormal];
        
        [btn setTitleColor: _selectedColor forState:UIControlStateSelected];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:_fontSize];
        
        btn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        
        btn.tag = ButtonTag + i;
        
        [btn addTarget:self action:@selector(onClickedButton:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            
            [btn setFrame:CGRectMake(FixMargin, _buttonY, [_titleLengthArray[i] doubleValue], self.bounds.size.height - _buttonY)];
            btn.selected = YES;
            btn.userInteractionEnabled = NO;
            [originXArray addObject:[NSNumber numberWithDouble:FixMargin]];
        }else
        {
            CGFloat originX = [originXArray[i -1] doubleValue] + [_titleLengthArray[i-1] doubleValue] + FixMargin;
            [originXArray addObject:[NSNumber numberWithDouble:originX]];
            [btn setFrame:CGRectMake(originX, _buttonY, [_titleLengthArray[i] doubleValue], self.bounds.size.height - _buttonY)];
        }
       
        [self addSubview:btn];
        [self.btnArray addObject:btn];
        _isFirstLayoutSubView = NO;
        
    }
}
- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    [self layoutSubviews];
    if (selectedIndex > _items.count -1) {
        
        NSException *exception = [[NSException alloc] initWithName:@"数组越界" reason:@"selectedIndex大于items数组个数" userInfo:nil];
        @throw exception;
    }
    
    UIButton *currentBtn = _btnArray[_selectedIndex];
    currentBtn.selected = NO;
    currentBtn.userInteractionEnabled = YES;
    UIButton *choosedBtn = _btnArray[selectedIndex];
    
    [self onClickedButton:choosedBtn];
    _selectedIndex = selectedIndex;

}
- (void)setSelectedIndex2:(NSInteger)selectedIndex2
{
    
    [self layoutSubviews];
    if (selectedIndex2 > _items.count -1) {
        
        NSException *exception = [[NSException alloc] initWithName:@"数组越界" reason:@"selectedIndex2大于items数组个数" userInfo:nil];
        @throw exception;
    }
    
    UIButton *currentBtn = _btnArray[_selectedIndex2];
    currentBtn.selected = NO;
    currentBtn.userInteractionEnabled = YES;
    UIButton *choosedBtn = _btnArray[selectedIndex2];
    
    [self onClickedButton2:choosedBtn];
    _selectedIndex = selectedIndex2;
    
}
- (void)setSelectedIndex3:(NSInteger)selectedIndex3
{
    [self layoutSubviews];
    if (selectedIndex3 > _items.count -1) {
        
        NSException *exception = [[NSException alloc] initWithName:@"数组越界" reason:@"selectedIndex2大于items数组个数" userInfo:nil];
        @throw exception;
    }
    
    UIButton *currentBtn = _btnArray[_selectedIndex3];
    currentBtn.selected = NO;
    currentBtn.userInteractionEnabled = YES;
    UIButton *choosedBtn = _btnArray[selectedIndex3];
    [self moveSliderRightBySelectedIndex:choosedBtn];
    _selectedIndex3 = selectedIndex3;


}


- (void)moveSliderRightBySelectedIndex:(UIButton *)button
{
    _isFirstLayoutSubView = NO;
    UIButton *currentBtn = (UIButton *)[self viewWithTag:ButtonTag + _selectedIndex3];
   

    [UIView animateWithDuration:0.1 animations:^{
        
       
        _slider.frame = CGRectMake(self.sliderOffset + _buttonMargin, _slider.frame.origin.y, [_titleLengthArray[_selectedIndex] doubleValue], _slider.frame.size.height);
        
    }];
    

    CGFloat sliderRightX = _slider.frame.origin.x + _slider.frame.size.width;
    
    if (_slider.frame.origin.x < button.center.x || sliderRightX > button.center.x) {
        
        currentBtn.selected = NO;
        currentBtn.userInteractionEnabled = YES;
        
        button.selected = YES;
        button.userInteractionEnabled = NO;

    }
    
    
}
- (void)onClickedButton2:(UIButton *)button
{
    _isFirstLayoutSubView = NO;
    UIButton *currentBtn = (UIButton *)[self viewWithTag:ButtonTag + _selectedIndex2];
    currentBtn.selected = NO;
    currentBtn.userInteractionEnabled = YES;
    
    button.selected = YES;
    button.userInteractionEnabled = NO;
    
    _selectedIndex2 = button.tag - ButtonTag;
    
    self.currentXOffset = button.center.x;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        
        _slider.frame = CGRectMake(_slider.frame.origin.x, _slider.frame.origin.y, [_titleLengthArray[_selectedIndex] doubleValue], _slider.frame.size.height);
        
        _slider.center = CGPointMake(button.center.x, _slider.center.y);
        
    }];
}
- (void)onClickedButton:(UIButton *)button
{
    _isFirstLayoutSubView = NO;
    UIButton *currentBtn = (UIButton *)[self viewWithTag:ButtonTag + _selectedIndex];
    currentBtn.selected = NO;
    currentBtn.userInteractionEnabled = YES;
    
    button.selected = YES;
    button.userInteractionEnabled = NO;
    
    _selectedIndex = button.tag - ButtonTag;
    
    self.currentXOffset = button.center.x;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        
        _slider.frame = CGRectMake(_slider.frame.origin.x, _slider.frame.origin.y, [_titleLengthArray[_selectedIndex] doubleValue], _slider.frame.size.height);
        
        _slider.center = CGPointMake(button.center.x, _slider.center.y);
        
    }];
    
    if ([self.target respondsToSelector:self.action]) {
        
        
        
        [self.target performSelector:self.action withObject:self];
        
        
    };
    
}
- (void)addTarget:(id)target withAction:(SEL)action
{
    self.target = target;
    
    self.action = action;
}

/**
 *  @author 黄梓伦, 16-09-23 02:09:30
 *
 *  此方法实际没有作用，对于自适应宽度的Segment，其Margin无法确定。
 */
- (void)calculateMargin
{
    __block CGFloat count;
    
    [_items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        ++count;
    }];
    _buttonMargin = (self.bounds.size.width - _totalWidth) / (count + 1);
    
}
- (void)addUpTitleLength
{
    _totalWidth = 0;
    [self.titleLengthArray removeAllObjects];
    for (NSUInteger i = 0;i < _items.count;i++) {
        CGSize titleSize ;
        titleSize = [_items[i] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_fontSize]}];
        _totalWidth += titleSize.width;
        [self.titleLengthArray addObject:[NSNumber numberWithDouble:titleSize.width]];
    }
}

- (void)setFontSize:(CGFloat)fontSize
{
    
    _fontSize = fontSize;
    [self addUpTitleLength];
    [self setNewFrame];
   
    
    
}


@end
