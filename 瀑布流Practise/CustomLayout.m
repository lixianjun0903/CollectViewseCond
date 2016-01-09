//
//  CustomLayout.m
//  瀑布流Practise
//
//  Created by qianfeng on 15/11/18.
//  Copyright © 2015年 mxl. All rights reserved.
//

#import "CustomLayout.h"

@interface CustomLayout ()

@property (nonatomic, copy) NSMutableArray *itemsAttribute;
@property (nonatomic, copy) NSMutableArray *columnHeight;

@end
/**
 minimumLinSpacing;
 minimumInteriteSpacing;
 sectionInset1;
 numberOfColumn;
 */
@implementation CustomLayout

- (void)setMinimumLineSpacing:(CGFloat)minimumLineSpacing{

    if (_minimumLineSpacing != minimumLineSpacing) {
        _minimumLineSpacing = minimumLineSpacing;
        [self invalidateLayout];
    }
}

- (void)setMinimumInteritemSpacing:(CGFloat)minimumInteritemSpacing{

    if (_minimumInteritemSpacing != minimumInteritemSpacing) {
        _minimumInteritemSpacing = minimumInteritemSpacing;
        [self invalidateLayout];
    }
}

- (void)setSectionInset:(UIEdgeInsets)sectionInset{

    if (!UIEdgeInsetsEqualToEdgeInsets(_sectionInset, sectionInset)) {
        _sectionInset = sectionInset;
        [self invalidateLayout];
    }
}

- (void)setNumberOfColumn:(NSUInteger)numberOfColumn{

    if (_numberOfColumn != numberOfColumn) {
        _numberOfColumn = numberOfColumn;
        [self invalidateLayout];
    }
}

/**
 *itemsAttribute;
 *columnHeight;
 */
/**
 minimumLinSpacing;
 minimumInteriteSpacing;
 sectionInset1;
 numberOfColumn;
 */
- (void)prepareLayout{

    [super prepareLayout];
    if (_itemsAttribute) {
        [_itemsAttribute removeAllObjects];
    }else{
        _itemsAttribute = [[NSMutableArray alloc]init];
    }
    if (_columnHeight) {
        [_columnHeight removeAllObjects];
    }else{
        _columnHeight = [[NSMutableArray alloc]init];
    }
    for (NSUInteger i = 0; i < self.numberOfColumn; i++) {
        [_columnHeight addObject:@(self.sectionInset.top)];
    }
    CGFloat itemWidth = (self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right - (self.numberOfColumn - 1) * self.minimumInteritemSpacing) / self.numberOfColumn;
    
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i  inSection:0];
        CGFloat itemHeight = itemWidth;
        if ([self.delegate respondsToSelector:@selector(heightOfItems:heightForItemAtIndexPath:)]) {
            itemHeight = [self.delegate heightOfItems:self heightForItemAtIndexPath:indexPath];
        }
        NSInteger shortestColumn = [self shortestColumn];
        CGPoint origin = CGPointMake(self.sectionInset.left + shortestColumn * (itemWidth + self.minimumInteritemSpacing), [_columnHeight[shortestColumn] floatValue] + self.sectionInset.bottom);
        CGRect frame = CGRectMake(origin.x, origin.y, itemWidth, itemHeight);
        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attr.frame = frame;
        [_itemsAttribute addObject:attr];
        
        [_columnHeight replaceObjectAtIndex:shortestColumn withObject:@(origin.y + self.minimumInteritemSpacing + itemHeight)];
    }
    [self.collectionView reloadData];
}

- (NSInteger)shortestColumn{

    NSInteger index = 0;
    for (NSInteger i = 0; i < _numberOfColumn; i ++) {
        if ([_columnHeight[i] floatValue] < [_columnHeight[index] floatValue]) {
            index = i;
        }
    }
    return index;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{

    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (UICollectionViewLayoutAttributes *attr in _itemsAttribute) {
        if (CGRectIntersectsRect(attr.frame, rect)) {
            [array addObject:attr];
        }
    }
    return array;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{

    return _itemsAttribute[indexPath.item];
}

- (CGSize)collectionViewContentSize{

    NSInteger index = [self longestColumn];
    return CGSizeMake(self.collectionView.frame.size.width, [_columnHeight[index] floatValue] + self.sectionInset.bottom - self.minimumInteritemSpacing);
}

- (NSInteger)longestColumn{

    NSInteger index = 0;
    for (NSInteger i = 0; i < _numberOfColumn; i++) {
        if ([_columnHeight[i] floatValue] > [_columnHeight[index] floatValue]) {
            index = i;
        }
    }
    return index;
}

@end























