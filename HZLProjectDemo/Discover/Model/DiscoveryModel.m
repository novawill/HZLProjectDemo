//
//  DiscoveryModel.m
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 10/7/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "DiscoveryModel.h"

@implementation DiscoveryModel



+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    
    return @{@"mod_list" : [DiscoveryMod_List class]};
    
}


@end
@implementation DiscoveryTop_Banner
/**
 *  @author 黄梓伦, 16-10-09 23:10:22
 *
 *  未知原因，该方法无效而下面的方法有效。
 */
//+ (NSDictionary *)modelContainerPropertyGenericClass
//{
//    return @{@"entity_list" : [DiscoveryEntity_List class]};
//    
//}

+ (NSDictionary *)objectClassInArray{
    return @{@"entity_list" : [DiscoveryEntity_List class]};
}


@end


@implementation DiscoveryEntity_List



@end


@implementation DiscoveryCollection

@end


@implementation DiscoveryThumb

@end


@implementation DiscoveryLogo_Url_Thumb

@end


@implementation DiscoveryBanner_Img_Url_Thumb

@end


@implementation DiscoveryMod_List

/**
 *  @author 黄梓伦, 16-10-09 23:10:22
 *
 *  未知原因，该方法无效而下面的方法有效。
 */
//+ (NSDictionary *)modelContainerPropertyGenericClass
//{
//    return @{@"entity_list" : [DiscoveryEntity_List class]};
//
//}

+ (NSDictionary *)objectClassInArray{
    return @{@"entity_list" : [DiscoveryEntity_List class]};
}

@end




@implementation DiscoveryGroup

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"des" : @"description"};
}

@end


@implementation DiscoveryMaster_Info

@end


@implementation DiscoveryAvatar_Url_Thumb

@end


@implementation DiscoveryCoordinate

@end


@implementation DiscoveryCert

@end





