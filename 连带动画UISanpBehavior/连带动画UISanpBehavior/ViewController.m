//
//  ViewController.m
//  连带动画UISanpBehavior
//
//  Created by 陈胜华 on 16/8/10.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong) UIView            *squareView;
@property (nonatomic,strong) UISnapBehavior    *snapBehavior;
@property (nonatomic,strong) UIDynamicAnimator *animator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createSmallSquareView];
    [self createGestureRecognizer];
    [self createAnimatorAndBehaviors];
}

//1.初始化基本控件
- (void) createSmallSquareView{
    UIView *squareView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 80.0f, 80.0f)];
    self.squareView = squareView;
    self.squareView.backgroundColor = [UIColor greenColor];
    self.squareView.center = self.view.center;
    [self.view addSubview:self.squareView];
}

//2.添加手势给控制器view
- (void) createGestureRecognizer{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(snapTap:)];
    [self.view addGestureRecognizer:tap];
}

//3.执行手势监听方法
- (void)snapTap:(UITapGestureRecognizer *)paramTap{
    CGPoint tapPoint = [paramTap locationInView:self.view];
    if (self.snapBehavior != nil){
        [self.animator removeBehavior:self.snapBehavior];
    }
    self.snapBehavior = [[UISnapBehavior alloc] initWithItem:self.squareView snapToPoint:tapPoint];
    self.snapBehavior.damping = 0.2f;  //剧列程度
    [self.animator addBehavior:self.snapBehavior];
}

//4.对于连带动画必须在初始化的时候进行设置,负责动画不会被执行
- (void) createAnimatorAndBehaviors{
    self.animator     = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.snapBehavior = [[UISnapBehavior alloc] initWithItem:self.squareView snapToPoint:self.squareView.center];
    self.snapBehavior.damping = 0.5f; /* Medium oscillation */
    [self.animator addBehavior:self.snapBehavior];
}

@end
