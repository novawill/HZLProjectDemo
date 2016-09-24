//
//  BaseViewController.m
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 9/21/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "BaseViewController.h"
#import "AlbumCell.h"
@interface BaseViewController ()<UITableViewDelegate,UITableViewDataSource>



@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIView *backView;
@end
 NSString * const baseCellIdentifier = @"baseCell";
@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];
    [self makeContrains];
    self.view.backgroundColor = [UIColor blueColor];

   

}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];

    
}



- (void)createTableView
{
    
   _baseTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
   _baseTableView.backgroundColor = [UIColor orangeColor];
    [self.baseTableView registerNib:[UINib nibWithNibName:@"AlbumCell" bundle:nil]
              forCellReuseIdentifier:baseCellIdentifier];
    _baseTableView.delegate = self;
    _baseTableView.dataSource = self;
    _baseTableView.rowHeight = CGRectGetHeight(self.view.bounds);
    
    
    
    [self.view addSubview:_baseTableView];
    
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
    
    
    return 2;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:baseCellIdentifier];
    
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
