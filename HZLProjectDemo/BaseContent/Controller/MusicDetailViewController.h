//
//  MusicDetailViewController.h
//  MOMO
//
//  Created by 黄梓伦 on 6/11/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "BaseViewController.h"
#import "MusicModel.h"
#import "fullPicButton.h"
@interface MusicDetailViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UIView *headView;

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *songNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;
@property (weak, nonatomic) IBOutlet fullPicButton *musicPlayBtnHead;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *iconAuthorLabel;
@property (nonatomic, strong) Meows *model;
@property (weak, nonatomic) IBOutlet UIImageView *albumImageView;
@property (weak, nonatomic) IBOutlet fullPicButton *musicPlayBtn;
@property (weak, nonatomic) IBOutlet UIProgressView *musicProgress;
@property (weak, nonatomic) IBOutlet UILabel *musicDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *headLabel;

@property (weak, nonatomic) IBOutlet UILabel *iconDetailLabel;
@property (weak, nonatomic) IBOutlet fullPicButton *backBtn;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *lyricsLabel;
#pragma mark - Actions
- (IBAction)backBtnAction:(fullPicButton *)sender;
- (IBAction)musicPlayAction:(fullPicButton *)sender;
- (IBAction)muiscPlayBtnHeadAction:(fullPicButton *)sender;

@end
