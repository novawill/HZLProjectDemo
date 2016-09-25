//
//  MusicDetailViewController.m
//  MOMO
//
//  Created by 黄梓伦 on 6/11/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "MusicDetailViewController.h"
#import "MusicViewController.h"
#import <Accelerate/Accelerate.h>
#import <AVFoundation/AVFoundation.h>
@interface MusicDetailViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) AVPlayer *audioPlayer;

@property (nonatomic, strong) AVPlayerItem *songItem;

@end

@implementation MusicDetailViewController
{
    BOOL isPlay;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    isPlay = NO;
    [self prefersStatusBarHidden];
    [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:_model.group.logo_url]
                      placeholderImage:[UIImage imageNamed:@"AppIcon60x60"]];
    self.iconImage.layer.cornerRadius = CGRectGetWidth(self.iconImage.frame)/2.0f;
    self.iconImage.layer.masksToBounds = YES;
    [self.musicProgress setProgress:0];
    
    self.songNameLabel.text = _model.song_name;
    
    self.singerLabel.text = _model.artist;
    
    self.lyricsLabel.text = _model.lyrics;
    
    self.descLabel.text = _model.desc;
    self.iconAuthorLabel.text = _model.group.name;
    self.scrollView.delegate = self;
    self.musicDurationLabel.text = [NSString stringWithFormat:@"00:00/%@",[self formatTime:self.model.music_duration]];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_model.create_time];
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setLocale:[NSLocale currentLocale]];
    [_formatter setDateFormat:@"yyyy.MM.dd hh:mm"];
    self.iconDetailLabel.text = [NSString stringWithFormat:@"%@ %ld成员",[_formatter stringFromDate:date],_model.group.member_num];
    
    [self.albumImageView sd_setImageWithURL:[NSURL URLWithString:_model.album_cover.raw] placeholderImage:[UIImage imageNamed:@"WilliamHuang"]];
 
    self.headLabel.text = [NSString stringWithFormat:@"%@-%@",_model.song_name,_model.artist];
    
    //Hides headView at first
    self.headView.alpha = 0;

      //__weak typeof(self) weakSelf = self;
    //Sets self.backImageView by using Gaussian Blur
//    SDWebImageManager *manager = [SDWebImageManager sharedManager];
//    
//
//    [manager downloadImageWithURL:[NSURL URLWithString:_model.album_cover.raw] options:0
//                         progress:nil
//                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//                            if (image) {
//                                
//                              self.backImageView.image = [self boxblurImage:image withBlurNumber:0.2];
//
//                            }
//                        }];
    
//Because if I use SDWebImage methods to download wed images and use gaussian blur method to motify them,the output image will be red,somehow.So I use a GCD method to download web image by myself.
    __block UIImage *img;
    dispatch_group_t group = dispatch_group_create();

    dispatch_group_async(group,dispatch_get_global_queue(0, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:_model.album_cover.raw]];
        
        UIImage *img1 = [UIImage imageWithData:data];
        
        img = [self boxblurImage:img1 withBlurNumber:0.2];
        
    });
 
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        self.backImageView.image = img;
        
    });

    
}
//Hides StatusBar
- (BOOL)prefersStatusBarHidden{
    
    return YES;
}


//Gaussian Blur Algorithm
-(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur {
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)musicPlayAction:(fullPicButton *)sender {
    
    self.songItem = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:_model.music_url]];
    self.audioPlayer = [[AVPlayer alloc] initWithPlayerItem:self.songItem];
    
    
    
    if (! isPlay) {
        
        
        [self.audioPlayer play];
        isPlay = YES;
       
        [self.musicPlayBtn setImage:[UIImage imageNamed:@"btn-musicplay-pause"]
                      forState:UIControlStateNormal];
        [self.musicPlayBtnHead setImage:[UIImage imageNamed:@"btn-musicplay-pause"]
                               forState:UIControlStateNormal];
        
        __weak typeof(self) weakSelf = self;
        __weak UIProgressView *tProgress = self.musicProgress;
        [_audioPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 10) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
            
            float current = time.value*1.0f/ time.timescale;
            
            [tProgress setProgress:current / weakSelf.model.music_duration animated:YES];

            weakSelf.musicDurationLabel.text = [[weakSelf formatTime:current] stringByAppendingString:[NSString stringWithFormat:@"/%@",[weakSelf formatTime:weakSelf.model.music_duration]]];
            
        }];

    }else if(isPlay)
    {
    
    [self.audioPlayer pause];
    
        [self.musicPlayBtn setImage:[UIImage imageNamed:@"btn-musicplay-play"]
                  forState:UIControlStateNormal];
        [self.musicPlayBtnHead setImage:[UIImage imageNamed:@"btn-musicplay-play"]
                               forState:UIControlStateNormal];
        isPlay = NO;
    }

}

- (IBAction)muiscPlayBtnHeadAction:(fullPicButton *)sender {
    self.songItem = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:_model.music_url]];
    self.audioPlayer = [[AVPlayer alloc] initWithPlayerItem:self.songItem];
    
    
    
    if (! isPlay) {
        
        
        [self.audioPlayer play];
        isPlay = YES;
        
        [self.musicPlayBtnHead setImage:[UIImage imageNamed:@"btn-musicplay-pause"]
                           forState:UIControlStateNormal];
        [self.musicPlayBtn setImage:[UIImage imageNamed:@"btn-musicplay-pause"]
                           forState:UIControlStateNormal];

        
        __weak typeof(self) weakSelf = self;
        __weak UIProgressView *tProgress = self.musicProgress;
        [_audioPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 10) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
            
            float current = time.value*1.0f/ time.timescale;
            
            [tProgress setProgress:current / weakSelf.model.music_duration animated:YES];
            
            weakSelf.musicDurationLabel.text = [[weakSelf formatTime:current] stringByAppendingString:[NSString stringWithFormat:@"/%ld",weakSelf.model.music_duration]];
            
        }];
        
    }else if(isPlay)
    {
        
        [self.audioPlayer pause];
        
        [self.musicPlayBtnHead setImage:[UIImage imageNamed:@"btn-musicplay-play"]
                           forState:UIControlStateNormal];
        [self.musicPlayBtn setImage:[UIImage imageNamed:@"btn-musicplay-play"]
                           forState:UIControlStateNormal];

        isPlay = NO;
    }

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

#pragma mark - backButton
- (IBAction)backBtnAction:(fullPicButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
}
#pragma mark - UIScrollView Delegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (self.scrollView.contentOffset.y > 200) {
        
        self.headView.alpha = 1;
        
    }else
    {
        
        [UIView animateWithDuration:2 animations:^{
            
            self.headView.alpha = 0;
            
        }];
        
        
    }
    
    
    
    
}

@end
