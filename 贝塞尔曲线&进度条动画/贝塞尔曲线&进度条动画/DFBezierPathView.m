//
//  DFBezierPathView.m
//  贝塞尔曲线&进度条动画
//
//  Created by 陈胜华 on 16/8/11.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "DFBezierPathView.h"

@interface DFBezierPathView (){
    CGFloat _radius;//半径
    CGFloat _borderWidth;//轨道宽度
    CGFloat _waveBorderWidth;//波浪线宽度
    CGPoint _circlePoint;//圆点
    CGFloat _waveHeight;//波浪高度
    CGFloat _waveOffset;//波浪
    CGFloat _waveSpeed;//波浪速度
    BOOL    _isLineAnimationStop;//判断竖线动画是否完成
}

@property (nonatomic,strong) UIView *cicleView;//圆环
@property (nonatomic,strong) CAShapeLayer *lineShapeLayer;//竖线
@property (nonatomic,strong) CAShapeLayer *curveShapeLayer;//曲线
@property (nonatomic,strong) CAShapeLayer *waveShapeLayer;//波浪线
@property (nonatomic,strong) CAShapeLayer *cicleShapeLayer;//圆环路径
@property (nonatomic,strong) CAShapeLayer *successShapeLayer;//下载成功
@property (nonatomic,strong) UILabel *progressLabel;//进度显示

@property (nonatomic,strong) CADisplayLink *link;//定时器

@end

@implementation DFBezierPathView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blueColor];
        
        _borderWidth = 5;
        
        _waveBorderWidth = 3;
        
        _radius = CGRectGetWidth(frame)/2.0;
        
        _circlePoint = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
        
        
        //初始化计时器(默认关闭，需要条件满足才才开）
        self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(doWaveAnimation:)];
        [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        self.link.paused = YES;
        
        [self setUpInit];
    }
    return self;
}

