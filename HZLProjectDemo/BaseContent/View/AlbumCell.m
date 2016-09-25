//
//  AlbumCell.m
//  MOMO
//
//  Created by 黄梓伦 on 5/31/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "AlbumCell.h"

@implementation AlbumCell





- (IBAction)shareAction:(fullPicButton *)sender {
}

- (IBAction)likeAction:(fullPicButton *)sender {
}

- (IBAction)thumbAction:(fullPicButton *)sender {
}

- (IBAction)commentAction:(fullPicButton *)sender {
}

- (void)setModel:(Meows *)model
{
    _model = model;
    
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:_model.group.logo_url]
                      placeholderImage:[UIImage imageNamed:@"btn-rec-refresh-active"]];
    
    self.iconLabel.text = _model.group.name;
    
    if (_model.category.name != nil) {
        
        self.typeLabel.text = [NSString stringWithFormat:@"#%@",_model.category.name];
        
    }else
    {
        self.typeLabel.text = @"#其他";
    }
    
   [self.backgroundImage sd_setImageWithURL:[NSURL URLWithString:_model.images[0].raw]
                           placeholderImage:[UIImage imageNamed:@"WilliamHuang"]];
    
   self.picNumberLabel.text = [NSString stringWithFormat:@"%ld张图片",_model.image_count];
    
    self.descLabel.text = _model.desc;
    
    self.titleLabel.text = _model.title;
    
    self.likeNumberLabel.text = [NSString stringWithFormat:@"%ld",_model.bang_count];
    
    self.commentNumberLabel.text = [NSString stringWithFormat:@"%ld",_model.comment_count];
    
}
@end
