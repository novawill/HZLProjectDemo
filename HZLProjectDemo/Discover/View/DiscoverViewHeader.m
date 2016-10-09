//
//  DiscoverViewHeader.m
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 10/6/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "DiscoverViewHeader.h"
@interface DiscoverViewHeader()
@property (weak, nonatomic) IBOutlet UIButton *videoBtn;
@property (strong, nonatomic) UIButton *musicBtn;
@property (weak, nonatomic) IBOutlet UIButton *albumBtn;
@property (strong, nonatomic) UIButton *posterBtn;
@property (weak, nonatomic) IBOutlet UIButton *daynoteBtn;

@end
@implementation DiscoverViewHeader



- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        self =  [DiscoverViewHeader shareView];
    }
    return self;
    
}
- (instancetype)init
{
    if (self = [super init]) {
        
        self = [DiscoverViewHeader shareView];
        
    }
    
    return self;
    
}

+(instancetype)shareView
{
    
    DiscoverViewHeader * view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        
    return view;
}

@end
