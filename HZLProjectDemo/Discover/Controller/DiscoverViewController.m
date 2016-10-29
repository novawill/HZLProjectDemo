//
//  DiscoverViewController.m
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 9/21/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "DiscoverViewController.h"
#import "DiscoverViewHeader.h"
#import "DiscoveryModel.h"
#import "HZLNetManager.h"
#import "DiscoveryFlowLayout.h"
#import "DisccoverCollectionViewCellOne.h"
#import "DiscoverMiddleCollectionViewCell.h"
#import "HeaderCollectionViewCell.h"
#import "MusicViewController.h"
#import "AlbumViewController.h"
#import "CheckInViewController.h"
@interface DiscoverViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic, strong) NSMutableArray *headerArr;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) MJRefreshGifHeader *gifHeader;
@property (nonatomic, copy) NSString *start;
@property (nonatomic, strong) NSMutableArray *refreshImages;

@property (nonatomic, strong) NSMutableArray *normalImages;
@property (nonatomic, strong) NSMutableArray *middleDataArray;

@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation DiscoverViewController
{
    DiscoveryModel *_model;
    DiscoverViewHeader *_headerView;
    
}
- (NSMutableArray *)middleDataArray
{
    if (!_middleDataArray) {
        
        
        _middleDataArray = [[NSMutableArray alloc] init];
        
    }
    return _middleDataArray;
    
    
    
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
- (NSMutableArray *)dataArray
{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (NSMutableArray *)headerArr
{
    if (!_headerArr) {
        
        
        _headerArr = [[NSMutableArray alloc] init];
    }
    return _headerArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor clearColor];
    _start = @"";
    self.automaticallyAdjustsScrollViewInsets = NO;
   
    
    [self createUI];
    [self createRefreshHeader];
    
    
}
- (void)createRefreshHeader
{
    
    __weak typeof(self) weakSelf = self;
    _gifHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
    
        weakSelf.start = @"";
        weakSelf.collectionView.mj_footer.hidden = YES;

        [weakSelf requestWithStart:weakSelf.start];
    
        
    }];
    [_gifHeader setImages:self.refreshImages forState:MJRefreshStateRefreshing];
    [_gifHeader setImages:self.normalImages forState:MJRefreshStateIdle];
    [_gifHeader setImages:self.normalImages forState:MJRefreshStatePulling];
    _gifHeader.lastUpdatedTimeLabel.hidden = YES;
    _gifHeader.stateLabel.hidden = YES;
    self.collectionView.mj_header = _gifHeader;
    self.collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        [weakSelf requestWithStart:weakSelf.start];
       
        weakSelf.collectionView.mj_header.hidden = YES;
        
    }];
    
    [self.collectionView.mj_header beginRefreshing];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    
    return 10;
    
}
- (void)musicBtnClick
{
    MusicViewController *musicVC = [[MusicViewController alloc] init];
    
    [self.navigationController pushViewController:musicVC animated:YES];
    
}
- (void)albumClick
{
    AlbumViewController *albumVC = [[AlbumViewController alloc] init];
    
    [self.navigationController pushViewController:albumVC animated:YES];
    
    
    
    
}
- (void)dayNoteClick
{
    
    CheckInViewController *checkInVC = [[CheckInViewController alloc] init];
    
    [self.navigationController pushViewController:checkInVC animated:YES];
    
    
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    BOOL a = [self.collectionView.mj_footer isHidden];
    if ((indexPath.section == 0  || [self.collectionView.mj_footer isHidden]
         )&& indexPath.item == 0 ) {
        
        
        DiscoverViewHeader *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
        
        cell.headerScroll.imageArrays = _headerArr[0];
       
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(musicBtnClick)];
        UITapGestureRecognizer *albumTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(albumClick)];
        UITapGestureRecognizer *dayNoteTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dayNoteClick)];
        [cell.dayNoteBtn addGestureRecognizer:dayNoteTap];
        
        [cell.muiscBtn addGestureRecognizer:tap];
        [cell.albumBtn addGestureRecognizer:albumTap];
        [cell bringSubviewToFront: cell.headerScroll];
        cell.userInteractionEnabled = YES;
        [cell bringSubviewToFront:cell.muiscView];
        [cell bringSubviewToFront:cell.posterView];
        [cell bringSubviewToFront:cell.muiscBtn];
        [cell bringSubviewToFront:cell.albumBtn];
        [cell bringSubviewToFront:cell.videoBtn];
        [cell bringSubviewToFront:cell.dayNoteBtn];
        [cell bringSubviewToFront:cell.posterBtn];
        return cell;
    }else
    {
        
        if (indexPath.item < 5 && indexPath.item != 0) {
            
            DisccoverCollectionViewCellOne *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell2" forIndexPath:indexPath];
            NSLog(@"%ld %ld",(long)indexPath.item,(long)indexPath.section);
            DiscoveryEntity_List *model = _dataArray[indexPath.section][indexPath.item - 1];
            
            cell.model = model;
            
            return cell;
        }
        if ( indexPath.item < 10 && indexPath.item > 5 ) {
            
            DisccoverCollectionViewCellOne *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell2" forIndexPath:indexPath];
            NSLog(@"%ld %ld",(long)indexPath.item,(long)indexPath.section);
            DiscoveryEntity_List *model = _dataArray[indexPath.section][indexPath.item - 2];
            
            cell.model = model;
            
            return cell;

        }
    }
    if (indexPath.item == 5) {
    
        DiscoverMiddleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"middleCell" forIndexPath:indexPath];
        
        cell.model = _middleDataArray[indexPath.section];
        
        return cell;
    }
    
    
    
    HeaderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"headerCell" forIndexPath:indexPath];
    
    return cell;
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (!_dataArray) {
        return 1;
    }
    return _dataArray.count;
    
}
- (void)createUI
{
    
    DiscoveryFlowLayout *flowLayout = [[DiscoveryFlowLayout alloc] init];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 630) collectionViewLayout:flowLayout];
    
    _collectionView.backgroundColor = [UIColor clearColor];
   [self.view addSubview:_collectionView];
    
    
    _collectionView.delegate = self;
    
    _collectionView.dataSource = self;
    
    [_collectionView registerClass:[DiscoverViewHeader class] forCellWithReuseIdentifier:@"CELL"];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CELL2"];
    [_collectionView registerNib:[UINib nibWithNibName:@"DiscoverMiddleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"middleCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"HeaderCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"headerCell"];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"DisccoverCollectionViewCellOne" bundle:nil]forCellWithReuseIdentifier:@"Cell2"];
    
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];

    
    
    
    
    
}
- (void)requestWithStart:(NSString *)start
{
    NSString *urlStr;
    if (![start isEqualToString:@""]) {
        
        urlStr = [NSString stringWithFormat:@"%@start=%@",discoveryAPI,start];
        
    }else
    {
        urlStr = discoveryAPI;
    }
    
    [[HZLNetManager defaultManager] requestDataByGetWithURL:urlStr success:^(id response) {
        
        _model = [DiscoveryModel yy_modelWithJSON:response];
        
        if ([self.collectionView.mj_footer isHidden]) {
            
            [self.dataArray removeAllObjects];
            [self.middleDataArray removeAllObjects];
            
        }
        self.start = _model.start;
        NSMutableArray *tempDataArr = [[NSMutableArray alloc] init];
        NSArray *array = [NSArray arrayWithArray:_model.top_banner.entity_list];
        
        NSArray *array2 = [NSArray arrayWithArray:_model.mod_list];
        
        DiscoveryMod_List *model1 = array2[0];
        
        DiscoveryMod_List *model2 = array2[2];
        
        DiscoveryMod_List *middleModel = array2[1];
        
        NSDictionary *middleDic = middleModel.entity_list[0];
        
        [self.middleDataArray addObject:middleDic];
        
        
        for (int i = 0 ; i < 4; i++) {
            
           NSDictionary *dic  = model1.entity_list[i];
            [tempDataArr addObject:dic];
        }
        for (int i = 0; i < 4; i++) {
             NSDictionary *dic  = model2.entity_list[i];
            [tempDataArr addObject:dic];
        }
        [self.dataArray addObject:tempDataArr];
              
        
    
        __weak typeof(self) weakSelf = self;
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
           
            NSMutableArray *array2 = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in array) {
                
                
                [array2 addObject:dic[@"banner_img_url"]];
               
            }
             _headerView.headerScroll.imageArrays = array2;
           
            [weakSelf.headerArr addObject:array2];
            [_collectionView reloadData];
            [weakSelf.collectionView.mj_header endRefreshing];
            [weakSelf.collectionView.mj_footer endRefreshing];
            weakSelf.collectionView.mj_header.hidden = NO;
            weakSelf.collectionView.mj_footer.hidden= NO;
            if (_model.is_last_page) {
                
                [weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];
                
           
                    
                    [KVNProgress showSuccessWithStatus: @"没有更多数据了"];
            }

            
        });
        
    } failure:^(NSError *error) {
        
    }];
    
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
