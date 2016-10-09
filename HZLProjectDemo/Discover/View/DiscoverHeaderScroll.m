//
//  DiscoverHeaderScroll.m
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 10/7/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "DiscoverHeaderScroll.h"
@interface DiscoverHeaderScroll()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *imageViewArr;


@end
@implementation DiscoverHeaderScroll
{
    __block CGFloat count;
    NSTimer *_timer;
    
}
- (NSMutableArray *)imageViewArr
{
    
    if (!_imageViewArr) {
        
        _imageViewArr = [[NSMutableArray alloc] init];
    }
    return _imageViewArr;
    
}

- (void)createImageViews
{
    count = 0;
    CGFloat ScrollW = self.frame.size.width;
    CGFloat ScrollH = self.frame.size.height;
    for (NSInteger i = 0; i < _imageArrays.count; i++) {
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScrollW * (i + 1), -64, ScrollW, ScrollH)];
        
        NSString *imageStr = (NSString *)_imageArrays[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:nil];
        imageView.userInteractionEnabled = YES;
        
        [self.imageViewArr addObject:imageView];
        [self addSubview:imageView];
    }
   
    [_imageArrays enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               
        count++;
        
    }];
    self.bounds = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.pagingEnabled = YES;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.contentSize = CGSizeMake(ScrollW * (count + 2), 0);
    
    UIImageView *firstImageView = [[UIImageView alloc] init];
    
    firstImageView.frame = CGRectMake(0, -64, ScrollW, ScrollH);
    
    [firstImageView sd_setImageWithURL:[NSURL URLWithString:[_imageArrays lastObject]] placeholderImage:nil];
    
    [self addSubview:firstImageView];
    
    UIImageView *lastImageView = [[UIImageView alloc] init];;
    
    lastImageView.frame = CGRectMake(ScrollW * (count + 1), -64, ScrollW, ScrollH);
    
    [lastImageView sd_setImageWithURL:[NSURL URLWithString:_imageArrays[0]] placeholderImage:nil];
    
    [self addSubview:lastImageView];
    
    __weak typeof(self) weakSelf = self;
    
    self.delegate = weakSelf;
    [self setContentOffset:CGPointMake(self.frame.size.width, -64)];
    _timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(changeContoffSet) userInfo:nil repeats:YES];
    [_timer setFireDate:[NSDate distantPast]];
}
- (void)changeContoffSet
{
    CGFloat offSetX = self.contentOffset.x;
    offSetX += self.frame.size.width;
    [UIView animateWithDuration:1 animations:^{
        
        [self setContentOffset:CGPointMake(offSetX, -64)];

    }];
    [self contentOffsetCheck];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    [self contentOffsetCheck];
    
    
}
- (void)contentOffsetCheck
{
    CGFloat offSetX = self.contentOffset.x;
    
    if (offSetX == self.frame.size.width * (count + 1)) {
        
        [self setContentOffset:CGPointMake(self.frame.size.width, -64)];
        return;
    }else if (offSetX == 0)
    {
        
        [self setContentOffset:CGPointMake(count * self.frame.size.width, -64)];
        return;
        
    }

}

- (void)setImageArrays:(NSArray *)imageArrays
{
    
    _imageArrays = imageArrays;
    
    [self createImageViews];
    
}

@end
