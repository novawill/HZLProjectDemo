//
//  BaseModel.h
//  MOMO
//
//  Created by 黄梓伦 on 5/31/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AlbumImages,Meows,Group,g_m_thumb,Master_Info,g_m_coordinate,Thumb,Album_Cover,Cate,User,u_Coordinate;
@interface BaseModel : NSObject<YYModel>

@property (nonatomic, assign) BOOL is_last_page;

@property (nonatomic, strong) NSArray<Meows *> *meows;

@property (nonatomic, assign) NSInteger start;

@end

@interface Meows : NSObject<YYModel>

@property (nonatomic, strong) Album_Cover *album_cover;

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

@property (nonatomic, strong) NSArray<AlbumImages *> *images;

@property (nonatomic, assign) NSInteger image_count;

@end

@interface AlbumImages : NSObject<YYModel>

@property (nonatomic, copy) NSString *raw;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, assign) NSInteger height;

@end


@interface Group : NSObject<YYModel>

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *category;

@property (nonatomic, assign) NSInteger _id;

@property (nonatomic, copy) NSString *logo_url;

@property (nonatomic, assign) NSInteger campaign_num;

@property (nonatomic, assign) NSInteger discuss_content_num;

@property (nonatomic, strong) Master_Info *master_info;

@property (nonatomic, assign) NSInteger cert_kind_id;

@property (nonatomic, assign) NSInteger publisher_type;

@property (nonatomic, copy) NSString *slogan;

@property (nonatomic, strong) NSArray *admin_data;

@property (nonatomic, strong) g_m_thumb *thumb;

@property (nonatomic, assign) NSInteger member_num;

@property (nonatomic, strong) NSArray *admin_list;

@property (nonatomic, assign) NSInteger topic_content_num;

@property (nonatomic, assign) NSInteger kind;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *status;

@end

@interface g_m_thumb : NSObject

@property (nonatomic, copy) NSString *raw;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, assign) NSInteger height;

@end

@interface Master_Info : NSObject<YYModel>

@property (nonatomic, assign) NSInteger gender;

@property (nonatomic, assign) NSInteger horoscope;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) BOOL is_anonymous;

@property (nonatomic, copy) NSString *self_description;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *avatar_url;

@property (nonatomic, strong) g_m_coordinate *coordinate;

@end

@interface g_m_coordinate : NSObject

@property (nonatomic, assign) NSInteger longitude;

@property (nonatomic, copy) NSString *area_name;

@property (nonatomic, assign) NSInteger latitude;

@end

@interface Thumb : NSObject

@property (nonatomic, copy) NSString *raw;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, assign) NSInteger height;

@end

@interface Album_Cover : NSObject

@property (nonatomic, copy) NSString *raw;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, assign) NSInteger height;

@end

@interface Cate : NSObject<YYModel>

@property (nonatomic, assign) NSInteger _id;

@property (nonatomic, copy) NSString *name;

@end

@interface User : NSObject<YYModel>

@property (nonatomic, assign) NSInteger gender;

@property (nonatomic, assign) NSInteger horoscope;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) BOOL is_anonymous;

@property (nonatomic, copy) NSString *self_description;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *avatar_url;

@property (nonatomic, strong) u_Coordinate *coordinate;

@end

@interface u_Coordinate : NSObject

@property (nonatomic, assign) NSInteger longitude;

@property (nonatomic, copy) NSString *area_name;

@property (nonatomic, assign) NSInteger latitude;

@end




