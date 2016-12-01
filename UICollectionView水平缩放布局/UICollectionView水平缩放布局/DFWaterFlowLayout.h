//
//  DFWaterFlowLayout.h
//  UICollectionView不规则布局的流水布局
//
//  Created by 陈胜华 on 16/8/11.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DFWaterFlowLayout;
@protocol DFWaterFlowLayoutDelegate <NSObject>
@required
/*!
 *  @brief 每个Item的高度（传入高度一至，则规则；不规则就瀑布流）
 *
 *  @param waterFlowLayout waterFlowLayout对象
 *  @param indexPath       indexPath
 *  @param width           width
 *
 *  @return 高度
 */
- (CGFloat)waterFlowLayout:(DFWaterFlowLayout *)waterFlowLayout indexPath:(NSIndexPath *)indexPath width:(CGFloat)width;

@end

/*!
 *  @brief 不规则布局的流水布局
 */
@interface DFWaterFlowLayout : UICollectionViewLayout

/*!
 瀑布流的每排个数(默认3)
 */
@property (nonatomic,assign) NSInteger maxColumns;
/*!
 瀑布流竖直方向的间距(上下间距,默认10)
 */
@property (nonatomic,assign) CGFloat verticalMargin;
/*!
 瀑布流水平方向的间距(左右间距,默认10)
 */
@property (nonatomic,assign) CGFloat horzontalMargin;
/*!
 瀑布流Cell整体偏移量（相对UICollectionView容器的偏移量）
 */
@property (nonatomic,assign) UIEdgeInsets inserts;
/*!
 瀑布流高度Item高度(如果实现代理，则失效)
 */
@property (nonatomic,assign) CGFloat rowHeight;
/*!
 设置代理，用于从外界拿到高度（不实现代理方法，则每个Item的高度随机）
 */
@property (nonatomic,  weak) id<DFWaterFlowLayoutDelegate> delegate;

@end
