//
//  ViewController.m
//  iOS登录动画
//
//  Created by 陈胜华 on 16/8/31.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    UIView *_dfbtnView;
    CAShapeLayer *_clickCicrleLayer;
    CAShapeLayer *_shaperLayer;
    
    UIView *_animationView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CAGradientLayer *layer = ({
        //渐变
        CAGradientLayer *layer_ = [[CAGradientLayer alloc]init];
        layer_.frame = self.view.frame;
        layer_.colors = @[(__bridge id)[UIColor purpleColor].CGColor,(__bridge id)[UIColor redColor].CGColor];
        layer_.locations = @[@0.6,@0.8];
        layer_.startPoint = CGPointMake(0,0.5);
        layer_.endPoint   = CGPointMake(0,1.0);
        layer_;
    });
    //[self.view.layer addSublayer:layer];
    
    [self setUpCustom];
}

- (void)setUpCustom {
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    titleLabel.center = CGPointMake(self.view.center.x, 150);
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"CLOVER";
    titleLabel.font = [UIFont systemFontOfSize:40.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    UILabel *detail = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
    detail.center = CGPointMake(self.view.center.x,100);
    detail.textColor = [UIColor whiteColor];
    detail.text = @"Don`t have an account yet? Sign Up";
    detail.font = [UIFont systemFontOfSize:13.f];
    detail.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:detail];
    
    _dfbtnView = ({
        UIView *contentView = [[UIView alloc]init];
        contentView.frame = CGRectMake(0, 100, 200, 40);
        contentView.center = CGPointMake(self.view.center.x, 500);
        [self.view addSubview:contentView];
        
        //划线路径
        UIBezierPath *bezierPath = ({
            CGFloat radius = contentView.bounds.size.height/2.0 - 3;
            CGFloat right = contentView.bounds.size.width-contentView.frame.size.height/2.0;
            CGFloat left = contentView.frame.size.height/2.0;
            
            UIBezierPath *bezierPath_ = [UIBezierPath bezierPath];
            bezierPath_.lineJoinStyle = kCGLineJoinRound;
            bezierPath_.lineCapStyle = kCGLineCapRound;
            //右边圆弧
            [bezierPath_ addArcWithCenter:CGPointMake(right, contentView.bounds.size.height/2)
                                   radius:radius
                               startAngle:-M_PI/2
                                 endAngle:M_PI/2
                                clockwise:YES];
            //左边圆弧
            [bezierPath_ addArcWithCenter:CGPointMake(left, contentView.bounds.size.height/2)
                                   radius:radius
                               startAngle:M_PI/2
                                 endAngle:-M_PI/2
                                clockwise:YES];
            //闭合弧线
            [bezierPath_ closePath];
            bezierPath_;
        });
        
        _shaperLayer = ({
            CAShapeLayer *shaperLayer_ = [CAShapeLayer layer];
            shaperLayer_.frame = _dfbtnView.frame;
            shaperLayer_.lineWidth = 2;
            shaperLayer_.path = bezierPath.CGPath;
            shaperLayer_.fillColor = [UIColor clearColor].CGColor;//背景填充颜色，defaut blacColor
            shaperLayer_.strokeColor = [UIColor whiteColor].CGColor;
            shaperLayer_;
        });
        [contentView.layer addSublayer:_shaperLayer];
        
        UIButton *etbtnLogin = ({
            UIButton *etbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            etbtn.frame = contentView.bounds;
            [contentView addSubview:etbtn];
            etbtn;
        });
        [etbtnLogin addTarget:self action:@selector(_efOnClcikLogin) forControlEvents:UIControlEventTouchDown];
        
        contentView;
    });
    
    
    _animationView = [UIView new];
    _animationView.frame = CGRectMake(10, 200, 30, 30);
    _animationView.backgroundColor = [UIColor yellowColor];
    _animationView.layer.masksToBounds = YES;
    _animationView.layer.cornerRadius  = 5;
    [self.view addSubview:_animationView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    //缩放动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.5];
    scaleAnimation.autoreverses = YES;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.duration = 0.8;
    
    //移动动画
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:_animationView.layer.position];
    moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(320 - 80, _animationView.layer.position.y)];
    moveAnimation.autoreverses = YES;
    moveAnimation.repeatCount = MAXFLOAT;
    moveAnimation.duration = 2;
    
    //旋转动画
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:6.0 * M_PI];
    rotateAnimation.autoreverses = YES;
    rotateAnimation.repeatCount = MAXFLOAT;
    rotateAnimation.duration = 2;
    
    //将动画组合起来
    CAAnimationGroup *groupAnnimation = [CAAnimationGroup animation];
    groupAnnimation.duration = 2;
    groupAnnimation.autoreverses = YES;
    groupAnnimation.animations = @[moveAnimation, scaleAnimation, rotateAnimation];
    groupAnnimation.repeatCount = MAXFLOAT;
    
    [_animationView.layer addAnimation:groupAnnimation forKey:@"groupAnnimation"];
}

