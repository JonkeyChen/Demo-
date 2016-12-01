//
//  UIView+Gesture.h
//  Runtime动态添加View手势
//
//  Created by 陈胜华 on 16/8/15.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Gesture)

/*!
 *  @brief 添加点击手势
 *
 *  @param block UITapGestureRecognizer
 */
- (void)addTapActionWithBlock:(void (^)(UITapGestureRecognizer *gesture))block;

/*!
 *  @brief 添加缩放手势
 *
 *  @param block UIPinchGestureRecognizer
 */
- (void)addPinchActionWithBlock:(void(^)(UIPinchGestureRecognizer *pinchGesture))block;

@end
