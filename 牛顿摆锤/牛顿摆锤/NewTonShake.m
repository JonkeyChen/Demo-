//
//  NewTonShake.m
//  牛顿摆锤
//
//  Created by 陈胜华 on 16/8/10.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "NewTonShake.h"


@interface BollView : UIView

@end

@implementation BollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}

@end

@interface NewTonShake (){
    // 记录球的个数
    NSInteger bollCount;
    // 放置所有的球
    NSArray *_bolls;
    // 放置所有的锚点
    NSArray *_anchors;
    //UIDynamicAnimator 可以理解为动画的执行框框,主要用来规定动画执行范围,以及动画的行为(那些动画)
    UIDynamicAnimator *_animator;
    //记录用户的拖拽
    UIPushBehavior *_userDragBehavior;
}

@end

@implementation NewTonShake

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置球的总数
        bollCount = 5;
        self.backgroundColor = [UIColor whiteColor];
        // 初始化球和锚点
        [self createBollsAndAnchors];
        // 给所有的球添加动画行为
        [self applyDynamicBehaviors];
    }
    return self;
}
// 用来初始化所有的球
- (void)createBollsAndAnchors
{
    NSMutableArray *bolls = [NSMutableArray array];
    NSMutableArray *anchors = [NSMutableArray array];
    // 为了方便操作， 估算球的大小，让其占据屏幕中间
    CGFloat bollWH = CGRectGetWidth(self.bounds) / (3.0 * (bollCount - 1));
    // 遍历为每个球设置其摆放位置
    for (int i = 0 ; i < bollCount; i++) {
        BollView *boll = [[BollView alloc]initWithFrame:CGRectMake(0, 0, bollWH-1, bollWH-1)];
        CGFloat x = CGRectGetWidth(self.bounds)/3.0 + i * bollWH;
        CGFloat y = CGRectGetHeight(self.bounds)/1.5;
        boll.layer.masksToBounds = YES;
        boll.layer.cornerRadius  =  CGRectGetWidth(boll.frame)/2.0;
        // 求出每个摆动球的中心位置.(方便于后面的监听,监听摆动球的中心点的变化)
        boll.center = CGPointMake(x, y);
        // 给球添加手势
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
        [boll addGestureRecognizer:panGesture];
        // 添加监听,用来监听摆动球中心位置的变化(方便重绘,如果连线是view的话,其位置的变化比较频繁,所以采用画的, 锚点的中心和摆动球的中心进行点的绘画)
        [boll addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew context:nil];
        // 将摆动球放置在数组中
        [bolls addObject:boll];
        // 添加到view上让其能够显示
        [self addSubview:boll];
        // 设置锚点
        UIView *blueBox = [self createAnchorsForBoll:boll];
        // 添加所有的锚点
        [anchors addObject:blueBox];
        [self addSubview:blueBox];
    }
    _anchors = anchors;
    _bolls = bolls;
}
// 创建对应的锚点view
- (UIView *)createAnchorsForBoll:(BollView *)boll
{
    UIView *blueBox = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    blueBox.backgroundColor = [UIColor blueColor];
    CGPoint point = boll.center;
    point.y -= CGRectGetHeight(self.bounds) / 4.0;
    blueBox.center = point;
    return blueBox;
}
// 手势方法,用于监听用户手势的拖动(开始拖动时添加拖拽动画,让摆动球能有一个拖拽动画,这个动画是独立的,应该在用户停止手势时,移除其拖拽动画,如果不移除的话,岂不是一直执行拖拽动画.还怎么去摆动)
- (void)handlePanGesture:(UIPanGestureRecognizer *) panGesture
{
    // 通过对手势状态的判定,添加push动画
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        // 如果已经存在,则移除原有的push动画
        if (_userDragBehavior) {
            [_animator removeBehavior:_userDragBehavior];
        }
        // 创建push动画
        _userDragBehavior = [[UIPushBehavior alloc]initWithItems:@[panGesture.view] mode:UIPushBehaviorModeContinuous];
        // 力度为1;
        _userDragBehavior.magnitude = 1;
        [_animator addBehavior:_userDragBehavior];
    }
    // push方向,拖拽方向,默认让其只能执行x方向的,如果是y方向的话就没有意义了,不过大家可以试试
    _userDragBehavior.pushDirection = CGVectorMake([panGesture translationInView:self].x, 0);
    // 根据手势状态, 来移除拖拽动画(也就是停止它)
    if (panGesture.state == UIGestureRecognizerStateEnded) {
        [_animator removeBehavior:_userDragBehavior];
        _userDragBehavior = nil;
    }
}
// 监听球的摆动,能够实时重绘连线,
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setNeedsDisplay];
}
// 绘画代码
- (void)drawRect:(CGRect)rect
{
    // 开启上下文
    CGContextRef ctn = UIGraphicsGetCurrentContext();
    // 遍历所有的摆动球
    for (id<UIDynamicItem> boll in _bolls) {
        // 拿到所有锚点的中心位置
        CGPoint anchorCenter = [[_anchors objectAtIndex:[_bolls indexOfObject:boll]] center];
        // 拿到所有球的中心位置
        CGPoint bollCenter = [boll center];
        //设置路径
        UIBezierPath *path = [UIBezierPath bezierPath];
        // 从锚点中心
        [path moveToPoint:anchorCenter];
        // 到摆动球中心
        [path addLineToPoint:bollCenter];
        // 设置颜色
        [[UIColor blackColor] setStroke];
        // 添加路经
        CGContextAddPath(ctn, path.CGPath);
        // 将路径画在上下文中
        CGContextStrokePath(ctn);
    }
}
// dealloc 方法中移除监听
- (void)dealloc
{
    for (BollView *boll in _bolls) {
        [boll removeObserver:self forKeyPath:@"center"];
    }
}

