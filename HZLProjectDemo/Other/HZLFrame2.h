//
//  HZLFrame2.h
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 9/23/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef struct ZLFrame{
    
    CGFloat originX;
    CGFloat originY;
    CGFloat SizeHeight;
    
}HZLFrame;
HZLFrame CGHZLFrameMake(CGFloat x, CGFloat y, CGFloat height);
@interface HZLFrame2 : NSObject

@end
