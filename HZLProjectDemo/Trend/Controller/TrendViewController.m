//
//  TrendViewController.m
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 9/21/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "TrendViewController.h"
#import "HZLScrollView.h"
#import "HZLScrollView2.h"
#import "AlbumViewController.h"
#import "MusicViewController.h"
@interface TrendViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) HZLScrollView2 *trendTableViews;
@property (nonatomic, strong) HZLScrollView *trendScrollView;
@end

@implementation TrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
           
        [self createTopScrollView];
        [self creatTrendTableViews];
        [self setUpContrains];
    /**
     *  @author 黄梓伦, 16-09-24 00:09:03
     *
     *  因为要异步执行约束，约束还未完成，就执行下面的set方法，因而_trendScrollView的bounds未定，所以下面的方法使得_trendScrollView里的segment的布局会产生偏差。解决的方法是不能再这里执行，可以放在scollView的协议方法中，因为那时约束已经建好。2.或者不要使用约束。3.或者在HZLScrollView实现中将HZLSegment的高固定，在HZLScrollView的setSelectedIndex方法中将HZLScrollView的宽度替代为一固定值。4.将该方法放在viewdidAppera中
     */
#if 0
    _trendScrollView.selectedIndex = 1;
#endif
    
        [_trendScrollView addTarget:self action:@selector(changeView)];
       self.navigationController.navigationBarHidden = YES;
    
}

- (void)createTopScrollView
{
     NSArray *titleArray = @[@"推荐 Explore",@"关注 Following",@"视频 Video",@"音乐 Music",@"画册 Gallery",@"往期早茶"];
    _trendScrollView = [[HZLScrollView alloc] initWithFrame:CGRectMake(0, 0, 0, 64) items:titleArray];
    _trendScrollView.backgroundColor = [UIColor blackColor];
    
   
    [self.view addSubview:_trendScrollView];
   
    
    
}
- (void)setUpContrains
{
     __weak typeof(self) weakSelf = self;
    [_trendScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.view);
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.height.equalTo(@64);
        make.bottom.equalTo(_trendTableViews.mas_top);
        
    }];
    
    [_trendTableViews mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view);
        
    }];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}
- (void)changeView
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        _trendTableViews.selectedIndex = _trendScrollView.selectedIndex;
        
    });
}
- (void)creatTrendTableViews
{
    
    AlbumViewController *gallery = [[AlbumViewController alloc] init];
    /**
     *  @author 黄梓伦, 16-09-25 04:09:31
     *
     *  必须将vc作为self的子视图控制器，否则只是将一份初始化的vc.view加到_trendTableView上，而此时这个加进去的vc.view的控制器就变成了TrendViewController.而无法实现BaseViewController中的viewdidload方法。
     */
    [self addChildViewController:gallery];
     AlbumViewController *vc = [[AlbumViewController alloc] init];
    [self addChildViewController:vc];
    
    UIView *exploreView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    exploreView.backgroundColor = [UIColor redColor];
    
    UIView *followingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    followingView.backgroundColor = [UIColor blueColor];
    
    UIView *videoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    videoView.backgroundColor = [UIColor orangeColor];
    
    MusicViewController *music = [[MusicViewController alloc] init];
    [self addChildViewController:music];
    
    UIView *moringTeaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    moringTeaView.backgroundColor = [UIColor greenColor];
    
    NSArray *array = @[vc.view,followingView,videoView,music.view,gallery.view,moringTeaView];
    
    
   _trendTableViews = [[HZLScrollView2 alloc] initWithFrame:CGRectMake(0, 64, 100, 50) items:array];
    _trendTableViews.delegate = self;
    _trendTableViews.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_trendTableViews];
   
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat origin = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    if (origin < 0) {
        
        origin = 0;
    }
    CGFloat floorValue = floor(origin);
    
        CGFloat tempValue = origin - floorValue;
    
        CGFloat index;
    
        if (tempValue > 0.5) {
    
            index = floorValue + 1;
        }else
        {
            index = floorValue;
        }
    
    CGFloat scrollViewOffset = scrollView.contentOffset.x;
    CGFloat ratio = scrollViewOffset / scrollView.contentSize.width;
    CGFloat sliderOffset = _trendScrollView.contentSize.width * ratio;
    [_trendScrollView changeSelectedIndex:index sliderOffset:sliderOffset];

    
}

 -(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat origin = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    if (origin < 0) {
        
        origin = 0;
    }
    CGFloat floorValue = floor(origin);
    _trendScrollView.selectedIndex2 = floorValue;
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
   


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
