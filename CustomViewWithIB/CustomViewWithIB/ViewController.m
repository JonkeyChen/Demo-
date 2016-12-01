//
//  ViewController.m
//  CustomViewWithIB
//
//  Created by 陈胜华 on 16/8/10.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CustomView *v = [CustomView initCustomView:CGRectMake(0, 64, 375, 200)];

    [self.view addSubview:v];
    
}

@end
