//
//  DFCornerLayout.m
//  UICollectionView水平缩放布局
//
//  Created by 陈胜华 on 16/8/11.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "DFCornerLayout.h"

@implementation DFCornerLayout

// 确保能实时更新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return YES;
}
// 进行圆形布局,设置其每个元素的相关因素(主要是它的 frame,中心点)
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 创建可变数组,用于储存所有的布局因素
    NSMutableArray *layoutAtts = [NSMutableArray array];
    // 取出对应布局中的 collectionView 的元素的数目(为的就是给一个个cell 独立设置其的布局)
    NSInteger count =  [self.collectionView numberOfItemsInSection:0];
    // 设置每个 cell 的高度和宽度
    CGFloat WH = 50;
    // 取出圆形视图的中心点 (也就是 collectionView 的中心点)
    CGFloat centerX = self.collectionView.frame.size.width * 0.5;
    CGFloat centerY = self.collectionView.frame.size.height * 0.5;
    // 设置 圆形布局半径
    CGFloat randius = centerY- 30;
    // 获得每个 cell 之间的间距 (所有 cell 平分了整个圆)
    CGFloat angelMargin = M_PI * 2 / count;
    // 遍历进行设置布局
    for (int i = 0; i < count ; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        //创建对应索引的布局
        UICollectionViewLayoutAttributes *layoutAtt = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        //根据三角函数设置布局的中心点
        CGFloat a = sin(i * angelMargin) * randius;
        CGFloat b = cos(i * angelMargin) * randius;
        layoutAtt.center = CGPointMake(centerX + a, b+ centerY);
        layoutAtt.size = CGSizeMake(WH, WH);
        [layoutAtts addObject:layoutAtt];
    }
    return layoutAtts;
}

@end
