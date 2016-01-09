//
//  CustomLayout.h
//  瀑布流Practise
//
//  Created by qianfeng on 15/11/18.
//  Copyright © 2015年 mxl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomLayout;

@protocol CustomLayoutDelegate <NSObject>

- (CGFloat)heightOfItems:(CustomLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface CustomLayout : UICollectionViewLayout

@property (nonatomic, assign) CGFloat       minimumLineSpacing;
@property (nonatomic, assign) CGFloat       minimumInteritemSpacing;
@property (nonatomic, assign) UIEdgeInsets  sectionInset;
@property (nonatomic, assign) NSUInteger    numberOfColumn;

@property (nonatomic, assign) id <CustomLayoutDelegate> delegate;

@end
