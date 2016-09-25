//
//  BaseViewController.m
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 9/21/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "AlbumViewController.h"
#import "AlbumCell.h"
#import "BaseModel.h"
#import "HZLNetManager.h"

@interface AlbumViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) NSInteger start;

@property (nonatomic, strong) UITableView *baseTableView;

@property (nonatomic, strong) AFHTTPSessionManager *httpManager;

@property (nonatomic, strong) NSMutableArray *albumDataArray;

@property (nonatomic, strong) MJRefreshGifHeader *gifHeader;

@property (nonatomic, strong) NSMutableArray *refreshImages;

@property (nonatomic, strong) NSMutableArray *normalImages;


@end
 NSString * const baseCellIdentifier = @"baseCell";
@implementation AlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self createTableView];
    [self createRefreshHeader];
    [self makeContrains];
    _start = 0;
   
    self.view.backgroundColor = [UIColor clearColor];

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
- (NSMutableArray *)albumDataArray
{
    
    if (!_albumDataArray) {
        
        _albumDataArray = [[NSMutableArray alloc] init];
        
    }
    
    return _albumDataArray;
    
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


- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];

   
}
- (void)createRefreshHeader
{
    
    
    
    __weak typeof(self) weakSelf = self;
     _gifHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        [weakSelf requestWithStart:weakSelf.start];
        weakSelf.start += 10;
        weakSelf.baseTableView.mj_footer.hidden = YES;
        
    }];
    [_gifHeader setImages:self.refreshImages forState:MJRefreshStateRefreshing];
    [_gifHeader setImages:self.normalImages forState:MJRefreshStateIdle];
    [_gifHeader setImages:self.normalImages forState:MJRefreshStatePulling];
    _gifHeader.lastUpdatedTimeLabel.hidden = YES;
    _gifHeader.stateLabel.hidden = YES;
    self.baseTableView.mj_header = _gifHeader;
    self.baseTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        [weakSelf requestWithStart:weakSelf.start];
        weakSelf.start += 10;
        weakSelf.baseTableView.mj_header.hidden = YES;
        
    }];

    [self.baseTableView.mj_header beginRefreshing];
    
}
- (void)createTableView
{
    
   _baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) style:UITableViewStylePlain];
   _baseTableView.backgroundColor = [UIColor clearColor];
    [self.baseTableView registerNib:[UINib nibWithNibName:@"AlbumCell" bundle:nil]
              forCellReuseIdentifier:baseCellIdentifier];
    _baseTableView.delegate = self;
    _baseTableView.dataSource = self;
    _baseTableView.rowHeight = CGRectGetHeight(self.view.bounds);
    
    
    
    
    [self.view addSubview:_baseTableView];
    
}


- (void)requestWithStart:(NSInteger)start
{
    NSString *url;
    
    if (start == 0) {
        
        url = albumAPI;
    }else
    {
        url = [albumAPI stringByAppendingString:[NSString stringWithFormat:@"&start=%ld",start]];
    }
  
    
    [[HZLNetManager defaultManager] requestDataByGetWithURL:url success:^(id response) {
        
       BaseModel *model = [BaseModel yy_modelWithJSON:response];
        
        if ([self.baseTableView.mj_footer isHidden]) {
            
            [self.albumDataArray removeAllObjects];
            
        }
        
        [self.albumDataArray addObjectsFromArray:model.meows];
        
        __weak typeof(self) weakSelf = self;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf.baseTableView reloadData];
            [weakSelf.baseTableView.mj_header endRefreshing];
            [weakSelf.baseTableView.mj_footer endRefreshing];
            weakSelf.baseTableView.mj_header.hidden = NO;
            weakSelf.baseTableView.mj_footer.hidden= NO;
            
            if (model.is_last_page) {
                
                [weakSelf.baseTableView.mj_footer endRefreshingWithNoMoreData];
            
                [KVNProgress showWithStatus:@"没有更多数据了，亲~"];
            }
            
        });
        
    } failure:^(NSError *error) {
        
        [KVNProgress showErrorWithStatus:[NSString stringWithFormat:@"%@",error.localizedDescription]];
        
        
    }];
    
}


- (void)makeContrains
{
    self.baseTableView.translatesAutoresizingMaskIntoConstraints = NO;
    __weak typeof(self) weakSelf = self;
    [_baseTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf.view);
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return self.albumDataArray.count;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:baseCellIdentifier];
    
    Meows *model = self.albumDataArray[indexPath.row];
    
    cell.model = model;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSLog(@"点击了~");
    
    
    
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
