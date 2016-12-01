//
//  NewTonShake.h
//  牛顿摆锤
//
//  Created by 陈胜华 on 16/8/10.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 1.自由下落动画 UIGravityBehavior
 2.用户拖拽动画 UIPushBehavior
 3.碰撞动画    UICollisionBehavior
 4.连带动画    UIAttachmentBehavior
 5.空气的考虑等 UIDynamicItemBehavior
 
 1.UIAttachmentBehavior 描述一个view和一个锚相连接的情况，也可以描述view和view之间的连接。attachment描述的是两个点之间的连接情况，可以通过设置来模拟无形变或者弹性形变的情况（再次希望你还记得这些概念，简单说就是木棒连接和弹簧连接两个物体）。当然，在多个物体间设定多个；UIAttachmentBehavior，就可以模拟多物体连接了..有了这些，似乎可以做个老鹰捉小鸡的游戏了- -…
 
 2.UISnapBehavior 将UIView通过动画吸附到某个点上。初始化的时候设定一下UISnapBehavior的initWithItem:snapToPoint:就行，因为API非常简单，视觉效果也很棒，估计它是今后非游戏app里会被最常用的效果之一了；
 
 3.UIPushBehavior 可以为一个UIView施加一个力的作用，这个力可以是持续的，也可以只是一个冲量。当然我们可以指定力的大小，方向和作用点等等信息。
 
 4.UIDynamicItemBehavior 其实是一个辅助的行为，用来在item层级设定一些参数，比如item的摩擦，阻力，角阻力，弹性密度和可允许的旋转等等。
 
 原文链接：http://www.jianshu.com/p/af1fa83668c0
 */

@interface NewTonShake : UIView

@end