- (void)setUpInit {
    
    self.cicleView = ({//圆环
        UIView *circleView = [[UIView alloc]init];
        circleView.frame = CGRectMake(0, 0, _radius*2, _radius*2);
        circleView.layer.masksToBounds = YES;
        circleView.layer.cornerRadius = _radius;
        circleView.layer.borderColor  = [UIColor whiteColor].CGColor;
        circleView.layer.borderWidth  = _borderWidth;
        circleView.alpha = .3;
        [self addSubview:circleView];
        circleView;
    });
    
    self.lineShapeLayer = ({//竖线
        CAShapeLayer *lineShapeLayer = [CAShapeLayer layer];
        lineShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        lineShapeLayer.lineWidth = _waveBorderWidth;
        lineShapeLayer.lineCap = kCALineCapRound;
        lineShapeLayer.path = [self lineBezierPath_ChangeValue:1.0f].CGPath;
        [self.layer addSublayer:lineShapeLayer];
        lineShapeLayer;
    });
    
    self.curveShapeLayer = ({//曲线
        CAShapeLayer *curveShapeLayer = [CAShapeLayer layer];
        curveShapeLayer = [CAShapeLayer layer];
        curveShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        curveShapeLayer.fillColor = [UIColor clearColor].CGColor;
        curveShapeLayer.lineWidth = _waveBorderWidth;
        curveShapeLayer.lineJoin = kCALineJoinRound;
        curveShapeLayer.lineCap = kCALineCapRound;
        curveShapeLayer.path = [self curveBezierPath_changeValue:0 otherValue:0].CGPath;
        [self.layer addSublayer:curveShapeLayer];
        curveShapeLayer;
    });
    
    self.waveShapeLayer = ({//波浪线
        CGFloat WIDTH = _circlePoint.x+20+20 - (_circlePoint.x-20-20);
        
        CAShapeLayer *waveShapeLayer = [CAShapeLayer layer];
        waveShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        waveShapeLayer.fillColor = [UIColor clearColor].CGColor;
        waveShapeLayer.lineWidth = _waveBorderWidth;
        waveShapeLayer.opacity = 1.0;
        waveShapeLayer.position = CGPointMake(_circlePoint.x-WIDTH/2, _circlePoint.y);
        [self.layer addSublayer:waveShapeLayer];
        waveShapeLayer;
    });

    self.cicleShapeLayer = ({//圆环
        //圆环路径
        UIBezierPath *circleBezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_circlePoint.x, _circlePoint.y)
                                                                        radius:_radius - _borderWidth/2.0
                                                                    startAngle:-M_PI/2
                                                                      endAngle:-2*M_PI-M_PI/2
                                                                     clockwise:NO];
        CAShapeLayer *cicleShapeLayer = [CAShapeLayer layer];
        cicleShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        cicleShapeLayer.fillColor = [UIColor clearColor].CGColor;
        cicleShapeLayer.lineWidth = _borderWidth;
        cicleShapeLayer.lineJoin = kCALineJoinRound;
        cicleShapeLayer.lineCap = kCALineCapRound;
        cicleShapeLayer.path = circleBezierPath.CGPath;
        cicleShapeLayer.strokeEnd = 0.0;//0 ~ 1.0
        [self.layer addSublayer:cicleShapeLayer];
        cicleShapeLayer;
    });
    
    self.progressLabel = ({//进度显示
        UILabel *progressLabel = [[UILabel alloc]init];
        progressLabel.center = CGPointMake(_circlePoint.x, _circlePoint.y+20);
        progressLabel.bounds = CGRectMake(0, 0, _radius*2, 30);
        progressLabel.layer.transform = CATransform3DMakeScale(0, 0, 0);
        progressLabel.textColor = [UIColor whiteColor];
        progressLabel.textAlignment = NSTextAlignmentCenter;
        progressLabel.font = [UIFont systemFontOfSize:14.f];
        [self addSubview:progressLabel];
        progressLabel;
    });
    
    self.successShapeLayer = ({//下载成功
        CAShapeLayer *successShapeLayer = [CAShapeLayer layer];
        successShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        successShapeLayer.fillColor = [UIColor clearColor].CGColor;
        successShapeLayer.lineWidth = _waveBorderWidth  ;
        successShapeLayer.opacity = 0.0;
        successShapeLayer.lineCap = kCALineCapRound;
        successShapeLayer.position = CGPointMake(_circlePoint.x, _circlePoint.y);
        successShapeLayer.path = [self curveBezierPath_finishChangeShape:0 leftValue:0 rightValue:0].CGPath;
        [self.layer addSublayer:successShapeLayer];
        successShapeLayer;
    });
}

- (void)startAnimation{
    
    [self doLineHorizontalAnimation];
    //曲线动画
    [NSTimer scheduledTimerWithTimeInterval:0.65 target:self selector:@selector(doCureAnimation) userInfo:nil repeats:NO];
    //显示进度动画
    [NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector:@selector(doShowProgressAnimation) userInfo:nil repeats:NO];
}

///竖直线动画
- (void)doLineHorizontalAnimation {
    CAAnimationGroup *lineAnimationGroup = [CAAnimationGroup animation];
    
    //竖线慢慢变成小圆动画
    CABasicAnimation *lineBasicAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    lineBasicAnimation.fromValue = (__bridge id _Nullable)([self lineBezierPath_ChangeValue:1].CGPath);
    lineBasicAnimation.toValue = (__bridge id _Nullable)([self lineBezierPath_ChangeValue:0.02].CGPath);
    lineBasicAnimation.fillMode = kCAFillModeForwards;
    lineBasicAnimation.removedOnCompletion = NO;
    lineBasicAnimation.duration = 1;
    
    //弹性移动动画
    CAKeyframeAnimation *lineKeyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    lineKeyframeAnimation.values = @[
                                     (__bridge id _Nullable)([self lineBezierPath_ChangeValue:0.02].CGPath),
                                     (__bridge id _Nullable)([self lineBezierPath_ChangePostion:_radius+30].CGPath),
                                     (__bridge id _Nullable)([self lineBezierPath_ChangePostion:_radius-_borderWidth/2.0].CGPath)
                                     ];
    lineKeyframeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAAnimationLinear];
    lineKeyframeAnimation.fillMode = kCAFillModeForwards;
    lineKeyframeAnimation.removedOnCompletion = NO;
    lineKeyframeAnimation.beginTime = 1.3;
    lineKeyframeAnimation.duration = 1;
    
    lineAnimationGroup.animations = @[lineBasicAnimation,lineKeyframeAnimation];
    lineAnimationGroup.duration = lineKeyframeAnimation.beginTime+lineKeyframeAnimation.duration;
    lineAnimationGroup.fillMode = kCAFillModeForwards;
    lineAnimationGroup.removedOnCompletion = NO;
    lineAnimationGroup.delegate = self;
    [self.lineShapeLayer addAnimation:lineAnimationGroup forKey:@"lineAnimationGroup"];
}

