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

@end

@implementation RootViewController
{
    UIImageView *imageView;//ImageView for rotation in rightBarbuttonItem when the music is playing
    CGFloat imageviewAngle;
   
    UIButton *_rightMusicBtn;
    NSTimer *_timer;
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
    
    
    
    [self.view addSubview:_rightMusicBtn];
    [_rightMusicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.view.mas_top).offset(74);
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
        
    }];
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
    CustomProgressView *tProgress =weakSelf.currrentCell.progressView;
    
    self.observer = [self.musicPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 10) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        
        float current = time.value*1.0f/ time.timescale;
        
        
        tProgress.percentage = current / _currrentCell.model.music_duration;
        
        weakSelf.currrentCell.musicDurationLabel.text = [weakSelf formatTime:current];
        
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
    // Dispose of any resources that can be recreated.
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
