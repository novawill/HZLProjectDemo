//
//  MusicCell.h
//  MOMO
//
//  Created by 黄梓伦 on 5/29/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModel.h"
#import <AVFoundation/AVFoundation.h>
#import "fullPicButton.h"
#import "CustomProgressView.h"
@protocol PlayMusic



@end


@interface MusicCell : UITableViewCell
//Properties
@property (weak, nonatomic) IBOutlet UILabel *groupName;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *songNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *musicDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *songDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *songDescriptionText;
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet CustomProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *likeAction;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *thumbButton;
@property (weak, nonatomic) IBOutlet UILabel *thumbNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentNumberLabel;
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, strong) AVPlayer *audioPlayer;
@property (nonatomic, strong)  void (^playMusic)(BOOL isplaying,NSString *musicUrl);
@property (nonatomic, strong) void (^transModel)(Meows *model);
@property (nonatomic, strong) Meows *model;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (nonatomic, assign) BOOL isPlay;
@property (nonatomic, copy) NSString *musicDurationStr;
@property (nonatomic, strong) id observer;


//Actions
- (IBAction)playAction:(UIButton *)sender;
- (IBAction)sharAction:(UIButton *)sender;
- (IBAction)thumbAction:(UIButton *)sender;
- (IBAction)commentAction:(UIButton *)sender;
- (void)setModel:(Meows *)model;

@end