#pragma mark applyDynamicBehaviors
// 添加所有动画代码
- (void)applyDynamicBehaviors
{
    // 添加UIDynamic的动力行为，同时把多个动力行为组合为一个复杂的动力行为
    // UIDynamicBehavior抽象类,主要是组合各种动画
    UIDynamicBehavior *behavior = [[UIDynamicBehavior alloc]init];
    // 为球与点之间添加连带动画（附属）(添加后就会在重力行为绕着锚点运动)
    [self applyAttachBehaviorForBall:behavior];
    // 每个球加入重力动画
    [behavior addChildBehavior:[self creatGravityBehaviorForObjects:_bolls]];
    // 每个球加入 碰撞动画
    [behavior addChildBehavior:[self createCollisionBehavior:_bolls]];
    // 每个球加入一系列的
    [behavior addChildBehavior:[self createItemBehavior]];
    _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self];
    [_animator addBehavior:behavior];
}
// 为每一组(球和点)附带动画 (球绕着点的摆动)
- (void)applyAttachBehaviorForBall:(UIDynamicBehavior *)behavior
{
    for (int i = 0; i < bollCount; i ++) {
        UIDynamicBehavior *attachmentBehavior = [self creatAttachmentBehaviorForBall:[_bolls objectAtIndex:i] toAnchor:[_anchors objectAtIndex:i]];
        [behavior addChildBehavior:attachmentBehavior];
    }
}
- (UIDynamicBehavior *)creatAttachmentBehaviorForBall:(id<UIDynamicItem>)boll toAnchor:(id<UIDynamicItem>) anchor
{

    // 附属动画
    // UIAttachmentBehavior 描述一个view和一个锚相连接的情况，也可以描述view和view之间的连接。attachment描述的是两个点之间的连接情况，可以通过设置来模拟无形变或者弹性形变的情况（再次希望你还记得这些概念，简单说就是木棒连接和弹簧连接两个物体）。当然，在多个物体间设定多个；UIAttachmentBehavior，就可以模拟多物体连接了..有了这些，似乎可以做个老鹰捉小鸡的游戏了- -… (它和重力动画联系到一起,就有点摆动的意思)
    UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc]initWithItem:boll attachedToAnchor:[anchor center]];
    return attachmentBehavior;
}
// 添加重力动画
- (UIDynamicBehavior *)creatGravityBehaviorForObjects:(NSArray *)objects
{
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc]initWithItems:objects];
    
    return gravityBehavior;
}
// 添加碰撞动画
- (UIDynamicBehavior *)createCollisionBehavior:(NSArray *)objects
{
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc]initWithItems:objects];
    return collisionBehavior;
}
// 添加额外动画
- (UIDynamicBehavior *)createItemBehavior
{
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc]initWithItems:_bolls];
    itemBehavior.elasticity = 1.0;
    itemBehavior.allowsRotation = NO;
    itemBehavior.resistance = 0;
    return itemBehavior;
}

@end
