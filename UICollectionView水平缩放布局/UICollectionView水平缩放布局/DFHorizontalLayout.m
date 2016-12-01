//
//  DFHorizontalLayout.m
//  UICollectionView水平缩放布局
//
//  Created by 陈胜华 on 16/8/11.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "DFHorizontalLayout.h"

@implementation DFHorizontalLayout

//返回区域内每一个元素的布局属性 （重写的话， 相当于 要给每一个元素增添属性）
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    // 系统父类写的方法， 系统子类必须调用父类，进行执行(只是对部分属性进行修改,所以不必一个个进行设置布局属性)
    NSArray *layoutAtts =  [super layoutAttributesForElementsInRect:rect];
    CGFloat collectionViewCenterX = self.collectionView.bounds.size.width * 0.5;
    CGFloat contentOffsetX = self.collectionView.contentOffset.x;
    for (UICollectionViewLayoutAttributes *layoutAtt in layoutAtts) {
        CGFloat centerX = layoutAtt.center.x;
        // 形变值，根据当前cell 距离中心位置，的远近  进行反比例缩放。 （不要忘记算其偏移量的值。）
        CGFloat scale = 1 - ABS((centerX - collectionViewCenterX - contentOffsetX)/self.collectionView.bounds.size.width);
        // 给 布局属性  添加形变
        layoutAtt.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return layoutAtts;
}

/**
 现在实现另一个功能.想让每次都有一个图片放在 collectionView 的中间,也就是总有一张大的图片.,也就是上图的情况. (需要让其停止拖拽的时候, 让图片的偏移量 进行一定的修改, 离中线最近的 cell, 移至中心). 关于偏移量的方法, 我们找到其相关方法,再次进行重写的
 */
//通过目标移动的偏移量， 提取期望偏移量  （一般情况下，期望偏移量，就是 目标偏移量）
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    //根据偏移量 ， 确定区域
    CGRect rect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    //将屏幕所显示区域的 元素布局 取出。
    NSArray *layoutAtts = [super layoutAttributesForElementsInRect:rect];
    CGFloat minMargin = MAXFLOAT;
    CGFloat collectionViewCenterX = self.collectionView.frame.size.width * 0.5;
    CGFloat contentOffsetX = proposedContentOffset.x;
    //取出区域内元素， 并根据其中心位置， 与视图中心位置 进行比较， 比出最小的距离差
    for (UICollectionViewLayoutAttributes *layoutAtt in layoutAtts) {
        CGFloat margin = layoutAtt.center.x - contentOffsetX - collectionViewCenterX;
        if (ABS(margin) < ABS(minMargin)) {
            minMargin = margin;
        }
    }
    NSLog(@"%f",minMargin);
    //期望偏移量 加上差值， 让整体，沿差值 反方向移动，这样的话， 最近的一个，刚好在中心位置
    proposedContentOffset.x += minMargin;
    return proposedContentOffset;
}

// 是否允许 运行时，（在无效(未确定)的layout 情况下）改变bounds
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return YES;
}

@end
