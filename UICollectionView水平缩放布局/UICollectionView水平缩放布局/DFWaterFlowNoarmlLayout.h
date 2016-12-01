//
//  DFWaterFlowNoarmlLayout.h
//  UICollectionView水平缩放布局
//
//  Created by 陈胜华 on 16/8/11.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 1.首先自定义布局继承于流水布局,在流水布局的基础上进行布局的重新设置
 2.重写布局中的方法, 让每个Item根据自己想要尺寸进行对应设置.
 3.设置contentSize,设置滚动区域
 */

/*!
 *  @brief 有规则的流水布局
 */
@interface DFWaterFlowNoarmlLayout : UICollectionViewLayout

@end