///曲线动画
- (void)doCureAnimation{

    CAAnimationGroup *curveAnimationGroup = [CAAnimationGroup animation];
    
    //往下移动动画
    CABasicAnimation *curveBasicAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    curveBasicAnimation.fromValue = (__bridge id _Nullable)([self curveBezierPath_changeValue:0 otherValue:0].CGPath);
    curveBasicAnimation.toValue = (__bridge id _Nullable)([self curveBezierPath_changeValue:10 otherValue:0].CGPath);
    curveBasicAnimation.fillMode = kCAFillModeForwards;
    curveBasicAnimation.removedOnCompletion = NO;
    curveBasicAnimation.duration = 0.35;
    
    //往上移动动画,并且曲线慢慢变成直线
    CABasicAnimation *curveBasicAnimation1 = [CABasicAnimation animationWithKeyPath:@"path"];
    curveBasicAnimation1.fromValue = (__bridge id _Nullable)([self curveBezierPath_changeValue:10 otherValue:0].CGPath);
    curveBasicAnimation1.toValue = (__bridge id _Nullable)([self curveBezierPath_changeValue:-10 otherValue:-20].CGPath);
    curveBasicAnimation1.fillMode = kCAFillModeForwards;
    curveBasicAnimation1.removedOnCompletion = NO;
    curveBasicAnimation1.beginTime = curveBasicAnimation.duration;
    curveBasicAnimation1.duration = 0.35;
    
    //弹性动画
    CAKeyframeAnimation *curveBasicAnimation2 = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    curveBasicAnimation2.values = @[
                                    (__bridge id _Nullable)([self curveBezierPath_Spring:0].CGPath),
                                    (__bridge id _Nullable)([self curveBezierPath_Spring:-8].CGPath),
                                    (__bridge id _Nullable)([self curveBezierPath_Spring:5].CGPath),
                                    (__bridge id _Nullable)([self curveBezierPath_Spring:-2].CGPath),
                                    (__bridge id _Nullable)([self curveBezierPath_Spring:0].CGPath)];
    curveBasicAnimation2.beginTime = curveBasicAnimation1.duration+ curveBasicAnimation1.beginTime;
    curveBasicAnimation2.duration = 0.35;
    
    //长度变宽动画
    CABasicAnimation *curveBasicAnimation3 = [CABasicAnimation animationWithKeyPath:@"path"];
    curveBasicAnimation3.fromValue = (__bridge id _Nullable)([self curveBezierPath_changeValue:-10 otherValue:-20].CGPath);
    curveBasicAnimation3.toValue = (__bridge id _Nullable)([self curveBezierPath_changeLength:20].CGPath);
    curveBasicAnimation3.beginTime = curveBasicAnimation2.duration+ curveBasicAnimation2.beginTime+1;
    curveBasicAnimation3.duration = 1;
    
    
    curveAnimationGroup.animations = @[curveBasicAnimation,curveBasicAnimation1,curveBasicAnimation2,curveBasicAnimation3];
    curveAnimationGroup.duration = curveBasicAnimation3.beginTime+curveBasicAnimation3.duration;
    curveAnimationGroup.fillMode = kCAFillModeForwards;
    curveAnimationGroup.removedOnCompletion = NO;
    curveAnimationGroup.delegate = self;
    [self.curveShapeLayer addAnimation:curveAnimationGroup forKey:@"curveAnimationGroup"];
}

