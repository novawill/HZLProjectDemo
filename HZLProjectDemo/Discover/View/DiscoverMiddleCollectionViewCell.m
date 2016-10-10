//
//  DiscoverMiddleCollectionViewCell.m
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 10/10/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "DiscoverMiddleCollectionViewCell.h"
@interface DiscoverMiddleCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UIImageView *authorImageView;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;




@end
@implementation DiscoverMiddleCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(NSDictionary *)model
{
    
    _model = model;
    
    if (!_model[@"meow"]) {
        
        _descLabel.text = _model[@"campaign"][@"description"];
        _titleName.text = _model[@"campaign"][@"title"];
        NSString *backImageUrlStr = _model[@"campaign"][@"thumb"][@"raw"];
        [_backImageView sd_setImageWithURL:[NSURL URLWithString:backImageUrlStr] placeholderImage:nil];
        
        
    }else
    {
        NSString *backImageUrl = _model[@"meow"][@"ref_campaign"][@"logo_url"];
        [_backImageView sd_setImageWithURL:[NSURL URLWithString:backImageUrl] placeholderImage:nil];
        _titleName.text = _model[@"meow"][@"ref_campaign"][@"title"];
        _descLabel.text = _model[@"meow"][@"ref_campaign"][@"description"];
    }
    
   
    
    
    
}

@end
