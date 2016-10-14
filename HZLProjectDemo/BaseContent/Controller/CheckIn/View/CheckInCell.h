//
//  CheckInCell.h
//  MOMO
//
//  Created by 黄梓伦 on 6/2/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "fullPicButton.h"
#import "CheckInModel.h"
@interface CheckInCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *iconLabel;
@property (weak, nonatomic) IBOutlet UILabel *iconDesc;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *checkInImage;
@property (weak, nonatomic) IBOutlet UILabel *thumbNumber;
@property (weak, nonatomic) IBOutlet UILabel *commentNumber;

//Model
@property (nonatomic, strong) Meow_list *model;
//Actions
- (IBAction)shareButton:(fullPicButton *)sender;
- (IBAction)likeButton:(fullPicButton *)sender;
- (IBAction)thumbButton:(fullPicButton *)sender;
- (IBAction)commentButton:(fullPicButton *)sender;



@end