//计时器监听方法(用于绘制波浪）y=Asin（ωx+φ）+h
- (void)doWaveAnimation:(CADisplayLink *)displayLink {
    
    _waveOffset+=_waveSpeed;
    
    //波浪总宽度
    CGFloat WIDTH = _circlePoint.x+20+20 - (_circlePoint.x-20-20);
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGFloat startY = 2*sinf(_waveOffset*M_PI/WIDTH);
    CGPathMoveToPoint(pathRef, NULL, 0, startY);
    for(CGFloat i = 0.0 ; i < WIDTH ; i++){
        CGFloat y = 2*sinf(i*_waveHeight*M_PI/WIDTH+_waveOffset*M_PI/WIDTH);
        CGPathAddLineToPoint(pathRef, NULL, i, y);
    }
    self.waveShapeLayer.path = pathRef;
    CGPathRelease(pathRef);
}

///完成动画
-(void)doFinishAnimation {
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    
    //变成勾勾动画
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    basicAnimation.fromValue = (__bridge id)[self curveBezierPath_finishChangeShape:0 leftValue:0 rightValue:0].CGPath;
    basicAnimation.toValue = (__bridge id)[self curveBezierPath_finishChangeShape:15 leftValue:9 rightValue:5].CGPath;
    basicAnimation.duration = 1;
    basicAnimation.fillMode = kCAFillModeForwards;
    basicAnimation.removedOnCompletion = NO;
    
    //缩放动画
    CAKeyframeAnimation *keyframeAnimation2 = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    keyframeAnimation2.values = @[
                                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 0)],
                                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 0)],
                                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 0)]];
    keyframeAnimation2.beginTime = basicAnimation.duration;
    keyframeAnimation2.duration = 0.85;
    keyframeAnimation2.fillMode = kCAFillModeForwards;
    keyframeAnimation2.removedOnCompletion = NO;
    
    animationGroup.animations = @[basicAnimation,keyframeAnimation2];
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    animationGroup.delegate = self;
    animationGroup.duration = keyframeAnimation2.beginTime+keyframeAnimation2.duration;
    [self.successShapeLayer addAnimation:animationGroup forKey:@"waveShapeLayerAnimationGroup"];
}

///显示进度动画
- (void)doShowProgressAnimation{
    [UIView animateWithDuration:1 animations:^{
        self.progressLabel.layer.transform = CATransform3DMakeScale(1.0, 1.0, 0);
    }];
}

- (void)setProgress:(CGFloat)progress {

    if (!_isLineAnimationStop) return;
    
    _progress  = progress;
    
    if(_progress >=1.0){
        
        _progress = 1.0;
        
        self.waveShapeLayer.opacity = 0;
        self.successShapeLayer.opacity = 1;
        
        [UIView animateWithDuration:1 animations:^{
            self.progressLabel.layer.transform = CATransform3DMakeScale(0, 0, 0);
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //下载完毕做完毕动画
            [self doFinishAnimation];
        });
        self.cicleShapeLayer.strokeEnd = _progress;
        self.progressLabel.text = [NSString stringWithFormat:@"  %.f%%",_progress*100];
    } else {
        //0-0.7之间，波浪幅度和速度不变
        if(_progress >=0.0 && _progress <= 0.7){
            _waveSpeed = 5;
            _waveHeight= 2.5;
            NSLog(@"%f,%f",_waveSpeed,_waveHeight);
            
        }else{//0.7-1之间，波浪幅度和速度逐渐递减，最后为0
            _waveSpeed = 5*(1-_progress)/0.3;
            _waveHeight = 2.5*(1-_progress)/0.3;
            NSLog(@"%f,%f",_waveSpeed,_waveHeight);
        }
        
        self.cicleShapeLayer.strokeEnd = _progress;
        self.progressLabel.text = [NSString stringWithFormat:@"  %.f%%",_progress*100];
    }
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if(anim == [self.curveShapeLayer animationForKey:@"curveAnimationGroup"]) {
        if(flag){
            NSLog(@"cureveAnimation end..");
            
            self.curveShapeLayer.opacity = 0;
            
            //开启定时器
            self.link.paused = NO; 1
            
            _isLineAnimationStop = YES;
        }
    } else if (anim == [self.lineShapeLayer animationForKey:@"lineAnimationGroup"]){
        if(flag){
            NSLog(@"lineAnimation end..");
        }
    } else if (anim == [self.successShapeLayer animationForKey:@"waveShapeLayerAnimationGroup"]){
        if(flag){
            NSLog(@"finishAnimation end..");
        }
    }
}

