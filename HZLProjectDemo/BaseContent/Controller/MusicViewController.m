//
//  MusicViewController.m
//  MOMO
//
//  Created by 黄梓伦 on 5/29/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "MusicViewController.h"
#import "MusicCell.h"
#import <AVFoundation/AVFoundation.h>
#import "MusicDetailViewController.h"
#import "RootViewController.h"
NSString * const MusicCellIdentifier = @"MusicCellIdentifier";

@interface MusicViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *musicTableView;
//Sets an array to populate data requested from the Internet
@property (nonatomic, strong) NSMutableArray *musicArray;
@property (nonatomic, assign) NSUInteger start;//Property of Start
@property (nonatomic, strong) MJRefreshGifHeader *gifHeader;
@property (nonatomic, strong) NSMutableArray *refreshImages;
@property (nonatomic, strong) NSMutableArray *normalImages;
@property (nonatomic, strong) AVPlayerItem *songItem;
@property (nonatomic, strong) AVPlayer *musicPlayer;
@property (nonatomic, weak)  MusicCell *currrentCell;
@property (nonatomic, weak) MusicCell *onClickedCell;
@property (nonatomic, strong) id observer;
@property (nonatomic, weak) RootViewController *rootVC;
@end

@implementation MusicViewController
{
    UIImageView *imageView;//ImageView for rotation in rightBarbuttonItem when the music is playing
    CGFloat imageviewAngle;
    BOOL _isPlay; //Whether the music is playing
    UIButton *_rightMusicBtn;
    NSTimer *_timer;
    NSString *_musicUrl;
    
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


- (void)viewDidLoad {
    [super viewDidLoad];
    self.start = 0;
    [self createView];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(imageRotation) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    [_timer setFireDate:[NSDate  distantFuture]];
    [self setRightBarButtonItem];
    _rightMusicBtn.hidden = YES;
    _rootVC = (RootViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    self.navigationItem.rightBarButtonItem = nil;
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super  viewDidAppear:animated];
    //[self playerMusic];
    
    
    
    
}
- (NSMutableArray *)refreshImages
{
    
    if (!_refreshImages) {
        
        
        _refreshImages = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 20; i++) {
            
            NSString *imageName = [NSString stringWithFormat:@"mono-black-%d",i+1];
            
            UIImage *image = [UIImage imageNamed:imageName];
            
            [_refreshImages addObject:image];
        }
        
        
    }
    return _refreshImages;
}

