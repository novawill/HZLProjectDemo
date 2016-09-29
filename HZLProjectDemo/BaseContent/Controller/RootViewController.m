//
//  RootViewController.m
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 9/29/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "RootViewController.h"
#import "HZLTabBarViewController.h"
#import "MusicCell.h"
@interface RootViewController ()
@property (nonatomic, strong) AVPlayerItem *songItem;
@property (nonatomic, strong) UIView *playView;
@property (nonatomic, strong) UIProgressView *progress;
@property (nonatomic, strong) UILabel *durationLabel;
@property (nonatomic, strong) UILabel *songNameLabel;
@end

@implementation RootViewController
{
    UIImageView *imageView;//ImageView for rotation in rightBarbuttonItem when the music is playing
    CGFloat imageviewAngle;
   
    UIButton *_rightMusicBtn;
    NSTimer *_timer;
    UIImageView *_imageView;
    UIButton *_playBtn;
   
}
- (void)setRightBarButtonItem
{
    _rightMusicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    __weak typeof(self) weakSelf = self;
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn-player"]];
    imageView.autoresizingMask = UIViewAutoresizingNone;
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.bounds=CGRectMake(0, 0, 40, 40);
    
    [_rightMusicBtn addSubview:imageView];
    
    
    [_rightMusicBtn addTarget:self action:@selector(showPlayView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_rightMusicBtn];
    [_rightMusicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.view.mas_top).offset(74);
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
        
    }];
}
- (void)createPlayView
{
    
   _playView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    [self.view addSubview:_playView];
    _playView.backgroundColor = [UIColor blackColor];
    _playView.alpha = 0.9;
    

   
}
- (void)createUIOnPlayView
{
    if (_durationLabel ) {
        
        [_imageView removeFromSuperview];
        [_progress removeFromSuperview];
        [_durationLabel removeFromSuperview];
        [_songNameLabel removeFromSuperview];
        
    }
    
    _imageView = [[UIImageView alloc] init];
    [self.playView addSubview:_imageView];
    __weak typeof(self) weakSelf = self;
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(weakSelf.playView.mas_left).offset(20);
        make.top.equalTo(weakSelf.playView.mas_top).offset(27);
        make.height.equalTo(@50);
        make.width.equalTo(@50);
    }];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    NSString* key = [manager cacheKeyForURL:[NSURL URLWithString:_currrentCell.model.thumb.raw]];
    SDImageCache* cache = [SDImageCache sharedImageCache];
    
    UIImage *image = [cache imageFromDiskCacheForKey:key];
    _imageView.image = image;
    _imageView.contentMode = UIViewContentModeScaleToFill;
   
    
    _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                         
    _playBtn.titleLabel.text = @"";
    [_playBtn setImage:[UIImage imageNamed:@"btn-musicplay-pause"] forState:UIControlStateNormal];
    [_playBtn addTarget:self action:@selector(playViewBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _imageView.userInteractionEnabled = YES;
    [_imageView addSubview:_playBtn];
    __weak typeof(UIImageView *) weakImageView = _imageView;
    [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.center.mas_equalTo(weakImageView.center);
        make.height.equalTo(@25);
        make.width.equalTo(@25);
    }];
//ProgressSlider
    
    _progress = [[UIProgressView alloc] init];
    [self.playView addSubview:_progress];
//DurationLabel
    _durationLabel = [[UILabel alloc] init];
    [self.playView addSubview:_durationLabel];
    _durationLabel.font = [UIFont systemFontOfSize:13];
    _durationLabel.text = _currrentCell.musicDurationStr;
    [_durationLabel sizeToFit];
    _durationLabel.textColor = [UIColor whiteColor];
//SongName
    _songNameLabel = [[UILabel alloc] init];
    [self.playView addSubview:_songNameLabel];
    [_songNameLabel sizeToFit];
    _songNameLabel.textColor = [UIColor whiteColor];
    _songNameLabel.font = [UIFont systemFontOfSize:15];
    
    NSString *string = [NSString stringWithFormat:@"%@-%@",_currrentCell.model.song_name,_currrentCell.model.artist];
    _songNameLabel.text = string;
    
//Constrains
   

    [_progress mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakImageView.mas_top).offset(5);
       
        make.right.equalTo(weakSelf.playView.mas_right).offset(-20);
        
        make.left.equalTo(weakImageView.mas_right).offset(5);
        
        make.height.equalTo(@2);
        
    }];
    [_durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(weakImageView.mas_right).offset(5);
        
        make.width.equalTo(@100);
        
        make.top.equalTo(_progress.mas_bottom).offset(10);

    }];
    [_songNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(weakImageView.mas_right).offset(5);

        make.width.equalTo(_progress.mas_width);
        
        make.top.equalTo(_durationLabel.mas_bottom).offset(3);
    }];

    
}
- (void)playViewBtnAction
{
    _isPlay = !_isPlay;
    if (_isPlay) {
        
     
        [self.musicPlayer play];
        [_playBtn setImage:[UIImage imageNamed:@"btn-musicplay-pause"] forState:UIControlStateNormal];
    }else
    {
        
        [self.musicPlayer pause];
        [_playBtn setImage:[UIImage imageNamed:@"btn-musicplay-play"] forState:UIControlStateNormal];
        
    }
}
- (void)showPlayView
{
    
   [self createUIOnPlayView];
    if (_playView.frame.origin.y != 0) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            
            _playView.frame = CGRectMake(0, 0, CGRectGetWidth(_playView.frame), CGRectGetHeight(_playView.frame));
            
        }];
        __weak typeof(self) weakSelf = self;
        [_rightMusicBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.view.mas_centerX);
            make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-10);
            make.width.equalTo(@40);
            make.height.equalTo(@40);
            
        }];

    }else
    {
        [UIView animateWithDuration:0.5 animations:^{
            
            
            _playView.frame = CGRectMake(0, self.view.frame.size.height, CGRectGetWidth(_playView.frame), CGRectGetHeight(_playView.frame));
            
        }];
        __weak typeof(self) weakSelf = self;
        [_rightMusicBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(weakSelf.view.mas_top).offset(74);
            make.right.equalTo(weakSelf.view.mas_right).offset(-10);
            make.width.equalTo(@40);
            make.height.equalTo(@40);

            
        }];
        if (!_isPlay) {
            
            [self.musicPlayer removeTimeObserver:self.observer];
            
            [self.songItem removeObserver:self forKeyPath:@"status"];
            
            self.musicPlayer = nil;
            
            self.songItem = nil;
            [_timer setFireDate:[NSDate distantFuture]];
            
            _rightMusicBtn.hidden = YES;
            
            _currrentCell.isPlay = NO;
            _currrentCell.progressView.percentage = 0;
            _currrentCell.musicDurationLabel.text = _currrentCell.musicDurationStr;

            [_currrentCell.playBtn setImage:[UIImage imageNamed:@"btn-musicplay-play"]
        forState:UIControlStateNormal];

            
        }
    }
     [self.view bringSubviewToFront:_rightMusicBtn];
}
- (void)imageRotation
{
    
    imageviewAngle += 2;
    if (imageviewAngle > 360) {
        
        imageviewAngle = 0;
    }
    imageView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(imageviewAngle));
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    HZLTabBarViewController *tabVC = [[HZLTabBarViewController alloc] init];
    [self.view addSubview:tabVC.view];
    [self addChildViewController:tabVC];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(imageRotation) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    [_timer setFireDate:[NSDate  distantFuture]];
    [self setRightBarButtonItem];
    [self createPlayView];
    _rightMusicBtn.hidden = YES;
    
}
- (NSString *)formatTime:(float)num{
    
    int sec = (int)num % 60;
    int min = (int)num / 60;
    if (num < 60) {
        return [NSString stringWithFormat:@"00:%02.0f",num];
    }
    return [NSString stringWithFormat:@"%02d:%02d",min,sec];
}
- (void)updateProgressAndTime
{
    __weak typeof(self) weakSelf =self;
    CustomProgressView *tProgress = weakSelf.currrentCell.progressView;
;
    
    self.observer = [self.musicPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 10) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        
        float current = time.value*1.0f/ time.timescale;
        
        
        tProgress.percentage = current / _currrentCell.model.music_duration;
        
        weakSelf.currrentCell.musicDurationLabel.text = [weakSelf formatTime:current];
        [weakSelf.progress setProgress:current / weakSelf.currrentCell.model.music_duration animated:YES];
        
        weakSelf.durationLabel.text = [[weakSelf formatTime:current] stringByAppendingString:[NSString stringWithFormat:@"/%@",[weakSelf formatTime:weakSelf.currrentCell.model.music_duration]]];
    }];
    
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    if ((object == self.songItem) && ([keyPath isEqualToString:@"status"])) {
        
        AVPlayerStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        
        switch (status) {
            case AVPlayerStatusUnknown: {
                
                break;
            }
            case AVPlayerStatusReadyToPlay: {
                
                [self.musicPlayer play];
                
                break;
            }
            case AVPlayerStatusFailed: {
                
                break;
            }
        }
    }
}

