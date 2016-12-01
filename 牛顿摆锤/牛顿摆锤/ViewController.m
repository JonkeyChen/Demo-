//
//  ViewController.m
//  牛顿摆锤
//
//  Created by 陈胜华 on 16/8/10.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "ViewController.h"
#import "NewTonShake.h"
#import "NewShake.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    NewTonShake *newTonShake = [[NewTonShake alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)/2.0)];
    newTonShake.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:newTonShake];
    
    NewShake *shake = [[NewShake alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(newTonShake.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(newTonShake.frame))];
    shake.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:shake];
}

@end
