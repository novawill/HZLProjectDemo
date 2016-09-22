//
//  HZLSegment.h
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 9/22/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZLSegment : UIView

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, assign) NSInteger selectedIndex;

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items;

- (void)addTarget:(id)target withAction:(SEL)action;

@end
