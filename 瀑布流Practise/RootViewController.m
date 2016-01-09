//
//  RootViewController.m
//  瀑布流Practise
//
//  Created by qianfeng on 15/11/18.
//  Copyright © 2015年 mxl. All rights reserved.
//

#import "RootViewController.h"
#import "CustomLayout.h"

@interface RootViewController ()<UICollectionViewDataSource, CustomLayoutDelegate>

@property (nonatomic, retain) UICollectionView *collectionView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)heightOfItems:(CustomLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath{

    return arc4random()%150 + 50;
}

- (UICollectionViewLayout *)createLayout{

    CustomLayout  *layout = [[CustomLayout alloc]init];
    NSLog(@"2");
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    layout.minimumInteritemSpacing = 1;
    layout.numberOfColumn = 4;
    layout.minimumLineSpacing = 1000000;
    layout.delegate = self;
    return layout;
}

- (void)createCollectionView{
    CGRect frame = CGRectMake(0, 20, VIEW_WIDTH, VIEW_HEIGHT - 20);

    _collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:[self createLayout]];
    
    _collectionView.dataSource = self;
    
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    
    [self.view addSubview:_collectionView];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    NSArray *array = cell.contentView.subviews;
    UILabel *label = nil;
    if (array.count) {
        label = array[0];
    }else{
        label = [[UILabel alloc]init];
        
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:40];
        [cell.contentView addSubview:[label autorelease]];
    }
    label.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    label.text = [NSString stringWithFormat:@"%.2ld", indexPath.item];
    label.backgroundColor = [UIColor colorWithRed:RANDOM green:RANDOM blue:RANDOM alpha:1.0];
    return cell;
}


@end










