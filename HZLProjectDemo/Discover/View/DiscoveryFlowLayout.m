//
//  DiscoveryFlowLayout.m
//  HZLProjectDemo
//
//  Created by 黄梓伦 on 10/7/16.
//  Copyright © 2016 黄梓伦. All rights reserved.
//

#import "DiscoveryFlowLayout.h"
@interface DiscoveryFlowLayout()

@property (nonatomic, strong) NSMutableArray *attrs;




@end
@implementation DiscoveryFlowLayout
{
    NSInteger _sectionsCount;
}
- (NSMutableArray *)attrs
{
    if (!_attrs) {
        
        _attrs = [[NSMutableArray alloc] init];
        
    }
    
    return _attrs;
    
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    NSInteger totalCount = [self.collectionView numberOfItemsInSection:0];
    _sectionsCount = [self.collectionView numberOfSections];
    
    for (int j = 0; j < _sectionsCount; j++) {
        for (int i = 0; i < totalCount; i++) {
            
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:j];
            
            UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexPath];
            
            [self.attrs addObject:attr];
            
        }

    }
    
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat height = 150;
    CGFloat deltaY = (indexPath.section - 1) * 1000 + 1200;
    
    if (indexPath.section == 0) {
        
        if (indexPath.item == 0) {
            
            CGFloat x = 0;
            CGFloat y = 0;
            CGFloat height0 = 400;
            CGFloat w0 = self.collectionView.frame.size.width;
            
            attrs.frame = CGRectMake(x, y, w0, height0);
            return attrs;

        }else
        {
            if (indexPath.item != 5) {
                
                
                
                CGFloat w = self.collectionView.frame.size.width / 2;
                
                if (indexPath.item < 5) {
                    
                    CGFloat x = ((indexPath.item - 1) % 2) * w;
                    
                    if (indexPath.item > 2) {
                        
                        CGFloat y = height + 400;
                        
                        attrs.frame = CGRectMake(x, y, w, height);
                        
                        return attrs;
                    }
                    
                    CGFloat y = 400;
                    
                    attrs.frame = CGRectMake(x, y , w, height);
                    
                    return attrs;
                    
                }else
                {
                    
                    CGFloat x = (indexPath.item % 2) * w;
                    
                    if (indexPath.item > 7) {
                        
                        CGFloat y = 3 * height + 600;
                        
                        attrs.frame = CGRectMake(x, y, w, height);
                        
                        return attrs;
                    }
                    
                    CGFloat y = 2 * height + 600;
                    
                    attrs.frame = CGRectMake(x, y , w, height);
                    
                    return attrs;
                }
                
            }else
            {
                
                CGFloat x = 0;
                CGFloat y = 2 * height + 400;
                CGFloat w = self.collectionView.frame.size.width;
                attrs.frame = CGRectMake(x, y , w, 200);
                return attrs;
            }

        }
    }else
    {
        if (indexPath.item == 0) {
            
            attrs.frame = CGRectMake(0, deltaY, self.collectionView.frame.size.width, 200);
            return attrs;
        }else
        {
            if (indexPath.item != 5) {
                
                
                
                CGFloat w = self.collectionView.frame.size.width / 2;
                
                if (indexPath.item < 5) {
                    
                    CGFloat x = ((indexPath.item - 1) % 2) * w;
                    
                    if (indexPath.item > 2) {
                        
                        CGFloat y = height + 200;
                        
                        attrs.frame = CGRectMake(x, y +deltaY , w, height);
                        
                        return attrs;
                    }
                    
                    CGFloat y = 200;
                    
                    attrs.frame = CGRectMake(x, y +deltaY , w, height);
                    
                    return attrs;
                    
                }else
                {
                    
                    CGFloat x = (indexPath.item % 2) * w;
                    
                    if (indexPath.item > 7) {
                        
                        CGFloat y = 3 * height + 400;
                        
                        attrs.frame = CGRectMake(x, y +deltaY, w, height);
                        
                        return attrs;
                    }
                    
                    CGFloat y = 2 * height + 400;
                    
                    attrs.frame = CGRectMake(x, y +deltaY, w, height);
                    
                    return attrs;
                }
                
            }else
            {
                
                CGFloat x = 0;
                CGFloat y = 2 * height + 200;
                CGFloat w = self.collectionView.frame.size.width;
                attrs.frame = CGRectMake(x, y +deltaY , w, 200);
                return attrs;
            }
        }
    }
    
}
- (CGSize)collectionViewContentSize
{
    
    
    return CGSizeMake(0, _sectionsCount * 1000 + 200);
    
    
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    return self.attrs;

}

@end
