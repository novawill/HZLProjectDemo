//
//  CheckInModel.h
//  MOMO
//
//  Created by 黄梓伦 on 6/2/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "BaseModel.h"
@class Meows_list;
@interface CheckInModel : BaseModel<YYModel>

@property (nonatomic, strong) NSArray<Meows_list*> *meow_list;

@end

@interface Meow_list : NSObject<YYModel>

@property (nonatomic, copy) NSString *music_url;

@property (nonatomic, assign) NSInteger object_type;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger create_time;

@property (nonatomic, copy) NSString *meow_status;

@property (nonatomic, assign) NSInteger is_post_by_master;

@property (nonatomic, assign) NSInteger bang_count;

@property (nonatomic, assign) NSInteger kind;

@property (nonatomic, strong) Cate *category;

@property (nonatomic, strong) Group *group;

@property (nonatomic, assign) BOOL is_folded;

@property (nonatomic, copy) NSString *song_name;

@property (nonatomic, copy) NSString *lyrics;

@property (nonatomic, assign) NSInteger _id;

@property (nonatomic, assign) NSInteger is_filtered;

@property (nonatomic, strong) User *user;

@property (nonatomic, strong) Thumb *thumb;

@property (nonatomic, copy) NSString *artist;

@property (nonatomic, assign) NSInteger music_duration;

@property (nonatomic, assign) NSInteger meow_type;

@property (nonatomic, assign) NSInteger comment_count;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign) NSInteger image_count;

@end

