//
//  DisccoverCollectionViewCellOne.m
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 10/9/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "DisccoverCollectionViewCellOne.h"
@interface DisccoverCollectionViewCellOne()

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *leftTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftCateLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UILabel *peopleNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightCateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

@end
@implementation DisccoverCollectionViewCellOne

- (void)awakeFromNib {
   
}

- (void)setModel:(NSDictionary *)model
{
    _model = model;
    
   // DiscoveryGroup *groupmodel = [DiscoveryGroup yy_modelWithDictionary:]];
    
    NSString *imageStr = _model[@"group"][@"thumb"][@"raw"];
    
    [_backImageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:nil];
    
    
    
}

@end
