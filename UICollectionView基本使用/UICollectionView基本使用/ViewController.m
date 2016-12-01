//
//  ViewController.m
//  UICollectionView基本使用
//
//  Created by 陈胜华 on 16/8/11.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UICollectionViewDataSource>

@end

static NSString *collectionCellID = @"CollecitonCellIdnetifier";

@implementation ViewController

/**UICollectionViewFlowLayout-属性介绍
 
 // 字面意思是最小的线的空间, 其实是指横向距离(行与行)
 @property (nonatomic) CGFloat minimumLineSpacing;
 // 竖向距离(列与列)
 @property (nonatomic) CGFloat minimumInteritemSpacing;
 // 项目的大小,其实就是 每个元素的大小,也就是每个 cell 的大小
 @property (nonatomic) CGSize itemSize;
 // 估算cell大小
 @property (nonatomic) CGSize estimatedItemSize
 // 滚动方向
 @property (nonatomic) UICollectionViewScrollDirection scrollDirection;
 // 头部相关距离
 @property (nonatomic) CGSize headerReferenceSize;
 // 尾部相关距离
 @property (nonatomic) CGSize footerReferenceSize;
 // 每一组的内边距
 @property (nonatomic) UIEdgeInsets sectionInset;

 */

- (void)viewDidLoad {
    [super viewDidLoad];
 
    //设置布局因素 : 流水布局(比较常用的布局)
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //创建 collectionView 初始化时加入布局
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    //只是为了验证 控件已经加到 view 上  ()
    collectionView.backgroundColor = [UIColor redColor];
    //一般是将 控制器 设置为 数据源, 也就是在控制器中处理各种数据.
    collectionView.dataSource = self;
    //关于 cell 的注册
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectionCellID];
    [self.view addSubview:collectionView];
}

//返回每一组的项目数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 200;
}

//返回每一个 item 的 cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

@end