- (NSMutableArray *)normalImages
{
    
    if (!_normalImages) {
        
        _normalImages = [[NSMutableArray alloc] init];
        
        
        UIImage *image = [UIImage imageNamed:@"mono-black-20"];
        [_normalImages addObject:image];
    }
    return _normalImages;
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
        
        make.top.equalTo(weakSelf.view.mas_top).offset(10);
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

#pragma mark - LazyLoad for _musicArray
- (NSMutableArray *)musicArray
{
    if (!_musicArray) {
        
        _musicArray = [[NSMutableArray alloc] init];
        
        
    }
    return _musicArray;
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

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
    
    
    [self.musicTableView.mj_header beginRefreshing];
    
    
}

- (void)createView
{
    //Sets Navigation title with textcolor
    [self addNavigationTitle:@"听音乐" andColor:[UIColor blackColor]];
    
    //Sets backAction Button
    [self addBackButtonWithImage:[UIImage imageNamed:@"browser-back-black"]];
    
    __weak typeof(self) weakSelf = self;

    _musicTableView = [[UITableView alloc] init];
    
    [self.view addSubview:_musicTableView];
    
    _musicTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_musicTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.edges.equalTo(weakSelf.view);
      
        
    }];
    
    _musicTableView.dataSource = self;
    
    //Sets row height
    _musicTableView.rowHeight = ScreenH - 64;//Subtracting the height of UINavigationBar which is 64)
    
    //Resiters MusicCell
    [_musicTableView registerNib:[UINib nibWithNibName:@"MusicCell" bundle:nil] forCellReuseIdentifier:MusicCellIdentifier];
 
    //mj_Header & mj_Footer
    
      _gifHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        
        [weakSelf requestDataWithURLWithStart:weakSelf.start];
        weakSelf.start += 10;
        weakSelf.musicTableView.mj_footer.hidden = YES;
       
    }];
    [_gifHeader setImages:self.refreshImages forState:MJRefreshStateRefreshing];
    [_gifHeader setImages:self.normalImages forState:MJRefreshStateIdle];
    [_gifHeader setImages:self.normalImages forState:MJRefreshStatePulling];
    _gifHeader.lastUpdatedTimeLabel.hidden = YES;
    _gifHeader.stateLabel.hidden = YES;
    _musicTableView.mj_header = _gifHeader;
    
    
    
    _musicTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        weakSelf.start += 10;
        [weakSelf requestDataWithURLWithStart:weakSelf.start];
        weakSelf.musicTableView.mj_header.hidden = YES;
        
    }];
    //Starts request
  
    [_musicTableView.mj_header beginRefreshing];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.musicArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MusicCell *cell = [tableView dequeueReusableCellWithIdentifier:MusicCellIdentifier forIndexPath:indexPath];
    
    Meows *model = self.musicArray[indexPath.row];
    
    cell.model = model;
    
   
    if ([model.music_url isEqualToString:_rootVC.musicUrl]) {
        
        cell.isPlay = _rootVC.isPlay;
      
        [_rootVC updateProgressAndTime];
        if (cell.isPlay) {
            
            cell.progressView .hidden = NO;
            
            [cell.playBtn setImage:[UIImage imageNamed:@"btn-musicplay-pause"]
                          forState:UIControlStateNormal];
            
            
        }else
        {
           
            cell.progressView .hidden = NO;
            [cell refreshProgressByReAppearWithTime:_rootVC.musicPlayer.currentTime];
            [cell.playBtn setImage:[UIImage imageNamed:@"btn-musicplay-play"]
                          forState:UIControlStateNormal];
        }
    }else if(cell == _rootVC.currrentCell)
    {
   
       [_rootVC.musicPlayer removeTimeObserver:_rootVC.observer];
        _rootVC.observer = nil;
        cell.progressView.percentage = 0;
        cell.isPlay = NO;
        [cell.playBtn setImage:[UIImage imageNamed:@"btn-musicplay-play"]
                      forState:UIControlStateNormal];
        cell.musicDurationLabel.text = cell.musicDurationStr;

    }else
    {   [_rootVC.musicPlayer removeTimeObserver:_rootVC.observer];
        _rootVC.observer = nil;
        cell.progressView.percentage = 0;
        cell.isPlay = NO;
        [cell.playBtn setImage:[UIImage imageNamed:@"btn-musicplay-play"]
                      forState:UIControlStateNormal];
        cell.musicDurationLabel.text = cell.musicDurationStr;
    }
    cell.playMusic = ^(BOOL isPlaying,NSString *url){
       
        
       _rootVC.onClickedCell = cell;
        
        [_rootVC playerMusicIsPlay:isPlaying musicUrl:url];

    };
    
    return cell;
    
}
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)requestDataWithURLWithStart:(NSUInteger)start
{
    
    
    
    //Sets URL
    NSString *url;
    
    if (start == 0) {
       url = musicAPI;
    }else
    {
       url = [musicAPI stringByAppendingString:[NSString stringWithFormat:@"&start=%lu",start]];
    }
    
    //Requests datasource
    [self.httpManager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        MusicModel *musicModel = [MusicModel yy_modelWithJSON:responseObject];
        
                                             
        if ([self.musicTableView.mj_footer isHidden]) {
            
            [self.musicArray removeAllObjects];
        }
        
        //Adding the parsed data array(i.e meows) to musicArray
        //which is the dataArray for tableView
        [self.musicArray addObjectsFromArray:musicModel.meows];
        
        __weak typeof(self) weakSelf = self;
        
        //Refreshing main UI screen
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            //Refreshing TableView
           [weakSelf.musicTableView reloadData];
            
            //Updating footer and header status
            [weakSelf.musicTableView.mj_header endRefreshing];
            [weakSelf.musicTableView.mj_header endRefreshing];
            weakSelf.musicTableView.mj_header.hidden = NO;
            weakSelf.musicTableView.mj_footer.hidden = NO;
            
            if (musicModel.is_last_page) {
                
                [weakSelf.musicTableView.mj_footer endRefreshingWithNoMoreData];
                [KVNProgress showSuccessWithStatus:@"没有更多数据了，亲~"];
                
            }else
            {
                
                [weakSelf.musicTableView.mj_footer resetNoMoreData];
            }
        });
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        [KVNProgress showErrorWithStatus:error.localizedDescription];
        
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
