//
//  CheckInModel.m
//  MOMO
//
//  Created by 黄梓伦 on 6/2/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "CheckInModel.h"

@implementation CheckInModel


+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"meow_list":[Meow_list class]};
}

@end

@implementation Meow_list

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    
    return @{@"album_cover":@"Album_cover",@"category":@"Cate",@"group":@"Group",@"user":@"User",@"thumb":@"Thumb"};
}

@end
