//
//  NewShake.m
//  牛顿摆锤
//
//  Created by 陈胜华 on 16/8/10.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "NewShake.h"

//描点对象
@interface PointEntity : NSObject

@property (nonatomic,strong) UIView  *boll;      //摆球视图
@property (nonatomic,strong) UIView  *anchor;    //球体视图
@property (nonatomic,assign) CGPoint bollPoint;  //挂载描点
@property (nonatomic,assign) CGPoint anchorPoint;//球体描点

@end

@implementation PointEntity

@end

@interface NewShake (){
    //记录用户的拖拽
    UIPushBehavior *_userDragBehavior;
    UIDynamicAnimator *_animator;
    NSMutableArray<UIView*> *_anchors;
    NSMutableArray<UIView*> *_bolls;
}


///球的个数
@property (nonatomic,assign) NSInteger bollNumbers;

@property (nonatomic,strong) NSArray<PointEntity*> *bollAndAnchorsPoints;

//UIDynamicAnimator 可以理解为动画的执行框框,主要用来规定动画执行范围,以及动画的行为(那些动画)

@end

@implementation NewShake
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _bollNumbers = 5;
        
        [self initBollsAndAnchors];

        [self initAddDynamicBehaviors];
    }
    return self;
}

//初始化球&描点
- (void)initBollsAndAnchors {

    CGFloat bollWH = CGRectGetWidth(self.bounds)/(3*_bollNumbers);
    CGFloat lineLenght = CGRectGetHeight(self.bounds)/3.0;
    
    NSMutableArray *bollAnchorsPoints = [[NSMutableArray alloc]init];
    for (int i = 0; i < _bollNumbers; i++) {
        
        UIView *boll = ({//创建摆球
            UIView *bollSub = [[UIView alloc]init];
            bollSub.frame = CGRectMake(lineLenght+bollWH*i, CGRectGetHeight(self.bounds)-bollWH, bollWH, bollWH);
            bollSub.backgroundColor = [UIColor greenColor];
            bollSub.layer.masksToBounds = YES;
            bollSub.layer.cornerRadius  = bollWH/2.0;
            bollSub.tag = i+1000;//用于后面手势中判断为哪个View
            [self addSubview:bollSub];
            bollSub;
        });
        
        UIView *anchor = ({//创建悬挂点
            UIView *anchorSub = [[UIView alloc]init];
            anchorSub.backgroundColor = [UIColor blueColor];
            anchorSub.frame = CGRectMake(0, 0, bollWH/3.0, bollWH/3.0);
            [anchorSub setCenter:CGPointMake(CGRectGetMidX(boll.frame),CGRectGetMidY(self.bounds))];
            [self addSubview:anchorSub];
            anchorSub;
        });
        
        PointEntity *point = [[PointEntity alloc]init];
        point.bollPoint = boll.center;
        point.anchorPoint = anchor.center;
        point.boll = boll;
        point.anchor = anchor;
        [bollAnchorsPoints addObject:point];
        
        // 给球添加手势
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
        [boll addGestureRecognizer:panGesture];
        //观察球中心点的变化
        [boll addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew context:nil];
    }
    _bollAndAnchorsPoints = bollAnchorsPoints;
}

// 绘画代码
- (void)drawRect:(CGRect)rect
{
    // 开启上下文
    CGContextRef ctn = UIGraphicsGetCurrentContext();
   
    /*
    for (PointEntity *point in _bollAndAnchorsPoints) {
        // 拿到所有锚点的中心位置
        CGPoint anchorCenter = point.anchorPoint;
        // 拿到所有球的中心位置
        CGPoint bollCenter = point.bollPoint;
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
    }*/
    
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

// 监听球的摆动,能够实时重绘连线,
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [self setNeedsDisplay];
}


- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture {
    
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

#pragma mark - 添加所有动画代码
//名词解释：
//UIAttachmentBehavior:描述一个view和一个锚相连接的情况，也可以描述view和view之间的连接。attachment描述的是两个点之间的连接情况，可以通过设置来模拟无形变或者弹性形变的情况（再次希望你还记得这些概念，简单说就是木棒连接和弹簧连接两个物体）。当然，在多个物体间设定多个；UIAttachmentBehavior，就可以模拟多物体连接了..有了这些，似乎可以做个老鹰捉小鸡的游戏了- -… (它和重力动画联系到一起,就有点摆动的意思)
- (void)initAddDynamicBehaviors {
    
    _bolls = [[NSMutableArray alloc]init];
    for (PointEntity *pointEntity in _bollAndAnchorsPoints) {
        [_bolls addObject:pointEntity.boll];
    }
    _anchors = [[NSMutableArray alloc]init];
    for (PointEntity *pointEntity in _bollAndAnchorsPoints) {
        [_anchors addObject:pointEntity.anchor];
    }

    //添加UIDynamic的动力行为，同时把多个动力行为组合为一个复杂的动力行为,UIDynamicBehavior抽象类,主要是组合各种动画
    UIDynamicBehavior *behavior = [[UIDynamicBehavior alloc]init];

    //1.为球与点之间添加连带动画（附属）(添加后就会在重力行为绕着锚点运动)
    for (int i = 0; i < _bollAndAnchorsPoints.count; i ++) {
        UIDynamicBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc]initWithItem:_bolls[i] attachedToAnchor:_anchors[i].center];
        [behavior addChildBehavior:attachmentBehavior];
    }
    
    //2.每个球加入重力动画
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc]initWithItems:_bolls];
    [behavior addChildBehavior:gravityBehavior];
    
    //3.每个球加入 碰撞动画
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc]initWithItems:_bolls];
    [behavior addChildBehavior:collisionBehavior];

    //4.每个球加入一系列的
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc]initWithItems:_bolls];
    itemBehavior.elasticity = 1.0;
    itemBehavior.allowsRotation = NO;
    itemBehavior.resistance = 0;
    [behavior addChildBehavior:itemBehavior];

    //
    _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self];
    [_animator addBehavior:behavior];
}


@end