#pragma mark - Creating AVPlayer and add it
- (void)playerMusicIsPlay:(BOOL)isPlay musicUrl:(NSString *)url
{
    _isPlay = isPlay;
    if (_onClickedCell == _currrentCell) {
        
        if ([url isEqualToString:_musicUrl]) {
            
            if (_isPlay) {
                if (!self.songItem) {
                    
                    [self createSongItemisPlay:isPlay songUrl:url];
                    [self updateProgressAndTime];
                }
                [self.musicPlayer play];
                [_timer setFireDate:[NSDate distantPast]];
                _rightMusicBtn.hidden = NO;
                
                
            }else
            {
                [self.musicPlayer pause];
                [_timer setFireDate:[NSDate distantFuture]];
                _rightMusicBtn.hidden = YES;
                
            }
        }else
        {
            _currrentCell.isPlay = NO;
            _currrentCell.progressView.percentage = 0;
            _currrentCell.musicDurationLabel.text = _currrentCell.musicDurationStr;
            [self createSongItemisPlay:isPlay songUrl:url];
            [self updateProgressAndTime];
        }
    }else
    {
        _currrentCell.isPlay = NO;
        _currrentCell.progressView.percentage = 0;
        _currrentCell.musicDurationLabel.text = _currrentCell.musicDurationStr;
        
        [self createSongItemisPlay:isPlay songUrl:url];
        _currrentCell = _onClickedCell;
        [self updateProgressAndTime];
        
    }
}
- (void)createSongItemisPlay:(BOOL)isplay songUrl:(NSString *)url
{
    [self.musicPlayer removeTimeObserver:self.observer];
    
    [self.songItem removeObserver:self forKeyPath:@"status"];
    
    self.songItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:url]];
    
    [self.songItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    self.musicPlayer = [AVPlayer playerWithPlayerItem:self.songItem];
    
    _musicUrl = [NSString stringWithString:url];;
    
    [_timer setFireDate:[NSDate distantPast]];
    
    _rightMusicBtn.hidden = NO;
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [self.musicPlayer removeTimeObserver:self.observer];
    [self.songItem removeObserver:self forKeyPath:@"status"];
    self.musicPlayer = nil;
    self.songItem = nil;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
