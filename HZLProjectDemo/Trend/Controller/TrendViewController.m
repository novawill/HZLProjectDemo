//
//  TrendViewController.m
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 9/21/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "TrendViewController.h"
#import "HZLSegment.h"
@interface TrendViewController ()

@end

@implementation TrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   
    HZLSegment *seg = [[HZLSegment alloc] initWithFrame:CGRectMake(20, 20, 200, 64) items:@[@"HZL1",@"HZL2"]];
    
    seg.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:seg];
    
   
    
    
    
    
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)createTopScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 64)];
    
    
    
    
    
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
