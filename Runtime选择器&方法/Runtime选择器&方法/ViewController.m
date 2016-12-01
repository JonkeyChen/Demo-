//
//  ViewController.m
//  Runtime选择器&方法
//
//  Created by 陈胜华 on 16/8/15.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    SEL sel = @selector(method);
    
    NSLog(@"sel : %p",sel);
    
}

- (void)method {
    
}

@end
