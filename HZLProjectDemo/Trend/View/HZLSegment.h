//
//  HZLSegment.h
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 9/22/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef struct ZLFrame{
    
    CGFloat originX;
    CGFloat originY;
    CGFloat SizeHeight;
    
}HZLFrame;
HZLFrame CGHZLFrameMake(CGFloat x, CGFloat y, CGFloat height);
HZLFrame CGHZLFrameMake(CGFloat x, CGFloat y, CGFloat height)
{
    HZLFrame rect;
    rect.originX = x;
    rect.originY = y;
    rect.SizeHeight = height;
    return rect;
}
@interface HZLSegment : UIView


@property (nonatomic, strong) NSArray *items;

@property (nonatomic, assign) NSInteger selectedIndex;

- (instancetype)initWithHZLFrame:(HZLFrame)frame items:(NSArray *)items;

- (void)addTarget:(id)target withAction:(SEL)action;

@end
