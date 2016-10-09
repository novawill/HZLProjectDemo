//
//  DiscoveryModel.h
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 10/7/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DiscoveryTop_Banner,DiscoveryEntity_List,DiscoveryCollection,DiscoveryThumb,DiscoveryLogo_Url_Thumb,DiscoveryBanner_Img_Url_Thumb,DiscoveryMod_List,DiscoveryGroup,DiscoveryMaster_Info,DiscoveryAvatar_Url_Thumb,DiscoveryCoordinate,DiscoveryCert,DiscoveryThumb,DiscoveryLogo_Url_Thumb,DiscoveryMeow;

@interface DiscoveryModel : NSObject<YYModel>


@property (nonatomic, copy) NSString *start;

@property (nonatomic, strong) DiscoveryTop_Banner *top_banner;

@property (nonatomic, strong) NSArray<DiscoveryMod_List *> *mod_list;




@end
@interface DiscoveryTop_Banner : NSObject<YYModel>

@property (nonatomic, copy) NSString *type;

@property (nonatomic, assign) NSInteger _id;

@property (nonatomic, assign) BOOL is_last_page;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray<DiscoveryEntity_List *> *entity_list;

@property (nonatomic, assign) NSInteger start;

@end

@interface DiscoveryEntity_List : NSObject<YYModel>
@property (nonatomic, copy) NSString *begin;

@property (nonatomic, strong) DiscoveryCollection *collection;

@property (nonatomic, copy) NSString *banner_img_url;

@property (nonatomic, copy) NSString *exposure_url;

@property (nonatomic, strong) DiscoveryGroup *group;

@property (nonatomic, strong) DiscoveryMeow *meow;
@end

@interface DiscoveryMeow : NSObject

@property (nonatomic, copy) NSString *share_img;

@property (nonatomic, assign) NSInteger image_count;

@property (nonatomic, assign) NSInteger object_type;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger create_time;

@property (nonatomic, copy) NSString *meow_status;

@property (nonatomic, assign) NSInteger is_post_by_master;

@property (nonatomic, copy) NSString *share_text;

@property (nonatomic, assign) NSInteger bang_count;

//@property (nonatomic, strong) NSArray<Images *> *images;

//@property (nonatomic, strong) Category *category;

@property (nonatomic, assign) NSInteger kind;

@property (nonatomic, strong) DiscoveryGroup *group;

@property (nonatomic, assign) BOOL is_folded;

//@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger is_filtered;

//@property (nonatomic, strong) User *user;

@property (nonatomic, assign) NSInteger meow_type;

@property (nonatomic, assign) NSInteger comment_count;

@property (nonatomic, copy) NSString *author;

@property (nonatomic, copy) NSString *description;

@end



@interface DiscoveryCollection : NSObject

@property (nonatomic, copy) NSString *banner_img_url;

@property (nonatomic, strong) DiscoveryLogo_Url_Thumb *logo_url_thumb;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger content_num;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) DiscoveryThumb *thumb;

@property (nonatomic, copy) NSString *logo_url;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, assign) BOOL is_program;

@property (nonatomic, assign) NSInteger fav_num;

@property (nonatomic, strong) DiscoveryBanner_Img_Url_Thumb *banner_img_url_thumb;

@end

@interface DiscoveryThumb : NSObject

@property (nonatomic, copy) NSString *raw;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, assign) NSInteger height;

@property (nonatomic, copy) NSString *format;

@end

@interface DiscoveryLogo_Url_Thumb : NSObject

@property (nonatomic, copy) NSString *raw;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, assign) NSInteger height;

@property (nonatomic, copy) NSString *format;

@end

@interface DiscoveryBanner_Img_Url_Thumb : NSObject

@property (nonatomic, copy) NSString *raw;

@property (nonatomic, assign) NSInteger error_code;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, assign) NSInteger height;

@property (nonatomic, copy) NSString *format;

@end

@interface DiscoveryMod_List : NSObject<YYModel>

@property (nonatomic, copy) NSString *type;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) BOOL is_last_page;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray<DiscoveryEntity_List *> *entity_list;

@property (nonatomic, assign) NSInteger start;

@end



@interface DiscoveryGroup : NSObject<YYModel>

@property (nonatomic, copy) NSString *des;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, assign) NSInteger discuss_content_num;

@property (nonatomic, strong) NSArray *admin_list;

@property (nonatomic, strong) NSArray *admin_data;

@property (nonatomic, assign) NSInteger campaign_num;

@property (nonatomic, strong) DiscoveryLogo_Url_Thumb *logo_url_thumb;

@property (nonatomic, assign) NSInteger kind;

@property (nonatomic, assign) NSInteger cert_kind_id;

@property (nonatomic, copy) NSString *category;

@property (nonatomic, copy) NSString *logo_url;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) DiscoveryCert *cert;

@property (nonatomic, copy) NSString *slogan;

@property (nonatomic, strong) DiscoveryMaster_Info *master_info;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, strong) DiscoveryThumb *thumb;

@property (nonatomic, assign) NSInteger member_num;

@property (nonatomic, assign) NSInteger topic_content_num;

@property (nonatomic, assign) NSInteger category_id;

@property (nonatomic, assign) NSInteger publisher_type;

@end

@interface DiscoveryMaster_Info : NSObject

@property (nonatomic, assign) NSInteger gender;

@property (nonatomic, strong) DiscoveryCoordinate *coordinate;

@property (nonatomic, assign) NSInteger horoscope;

@property (nonatomic, strong) DiscoveryAvatar_Url_Thumb *avatar_url_thumb;

@property (nonatomic, assign) BOOL is_anonymous;

@property (nonatomic, copy) NSString *self_description;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *avatar_url;

@property (nonatomic, copy) NSString *name;

@end

@interface DiscoveryAvatar_Url_Thumb : NSObject

@property (nonatomic, copy) NSString *raw;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, assign) NSInteger height;

@property (nonatomic, copy) NSString *format;

@end

@interface DiscoveryCoordinate : NSObject

@property (nonatomic, assign) NSInteger longitude;

@property (nonatomic, copy) NSString *area_name;

@property (nonatomic, assign) NSInteger latitude;

@end

@interface DiscoveryCert : NSObject

@property (nonatomic, assign) NSInteger cert_url_type;

@property (nonatomic, copy) NSString *home_page;

@property (nonatomic, copy) NSString *wechat_id;

@property (nonatomic, copy) NSString *ios_download_url;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *android_download_url;

@property (nonatomic, copy) NSString *weibo_url;

@property (nonatomic, assign) NSInteger cert_kind_id;

@property (nonatomic, copy) NSString *ios_stats_download_url;

@property (nonatomic, copy) NSString *app_name;

@end





