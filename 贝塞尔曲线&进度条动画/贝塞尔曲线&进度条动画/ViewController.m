//
//  ViewController.m
//  贝塞尔曲线&进度条动画
//
//  Created by 陈胜华 on 16/8/11.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "ViewController.h"
#import "DFBezierPathView.h"

@interface ViewController ()
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) DFBezierPathView *loadingView;;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.timer = nil;
    
    self.loadingView = nil;
    
    self.loadingView = ({
        DFBezierPathView *loadingView = [[DFBezierPathView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
        [loadingView setCenter:self.view.center];
        [self.view addSubview:loadingView];
        loadingView;
    });
    [self.loadingView startAnimation];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(progressLoading:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)progressLoading:(NSTimer*)timer{
    
    if (self.loadingView.progress >= 1.0){
        
        [timer invalidate];
        
        self.loadingView.progress += 1.0;
        
    } else {
        self.loadingView.progress += 0.01;
    }
}

@end
