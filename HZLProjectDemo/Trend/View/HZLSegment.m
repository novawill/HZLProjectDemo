//
//  HZLSegment.m
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 9/22/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "HZLSegment.h"
#define ButtonTag 100
#define SelectedColor [UIColor colorWithRed:0.4 green:0.3 blue:0.7 alpha:1]
#define ButtonTitleFont 15
#define ButtonY 22
#define ButtonTag 100
#define FixMargin 20

@interface HZLSegment()

@property (nonatomic, strong) NSMutableArray *titleLengthArray;

@property (nonatomic, strong) id target;

@property (nonatomic, assign) SEL action;




@end
@implementation HZLSegment{
    
    UIView *_slider;
    CGFloat _totalWidth;
    CGFloat _buttonMargin;
    NSInteger _selectedIndex;
    
    
}

- (NSMutableArray *)titleLengthArray
{
    if (!_titleLengthArray) {
        
        _titleLengthArray = [[NSMutableArray alloc] init];
    }
    return _titleLengthArray;
    
}

- (instancetype)initWithHZLFrame:(HZLFrame)frame items:(NSArray *)items
{
    CGRect newFrame = CGRectMake(frame.originX, frame.originY, 20, frame.SizeHeight);
    
    if (self = [super initWithFrame:newFrame]) {
        
        
        _items = items;
#if 1
         [self addUpTitleLength];
         [self setNewFrame];
#endif
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    
    NSException *exception = [NSException exceptionWithName:@"HZLSegment不能使用initWithFrame方法" reason:@"必须初始化按钮标题" userInfo:nil];
    
    @throw exception;

}

- (void)layoutSubviews
{
    //[self addUpTitleLength];

   // [self calculateMargin];

    [self creatSlider];
    [self creatButton];
    
   
    
    
}
- (void)drawRect:(CGRect)rect
{
    
    
    
    
    
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
    
    
    
    
    
    
}
- (void)creatButton
{
    for (int i = 0;i < _items.count;i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setTitle:_items[i] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        [btn setTitleColor:SelectedColor forState:UIControlStateSelected];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:ButtonTitleFont];
        
        btn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        
        btn.tag = ButtonTag + i;
        
        [btn addTarget:self action:@selector(onClickedButton:) forControlEvents:UIControlEventTouchUpInside];

        if (i == 0) {
            
            [btn setFrame:CGRectMake(_buttonMargin, ButtonY, [_titleLengthArray[i] floatValue], self.bounds.size.height - ButtonY)];
            btn.selected = YES;
            btn.userInteractionEnabled = NO;
        }else
        {
            [btn setFrame:CGRectMake(_buttonMargin + i * (_buttonMargin + [_titleLengthArray[i -1 ] floatValue]), ButtonY, [_titleLengthArray[i] floatValue], self.bounds.size.height - ButtonY)];
            
        }

        
        

        
        self.autoresizesSubviews = YES;
        [self addSubview:btn];

    }
}
- (void)onClickedButton:(UIButton *)button
{
    UIButton *currentBtn = (UIButton *)[self viewWithTag:ButtonTag + _selectedIndex];
    currentBtn.selected = NO;
    currentBtn.userInteractionEnabled = YES;
    
    button.selected = YES;
    button.userInteractionEnabled = NO;
    
    _selectedIndex = button.tag - ButtonTag;
    
    if ([self.target respondsToSelector:self.action]) {
        
        
       [self.target performSelector:self.action withObject:self];
        
        
    };
    
    
    
    
}
- (void)addTarget:(id)target withAction:(SEL)action
{
    self.target = target;
    
    self.action = action;
    
    
    
}


- (void)calculateMargin
{
    
    _buttonMargin = (self.bounds.size.width - _totalWidth) / (_items.count + 1);
    
}
- (void)addUpTitleLength
{
    _totalWidth = 0;
    for (int i = 0;i < _items.count;i++) {
        
        CGSize titleSize = [_items[i] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ButtonTitleFont]}];
        
        _totalWidth += titleSize.width;
        
        [self.titleLengthArray addObject:[NSNumber numberWithFloat:titleSize.width]];
        
    }
}
@end
