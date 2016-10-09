//
//  DiscoverViewHeader.h
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 10/6/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverHeaderScroll.h"
@interface DiscoverViewHeader : UICollectionViewCell

+(instancetype)shareView;
@property (weak, nonatomic) IBOutlet DiscoverHeaderScroll *headerScroll;

@end
