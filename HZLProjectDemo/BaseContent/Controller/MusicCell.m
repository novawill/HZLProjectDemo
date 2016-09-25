//
//  MusicCell.m
//  MOMO
//
//  Created by 黄梓伦 on 5/29/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "MusicCell.h"

#import "MusicDetailViewController.h"
@interface MusicCell()

@property (nonatomic, strong) AVPlayerItem *songItem;
@end

@implementation MusicCell
static BOOL isPlay;

- (void)awakeFromNib {
    
    isPlay = NO;
    self.progressView.hidden = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDetail)]];
    
}
- (void)showDetail
{
    MusicDetailViewController *music = [[MusicDetailViewController alloc] init];
    
    self.transModel = ^(Meows *model){
        
        music.model = model;
        
        
    };
    self.
    self.transModel(self.model);
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:music animated:YES completion:nil];
    
    
    isPlay = NO;
    self.progressView.hidden = YES;
    [self.playBtn setImage:[UIImage imageNamed:@"btn-musicplay-play"]
                  forState:UIControlStateNormal];

    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    if ((object == self.songItem) && [keyPath isEqualToString:@"status"]) {
        
        AVPlayerStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        
        switch (status) {
            case AVPlayerStatusUnknown: {
                
                break;
            }
            case AVPlayerStatusReadyToPlay: {
                
                isPlay = NO;
                self.progressView.hidden = YES;
                
                
                break;
            }
            case AVPlayerStatusFailed: {
                
                break;
            }
        }
        
    }
    
    
    
    
    
    
}

- (IBAction)playAction:(fullPicButton *)sender {
    
    
    if (! isPlay) {
        
        isPlay = YES;
        self.progressView.hidden = NO;
        [self.playBtn setImage:[UIImage imageNamed:@"btn-musicplay-pause"]
                      forState:UIControlStateNormal];
        
        __weak typeof(self) weakSelf = self;
        __weak CustomProgressView *tProgress = self.progressView;
        [_audioPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 10) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
            
            float current = time.value*1.0f/ time.timescale;
            
            tProgress.percentage = current / weakSelf.model.music_duration;
            
            weakSelf.musicDurationLabel.text = [weakSelf formatTime:current];
            
        }];
        
        [self.audioPlayer play];

    
    }else if(isPlay)
    {
        
        [self.audioPlayer pause];
        [self.playBtn setImage:[UIImage imageNamed:@"btn-musicplay-play"]
                      forState:UIControlStateNormal];

        
    }
    self.playMusic(isPlay);
}
- (IBAction)sharAction:(fullPicButton *)sender {
}
- (IBAction)thumbAction:(fullPicButton *)sender {
}
- (IBAction)commentAction:(fullPicButton *)sender {
}
//Formats time
- (NSString *)formatTime:(float)num{
    
    int sec = (int)num % 60;
    int min = (int)num / 60;
    if (num < 60) {
        return [NSString stringWithFormat:@"00:%02.0f",num];
    }
    return [NSString stringWithFormat:@"%02d:%02d",min,sec];
}

- (void)setModel:(Meows *)model
{
    
    _model = model;
    
    //Sets BackImage
    [self.backImage sd_setImageWithURL:[NSURL URLWithString:_model.thumb.raw] placeholderImage:[UIImage imageNamed:@"WilliamHuang.jpg"]];
    
    
    self.singerNameLabel.text = _model.artist;
    
    self.thumbNumberLabel.text = [NSString stringWithFormat:@"%ld",_model.bang_count];
    
    if (_model.category.name != nil) {
        
        self.typeLabel.text = [NSString stringWithFormat:@"#%@",_model.category.name];
    }else
    {
        //On account of several tests, some _model.category,
        //which should had be "音乐" in accordance with json file,
        //returned nil value or even had no property of category for uncertain reason,
        //so I let typeLabel.text be "#其它" in that situation.
        self.typeLabel.text = @"#其它";
    }
    
    
    self.songDetailLabel.text = _model.title;
    
    self.songDescriptionText.text = _model.desc;
    
    self.groupName.text = _model.group.name;
    
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:_model.group.logo_url]
                      placeholderImage:[UIImage imageNamed:@"AppIcon60x60"]];
    
    self.commentNumberLabel.text = [NSString stringWithFormat:@"%ld",_model.comment_count];
    
    //Converts seconds to mm:ss
    NSInteger musicDurationBySeconds = _model.music_duration;
    
    NSInteger minutes = musicDurationBySeconds / 60;
    NSInteger seconds = musicDurationBySeconds % 60;
    
    
    NSString *musicDurationStr = [[NSString alloc] initWithFormat:@"%ld:%@",minutes, seconds > 9 ?
                                       [NSString stringWithFormat:@"%ld",seconds]:
                                       [NSString stringWithFormat:@"0%ld",seconds]];
    
    
    
    self.musicDurationLabel.text = musicDurationStr;
    
    self.songNameLabel.text = _model.song_name;
    
    self.urlString = _model.music_url;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self.songItem removeObserver:self forKeyPath:@"status"];
        
        self.songItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:model.music_url]];
        
        [self.songItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        
        self.audioPlayer = [AVPlayer playerWithPlayerItem:self.songItem];

    });
    
   
}



@end
