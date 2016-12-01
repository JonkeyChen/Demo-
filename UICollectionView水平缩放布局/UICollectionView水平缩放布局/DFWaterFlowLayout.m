//
//  DFWaterFlowLayout.m
//  UICollectionView不规则布局的流水布局
//
//  Created by 陈胜华 on 16/8/11.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

/**
 1.自定义布局由于修改部分较多,所以不必继承于流水布局,可以自己设置布局元素
 2.重写对每个Item的布局
 3.建立数组用于保存每一列现有的高度
 4.求出最小的高度,最为下一个item的初始高度, 当Item写入,更新当前列的高度.
 */

#import "DFWaterFlowLayout.h"

@interface DFWaterFlowLayout () {
    //水平间距
    CGFloat _horizontalMargin ;
    //竖直间距
    CGFloat _verticalMargin ;
    //最大的列数
    NSInteger _maxColumns ;
    //每个item的四边距
    UIEdgeInsets _insets;
}
//保存每一列的高度
@property (strong, nonatomic) NSMutableArray *perColumnMaxHeights;
//保存所有元素的相关属性
@property (strong, nonatomic) NSMutableArray<UICollectionViewLayoutAttributes*> *layoutAtts;

@end

@implementation DFWaterFlowLayout

- (instancetype)init {
    if (self = [super init]) {
        _maxColumns = 3;
        _horizontalMargin = 10;
        _verticalMargin = 10;
        _insets = UIEdgeInsetsMake(0, 10, 0, 10);
    }
    return self;
}

- (NSMutableArray *)layoutAtts{
    if (!_layoutAtts) {
        _layoutAtts = [NSMutableArray array];
    }
    return _layoutAtts;
}

- (NSMutableArray *)perColumnMaxHeights{
    if (!_perColumnMaxHeights) {
        _perColumnMaxHeights = [NSMutableArray array];
    }
    return _perColumnMaxHeights;
}

// 因为在 “layoutAttributesForElementsInRect”可能调用多次，计算多次， 而导致每次的随机数，都不一样， 而造成覆盖现象
// 所以在 预布局中处理， 可以只计算一次
- (void)prepareLayout
{
    [self.perColumnMaxHeights removeAllObjects];
    [self.layoutAtts removeAllObjects];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    //初始化数组高度,因为第一行,不需要按照高度大小添加
    for (int i = 0; i < _maxColumns; i ++) {
        [self.perColumnMaxHeights addObject:@(_insets.top)];
    }
    
    CGFloat W = (self.collectionView.frame.size.width - _insets.left - _insets.right - (_maxColumns - 1) * _horizontalMargin ) / _maxColumns;
    CGFloat H ;
    CGFloat X,Y;
    
    for (int i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *layoutAtt = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        // 求出高度最小的列， 计算出 Y值
        Y = [self.perColumnMaxHeights[[self minColumn]] floatValue]+ _verticalMargin;
        // 计算出 X 值
        X = _insets.left +[self minColumn] * (W + _horizontalMargin) ;
        // 通过代理计算出 高度
        if ([self.delegate respondsToSelector:@selector(waterFlowLayout:indexPath:width:)]) {
            H = [self.delegate waterFlowLayout:self indexPath:indexPath width:W];
        } else if (_rowHeight > 0){
            H = _rowHeight;
        } else {
            H = 70 + arc4random_uniform(100);
        }
        // 将新算出来的高度，替换 原来数组中对应的最低高度位置
        [self.perColumnMaxHeights replaceObjectAtIndex:[self minColumn] withObject:@(Y + H)];
        
        layoutAtt.frame = CGRectMake(X, Y, W, H);
        
        [self.layoutAtts addObject:layoutAtt];
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    return self.layoutAtts;
}

// 计算最小高度的列
- (NSInteger)minColumn {
    
    NSInteger minColumn = 0;
    CGFloat minHeight = [self.perColumnMaxHeights[0] floatValue];
    for (int i = 1; i < self.perColumnMaxHeights.count; i ++) {  
        CGFloat height = [self.perColumnMaxHeights[i] floatValue];
        if (height < minHeight) {
            minHeight = height;
            minColumn = i;
        }
    }
    return minColumn;
}

//计算最大高度的列 ，（用在设置 contensize）
- (NSInteger)maxColumn {
    
    NSInteger maxColumn = 0;
    CGFloat maxHeight = [self.perColumnMaxHeights[0] floatValue];
    for (int i = 1; i < self.perColumnMaxHeights.count; i ++) {
        CGFloat height = [self.perColumnMaxHeights[i] floatValue];
        if (height > maxHeight) {
            maxHeight = height;
            maxColumn = i;
        }
    }
    return maxColumn;
}


- (CGSize)collectionViewContentSize {
    
    if (self.perColumnMaxHeights.count == 0) {
        return CGSizeZero;
    }
    return CGSizeMake(self.collectionView.bounds.size.width,  [self.perColumnMaxHeights[[self maxColumn]] floatValue] + _insets.bottom);
}

- (void)setHorzontalMargin:(CGFloat)horizontalMargin {
    
    _horizontalMargin = horizontalMargin;
}

- (void)setVerticalMargin:(CGFloat)verticalMargin{
    
    _verticalMargin = verticalMargin;
}

- (void)setMaxColumns:(NSInteger)maxColumns{
    if (maxColumns == 0) {
        return;
    }
    _maxColumns = maxColumns;
}

-(void)setInserts:(UIEdgeInsets)inserts {
    
    _insets = inserts;
}

@end
