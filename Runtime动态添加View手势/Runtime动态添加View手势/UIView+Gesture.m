//
//  UIView+Gesture.m
//  Runtime动态添加View手势
//
//  Created by 陈胜华 on 16/8/15.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "UIView+Gesture.h"
#import <objc/runtime.h>

char kDTActionHandlerTapGestureKey;
char kDTActionHandlerTapBlockKey;

char kDFPinchGestureKey;
char kDFPinchBlockKey;

@implementation UIView (Gesture)

/**
 1.假定我们想要动态地将一个Tap手势操作连接到任何UIView中，并且根据需要指定点击后的实际操作。
 这时候我们就可以将一个手势对象及操作的block对象关联到我们的UIView对象中。
 这项任务分两部分。
 首先，如果需要，我们要创建一个手势识别对象并将它及block做为关联对象。如下代码所示：

 */
- (void)addTapActionWithBlock:(void (^)(UITapGestureRecognizer *gesture))block{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerTapGestureKey);
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(__handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kDTActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kDTActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}
/**
 2.这段代码检测了手势识别的关联对象。
 如果没有，则创建并建立关联关系。
 同时，将传入的块对象连接到指定的key上。注意block对象的关联内存管理策略。
 手势识别对象需要一个target和action，所以接下来我们定义处理方法：
 */

- (void)__handleActionForTapGesture:(UITapGestureRecognizer *)gesturer {
    if (gesturer.state == UIGestureRecognizerStateRecognized) {
        void(^action)(UITapGestureRecognizer *gesture) = objc_getAssociatedObject(self, &kDTActionHandlerTapBlockKey);
        if (action){
            action(gesturer);
        }
    }
}


//缩放手势
- (void)addPinchActionWithBlock:(void (^)(UIPinchGestureRecognizer *))block {
    UIPinchGestureRecognizer *pinchGesture = objc_getAssociatedObject(self, &kDFPinchGestureKey);
    if (!pinchGesture) {
        pinchGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(__hanleAcitonForPinchGesure:)];
        [self addGestureRecognizer:pinchGesture];
        objc_setAssociatedObject(self, &kDFPinchGestureKey, pinchGesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kDFPinchBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)__hanleAcitonForPinchGesure:(UIPinchGestureRecognizer*)pinchGesture {
    if (pinchGesture.state == UIGestureRecognizerStateRecognized) {
        void(^action)(UIPinchGestureRecognizer *gesture) = objc_getAssociatedObject(self, &kDFPinchBlockKey);
        
        if (action) {
            action(pinchGesture);
        }
    }
}

@end
