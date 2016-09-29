//
//  RootViewController.h
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 9/29/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  <AVFoundation/AVFoundation.h>
@class MusicCell;
@interface RootViewController : UIViewController
@property (nonatomic, weak)  MusicCell *currrentCell;
@property (nonatomic, weak) MusicCell *onClickedCell;
@property (nonatomic, copy) NSString  *musicUrl;
@property (nonatomic, strong) id observer;
@property (nonatomic, strong) AVPlayer *musicPlayer;
@property (nonatomic, assign) BOOL isPlay;
- (void)playerMusicIsPlay:(BOOL)isPlay musicUrl:(NSString *)url;
- (void)updateProgressAndTime;
@end
