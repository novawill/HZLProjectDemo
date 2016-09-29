//
//  AlbumDetailCell.m
//  MOMO
//
//  Created by 黄梓伦 on 6/14/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "AlbumDetailCell.h"
@interface AlbumDetailCell()


@property (weak, nonatomic) IBOutlet UIImageView *backImageView;



@end
@implementation AlbumDetailCell

- (void)awakeFromNib {

    [self bringSubviewToFront:self.imageNumberLabel];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(Meows *)model
{
    
    
    
}
- (void)setImageModel:(AlbumImages *)imageModel
{
    
    _imageModel = imageModel;
    
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:_imageModel.raw] placeholderImage:[UIImage imageNamed:@"WilliamHuang"]];

}

@end
