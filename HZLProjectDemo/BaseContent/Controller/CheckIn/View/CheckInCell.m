//
//  CheckInCell.m
//  MOMO
//
//  Created by 黄梓伦 on 6/2/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "CheckInCell.h"

@implementation CheckInCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)shareButton:(fullPicButton *)sender {
}

- (IBAction)likeButton:(fullPicButton *)sender {
}

- (IBAction)thumbButton:(fullPicButton *)sender {
}

- (IBAction)commentButton:(fullPicButton *)sender {
}

- (void)setModel:(Meow_list *)model
{
    
    _model = model;
    
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:_model.user.avatar_url] placeholderImage:[UIImage imageNamed:@"alert_error_icon"]];
    
    _iconLabel.text = _model.user.name;
    
    _iconDesc.text = _model.user.self_description;
    
    [_checkInImage sd_setImageWithURL:[NSURL URLWithString:_model.thumb.raw] placeholderImage:[UIImage imageNamed:@"WilliamHuang"]];
    
    _thumbNumber.text = [NSString stringWithFormat:@"%ld",_model.bang_count];
    
    _commentNumber.text = [NSString stringWithFormat:@"%ld",_model.comment_count];
    
    NSDate *date = [NSDate date];
    
    CGFloat secNow = date.timeIntervalSince1970;
    
    NSInteger timeInterval = (NSInteger)secNow - _model.create_time;
    
    
    if (timeInterval / 60 < 60) {
        
        _time.text = [NSString stringWithFormat:@"%ld分钟前",timeInterval / 60];

    }else
    {
        _time.text = [NSString stringWithFormat:@"%ld小时前",timeInterval / 3600];
    }
}
    

@end
