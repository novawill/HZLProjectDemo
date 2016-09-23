//
//  TrendViewController.m
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 9/21/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "TrendViewController.h"
#import "HZLScrollView.h"

#if 0 //因为HZLSegment.h文件中定义函数，会导致重定义符号的链接器错误，所以将定义写在这里，或者放在HZLSegment.m中
HZLFrame CGHZLFrameMake(CGFloat x, CGFloat y, CGFloat height)
{
    HZLFrame rect;
    rect.originX = x;
    rect.originY = y;
    rect.SizeHeight = height;
    return rect;
}
#endif
@interface TrendViewController ()

@property (nonatomic, strong) UITableView *trendTableView;
@property (nonatomic, strong) HZLScrollView *trendScrollView;
@end

@implementation TrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    [self createTopScrollView];
    [self creatTrendTableView];
    [self setUpContrains];
    
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
        make.bottom.equalTo(_trendTableView.mas_top);
        
    }];
    
    [_trendTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view);
        
    }];
    


    
    
    
}
- (void)creatTrendTableView
{
    
    _trendTableView = [[UITableView alloc] init];
    _trendTableView.backgroundColor = [UIColor blueColor];
    
   [self.view addSubview:_trendTableView];

    
    
    
    
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
