//
//  ViewController.m
//  DeallocTest1
//
//  Created by 陈胜华 on 16/11/18.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeStart:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [timer fire];
    
    CustomView *customView = [[CustomView alloc]initWithFrame:CGRectMake(20, 0, 100, 20) title:@"标题" withBlock:^{
        
        NSLog(@"customView");
    }];
    customView.center = self.view.center;
    
    [self.view addSubview:customView];
}

- (void)viewWillDisappear:(BOOL)animated {

}

- (void)timeStart:(NSTimer*)timer {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
