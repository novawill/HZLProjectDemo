//
//  AlbumCell.h
//  MOMO
//
//  Created by 黄梓伦 on 5/31/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "fullPicButton.h"
//#import "AlbumModel.h"
@interface AlbumCell : UITableViewCell
//Properties
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *iconLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picImage;
@property (weak, nonatomic) IBOutlet UILabel *picNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentNumberLabel;
//@property (nonatomic, strong) void (^transModel)(Meows *model);


//Model
//@property (nonatomic, strong) Meows *model;

//Actions
- (IBAction)shareAction:(fullPicButton *)sender;
- (IBAction)likeAction:(fullPicButton *)sender;
- (IBAction)thumbAction:(fullPicButton *)sender;
- (IBAction)commentAction:(fullPicButton *)sender;


//Sets models
//- (void)setModel:(Meows *)model;
@end
