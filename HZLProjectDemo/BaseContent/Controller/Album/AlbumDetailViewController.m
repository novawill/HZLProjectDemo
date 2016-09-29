//
//  AlbumDetailViewController.m
//  MOMO
//
//  Created by 黄梓伦 on 6/13/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "AlbumDetailViewController.h"
#import "AlbumDetailCell.h"
#import "headerView.h"
@interface AlbumDetailViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *albumTableView;


@end


NSString *const AlbumDetailCellIdentifier = @"AlCell";
@implementation AlbumDetailViewController
{
    UILabel *_titleLabel;
    UILabel *_authorLabel;
    UILabel *_descLabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self prefersStatusBarHidden];
    
   
    
    headerView *header = [headerView iniWith];
    
    header.height = 200;

    
    header.titleLabel.text = _model.title;
    
    header.descLabel.text = _model.desc;

    header.authorLabel.text = _model.user.name;

    self.albumTableView.estimatedRowHeight = 300;
    
    self.albumTableView.tableHeaderView = header;
    
    [self.albumTableView registerNib:[UINib nibWithNibName:@"AlbumDetailCell" bundle:nil] forCellReuseIdentifier:AlbumDetailCellIdentifier];
    
    
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:_model.group.logo_url] placeholderImage:[UIImage imageNamed:@"WilliamHuang"]];
    
    self.groupNameLabel.text = _model.group.name;
    

    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_model.create_time];
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setLocale:[NSLocale currentLocale]];
    [_formatter setDateFormat:@"yyyy.MM.dd hh:mm"];
    self.authorDescLabel.text = [NSString stringWithFormat:@"%@ %ld成员",[_formatter stringFromDate:date],_model.group.member_num];
    
    NSLog(@"%@",self.model);
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.model.images.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AlbumDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:AlbumDetailCellIdentifier];
    
    cell.imageModel = _model.images[indexPath.row];
    
    cell.imageNumberLabel.text = [NSString stringWithFormat:@"%ld/%ld",indexPath.row + 1,_model.images.count];
    
    return cell;
    
}


//Hides StatusBar
- (BOOL)prefersStatusBarHidden{
    
    return YES;
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

- (IBAction)backAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
