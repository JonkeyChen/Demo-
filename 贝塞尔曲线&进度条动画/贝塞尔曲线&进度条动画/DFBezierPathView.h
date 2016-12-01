//
//  DFBezierPathView.h
//  贝塞尔曲线&进度条动画
//
//  Created by 陈胜华 on 16/8/11.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DFBezierPathView : UIView

@property (nonatomic,assign) CGFloat progress;//0~1.0

- (void)startAnimation;

@end