#pragma -mark - 贝塞尔曲线绘制
///改变竖线长度
-(UIBezierPath *)lineBezierPath_ChangeValue:(CGFloat)value{
    UIBezierPath *lineBezierPath = [UIBezierPath bezierPath];
    [lineBezierPath moveToPoint:CGPointMake(_circlePoint.x, _circlePoint.y-30*value)];
    [lineBezierPath addLineToPoint:CGPointMake(_circlePoint.x, _circlePoint.y+30*value)];
    return lineBezierPath;
}
///改变竖线位置（发射竖线）
-(UIBezierPath *)lineBezierPath_ChangePostion:(CGFloat)offsetY{
    UIBezierPath *lineBezierPath = [UIBezierPath bezierPath];
    [lineBezierPath moveToPoint:CGPointMake(_circlePoint.x, _circlePoint.y-offsetY)];
    [lineBezierPath addLineToPoint:CGPointMake(_circlePoint.x, _circlePoint.y-offsetY)];
    return lineBezierPath;
}
///改变曲线（从折线变成直线）
-(UIBezierPath *)curveBezierPath_changeValue:(CGFloat)value otherValue:(CGFloat)otherValue{
    UIBezierPath *curveBezierPath = [UIBezierPath bezierPath];
    [curveBezierPath moveToPoint:CGPointMake(_circlePoint.x-20, _circlePoint.y+10 + value)];
    [curveBezierPath addLineToPoint:CGPointMake(_circlePoint.x, _circlePoint.y+30 + value+otherValue)];
    [curveBezierPath addLineToPoint:CGPointMake(_circlePoint.x+20, _circlePoint.y+10 + value)];
    return curveBezierPath;
}
///改变曲线（从直线变成抛物线)
-(UIBezierPath *)curveBezierPath_Spring:(CGFloat)value{
    UIBezierPath *curveBezierPath = [UIBezierPath bezierPath];
    [curveBezierPath moveToPoint:CGPointMake(_circlePoint.x-20, _circlePoint.y)];
    [curveBezierPath addQuadCurveToPoint:CGPointMake(_circlePoint.x+20, _circlePoint.y) controlPoint:CGPointMake(_circlePoint.x, _circlePoint.y+value)];
    return curveBezierPath;
}
///改变曲线宽度
-(UIBezierPath *)curveBezierPath_changeLength:(CGFloat)value{
    UIBezierPath *curveBezierPath = [UIBezierPath bezierPath];
    [curveBezierPath moveToPoint:CGPointMake(_circlePoint.x-20-value, _circlePoint.y)];
    [curveBezierPath addLineToPoint:CGPointMake(_circlePoint.x+20+value, _circlePoint.y)];
    return curveBezierPath;
}
///加载完毕（勾勾)
-(UIBezierPath *)curveBezierPath_finishChangeShape:(CGFloat)value leftValue:(CGFloat)leftValue rightValue:(CGFloat)rightValue{
    UIBezierPath *curveBezierPath = [UIBezierPath bezierPath];
    [curveBezierPath moveToPoint:CGPointMake(-40+value+leftValue,-value+leftValue)];
    [curveBezierPath addLineToPoint:CGPointMake(0,value)];
    [curveBezierPath addLineToPoint:CGPointMake(40-value-rightValue,-value-rightValue)];
    return curveBezierPath;
}

@end
