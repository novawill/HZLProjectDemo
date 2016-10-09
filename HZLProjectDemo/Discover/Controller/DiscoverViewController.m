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
@interface DiscoverViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic, strong) NSMutableArray *headerArr;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation DiscoverViewController
{
    DiscoveryModel *_model;
    DiscoverViewHeader *_headerView;
    UICollectionView *_collectionView;
    
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
   
    self.view.backgroundColor = [UIColor orangeColor];
   
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self requestHeader];
    
    [self createUI];
    
    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    
    return 10;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        DiscoverViewHeader *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
        
        cell.headerScroll.imageArrays = _headerArr[0];
        
        [cell bringSubviewToFront: cell.headerScroll];
        cell.userInteractionEnabled = YES;
        return cell;
    }else
    {
        if (indexPath.row < 5 && indexPath.row != 0) {
            
            DisccoverCollectionViewCellOne *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell2" forIndexPath:indexPath];
            NSLog(@"%ld %ld",(long)indexPath.row,(long)indexPath.section);
            DiscoveryEntity_List *model = _dataArray[indexPath.section][indexPath.row - 1];
            
            cell.model = model;
            
            return cell;
        }
        if ( indexPath.row < 10 && indexPath.row > 5 ) {
            
            DisccoverCollectionViewCellOne *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell2" forIndexPath:indexPath];
            NSLog(@"%ld %ld",(long)indexPath.row,(long)indexPath.section);
            DiscoveryEntity_List *model = _dataArray[indexPath.section][indexPath.row - 2];
            
            cell.model = model;
            
            return cell;

            
            
        }
    }
   
    
    
    
     UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL2" forIndexPath:indexPath];
    
    
    
    cell.backgroundColor = [UIColor colorWithRed:(arc4random() % 256) / 255.0f green:(arc4random() % 256) / 255.0f blue:(arc4random() % 256) / 255.0f alpha:1];
    
    return cell;
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
    
}
- (void)createUI
{
    
    DiscoveryFlowLayout *flowLayout = [[DiscoveryFlowLayout alloc] init];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 630) collectionViewLayout:flowLayout];
    
       
   [self.view addSubview:_collectionView];
    
        
    _collectionView.delegate = self;
    
    _collectionView.dataSource = self;
    
    [_collectionView registerClass:[DiscoverViewHeader class] forCellWithReuseIdentifier:@"CELL"];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CELL2"];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"DisccoverCollectionViewCellOne" bundle:nil]forCellWithReuseIdentifier:@"Cell2"];
    
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];

    
    
    
    
    
}
- (void)requestHeader
{
    [[HZLNetManager defaultManager] requestDataByGetWithURL:discoveryAPI success:^(id response) {
        
        _model = [DiscoveryModel yy_modelWithJSON:response];
        
        NSMutableArray *tempDataArr = [[NSMutableArray alloc] init];
        NSArray *array = [NSArray arrayWithArray:_model.top_banner.entity_list];
        
        NSArray *array2 = [NSArray arrayWithArray:_model.mod_list];
        
        DiscoveryMod_List *model1 = array2[0];
        
        DiscoveryMod_List *model2 = array2[2];
        
        for (int i = 0 ; i < 4; i++) {
            
           NSDictionary *dic  = model1.entity_list[i];
            [tempDataArr addObject:dic];
        }
        for (int i = 0; i < 4; i++) {
             NSDictionary *dic  = model2.entity_list[i];
            [tempDataArr addObject:dic];
        }
        [self.dataArray addObject:tempDataArr];
        
        DiscoveryEntity_List *enlisModel2 = [DiscoveryEntity_List yy_modelWithJSON:model2.entity_list];
        
        NSArray *cellArray = [NSArray arrayWithArray:_model.mod_list];
        
        
      
        
        

        __weak typeof(self) weakSelf = self;
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
           
            NSMutableArray *array2 = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in array) {
                
                
                [array2 addObject:dic[@"banner_img_url"]];
               
            }
             _headerView.headerScroll.imageArrays = array2;
           
            [weakSelf.headerArr addObject:array2];
            [_collectionView reloadData];

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