- (void)_efOnClcikLogin {
    //围绕y轴旋转
    
    NSLog(@"点击");
    [_clickCicrleLayer removeFromSuperlayer];
    
    UIBezierPath *path1 = [self drawclickCircleBezierPath:0];
    UIBezierPath *path2 = [self drawclickCircleBezierPath:_dfbtnView.bounds.size.height/2.0 - 10];
    
    //小圆环
    CAShapeLayer *clickCicrleLayer = [CAShapeLayer layer];
    clickCicrleLayer.frame = CGRectMake(_dfbtnView.bounds.size.width/2, _dfbtnView.bounds.size.height/2, 5, 5);
    clickCicrleLayer.fillColor = [UIColor whiteColor].CGColor;
    clickCicrleLayer.path = path1.CGPath;
    [_dfbtnView.layer addSublayer:clickCicrleLayer];
    
    //放大变色圆形
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    basicAnimation.duration = 0.5;
    basicAnimation.toValue = (__bridge id _Nullable)(path2.CGPath);
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    
    [clickCicrleLayer addAnimation:basicAnimation forKey:@"clickCicrleAnimation"];
    
    _clickCicrleLayer = clickCicrleLayer;
    
    //执行下一个动画
    [self performSelector:@selector(startNextAnimation) withObject:self afterDelay:basicAnimation.duration];
}

- (void)startNextAnimation{
    //圆形变圆弧
    _clickCicrleLayer.fillColor = [UIColor clearColor].CGColor;
    _clickCicrleLayer.strokeColor = [UIColor whiteColor].CGColor;
    _clickCicrleLayer.lineWidth = 10;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    
    //圆弧变大
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    basicAnimation.duration = 0.5;
    basicAnimation.toValue = (__bridge id _Nullable)([self drawclickCircleBezierPath:_dfbtnView.bounds.size.height/2.0+_clickCicrleLayer.lineWidth/2.0].CGPath);
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    
    //变透明
    CABasicAnimation *basicAnimation1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    basicAnimation1.beginTime = 0.10;
    basicAnimation1.duration = 0.5;
    basicAnimation1.toValue = @0;
    basicAnimation1.removedOnCompletion = NO;
    basicAnimation1.fillMode = kCAFillModeForwards;
    
    animationGroup.duration = basicAnimation1.beginTime + basicAnimation1.duration;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.animations = @[basicAnimation,basicAnimation1];
    
    [_clickCicrleLayer addAnimation:animationGroup forKey:@"clickCicrleAnimation1"];
    
    //执行下一个动画
    //[self performSelector:@selector(startNextEndAnimation) withObject:self afterDelay:basicAnimation.duration];
}
- (void)startNextEndAnimation{
    _shaperLayer.opacity = 0.5;
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    basicAnimation.duration = 0.25;
    basicAnimation.toValue = (__bridge id _Nullable)([self drawBezierPath:_dfbtnView.frame.size.height/2].CGPath);
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    [_shaperLayer addAnimation:basicAnimation forKey:@"maskAnimation"];

    //执行下一个动画
    [self performSelector:@selector(overAnimation) withObject:self afterDelay:basicAnimation.duration];
}

- (void)overAnimation {
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    basicAnimation.duration = 0.2;
    basicAnimation.toValue = (__bridge id _Nullable)([self drawBezierPath:_dfbtnView.frame.size.width/2].CGPath);
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *basicAnimation1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    basicAnimation1.beginTime = 0.10;
    basicAnimation1.duration = 0.2;
    basicAnimation1.toValue = @0;
    basicAnimation1.removedOnCompletion = NO;
    basicAnimation1.fillMode = kCAFillModeForwards;
    
    animationGroup.animations = @[basicAnimation,basicAnimation1];
    animationGroup.duration = basicAnimation1.beginTime+basicAnimation1.duration;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    [_shaperLayer addAnimation:animationGroup forKey:@"dismissAnimation"];
}

//画圆
-(UIBezierPath *)drawclickCircleBezierPath:(CGFloat)radius{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:CGPointMake(0,0)//center: 弧线中心点的坐标
                          radius:radius//radius: 弧线所在圆的半径
                      startAngle:0//startAngle: 弧线开始的角度值
                        endAngle:M_PI*2//endAngle: 弧线结束的角度值
                       clockwise:YES];//clockwise: 是否顺时针画弧线
    return bezierPath;
}

-(UIBezierPath *)drawBezierPath:(CGFloat)x{
    CGFloat radius = _dfbtnView.bounds.size.height/2 - 3;
    CGFloat right = _dfbtnView.bounds.size.width-x;
    CGFloat left = x;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    bezierPath.lineCapStyle = kCGLineCapRound;
    //右边圆弧
    [bezierPath addArcWithCenter:CGPointMake(right, _dfbtnView.bounds.size.height/2)
                          radius:radius
                      startAngle:-M_PI/2
                        endAngle:M_PI/2
                       clockwise:YES];
    //左边圆弧
    [bezierPath addArcWithCenter:CGPointMake(left, _dfbtnView.bounds.size.height/2)
                          radius:radius
                      startAngle:M_PI/2
                        endAngle:-M_PI/2
                       clockwise:YES];
    //闭合弧线
    [bezierPath closePath];
    
    return bezierPath;
}

@end
