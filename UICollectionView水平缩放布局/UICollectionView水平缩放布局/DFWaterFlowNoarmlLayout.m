//
//  DFWaterFlowNoarmlLayout.m
//  UICollectionView水平缩放布局
//
//  Created by 陈胜华 on 16/8/11.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "DFWaterFlowNoarmlLayout.h"

@interface DFWaterFlowNoarmlLayout () {
    
    // 用来设置水平间距
    CGFloat _horizontalMargin ;
    // 用来设置竖直间距
    CGFloat _verticalMargin ;
    // 最大的列数
    NSInteger _maxColumns ;
    // 每个item的四边剧
    UIEdgeInsets _insets;
}

// 加入相关属性
// 保存每一列的高度
@property (strong, nonatomic) NSMutableArray *perColumnMaxHeights;
// 保存所有元素的相关属性
@property (strong, nonatomic) NSMutableArray *layoutAtts;

@end

@implementation DFWaterFlowNoarmlLayout

- (NSMutableArray *)layoutAtts {
    if (!_layoutAtts) {
        _layoutAtts = [NSMutableArray array];
    }
    return _layoutAtts;
}

//1.对每一个Item进行布局
- (nullable NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    //返回 cell的个数，进行一个个重新布局
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    CGFloat W = self.collectionView.frame.size.width * 0.5;
    CGFloat H = 0;
    CGFloat Y = 0;
    CGFloat X = 0;
    
    for (int i = 0; i < count ; i ++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        
        UICollectionViewLayoutAttributes *layoutAtt = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        if (i == 0) {
            H = W;
            X = 0;
            Y = 0;
        }else if (i == 1){
            H = W * 0.5;
            X = W;
            Y = 0;
        }else if (i == 2){
            H = W * 0.5;
            X = W;
            Y = W * 0.5;
        }else if (i == 3){
            H = W * 0.5;
            X = 0;
            Y = W;
            
        }else if (i == 4){
            H = W * 0.5;
            X = 0;
            Y = H *3;
        }else if (i == 5){
            H = W;
            Y = W;
            X = W;
        } else {
            //取出 上一轮的 ，进行改变，然后再 在 原来值的基础上的Y值进行修改，得到新的Y值，再进行赋值赋值
            UICollectionViewLayoutAttributes *lastLayoutAtt = self.layoutAtts[i - 6];
            
            CGRect lastFrame = lastLayoutAtt.frame;
            
            H =  lastFrame.size.height;
            Y =  lastFrame.origin.y + 2 * W;
            X =  lastFrame.origin.x;
        }
        
        layoutAtt.frame = CGRectMake(X, Y, W, H);
        [self.layoutAtts addObject:layoutAtt];
    }
    
    return self.layoutAtts;
}
//2.设置滚动区域ContentSize
//布局 必须写到 get方法中，是属于 系统自调的方法。
- (CGSize)collectionViewContentSize {
    // 根据最后一个Itme来决定滚动区域
    UICollectionViewLayoutAttributes *layoutAtt = (UICollectionViewLayoutAttributes *) self.layoutAtts.lastObject;
    if (layoutAtt.frame.origin.x == 0){
        
        return CGSizeMake( self.collectionView.frame.size.width,CGRectGetMaxY(layoutAtt.frame));
        
    }else{
        return CGSizeMake(self.collectionView.frame.size.width, (CGRectGetMaxY(layoutAtt.frame) + layoutAtt.size.height));
        
    }
}


@end
