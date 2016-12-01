//
//  DFButton.m
//  iOS登录动画
//
//  Created by 陈胜华 on 16/8/31.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "DFButton.h"

@interface DFButton ()

//渲染层
@property (nonatomic,strong) CAShapeLayer *maskLayer;

@property (nonatomic,strong) CAShapeLayer *shapeLayer;

@property (nonatomic,strong) CAShapeLayer *loadingLayer;

@property (nonatomic,strong) CAShapeLayer *clickCicrleLayer;

@property (nonatomic,strong) UIButton *button;

@end

@implementation DFButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

@end
