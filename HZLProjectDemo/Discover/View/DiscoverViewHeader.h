//
//  DiscoverViewHeader.h
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 10/6/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverHeaderScroll.h"
@interface DiscoverViewHeader : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *muiscBtn;
@property (weak, nonatomic) IBOutlet UIButton *albumBtn;
@property (weak, nonatomic) IBOutlet UIButton *posterBtn;
@property (weak, nonatomic) IBOutlet UIView *muiscView;
@property (weak, nonatomic) IBOutlet UIButton *dayNoteBtn;
@property (weak, nonatomic) IBOutlet UIButton *videoBtn;
@property (weak, nonatomic) IBOutlet UIView *posterView;

+(instancetype)shareView;
@property (weak, nonatomic) IBOutlet DiscoverHeaderScroll *headerScroll;

@property (nonatomic, copy) void (^onClickMusicBtn)(void);


@end
