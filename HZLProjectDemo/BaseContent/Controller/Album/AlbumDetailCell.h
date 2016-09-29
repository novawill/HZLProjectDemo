//
//  AlbumDetailCell.h
//  MOMO
//
//  Created by 黄梓伦 on 6/14/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"
@interface AlbumDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *imageNumberLabel;

@property (nonatomic, strong) Meows *model;

@property (nonatomic, strong) AlbumImages *imageModel;

@end
