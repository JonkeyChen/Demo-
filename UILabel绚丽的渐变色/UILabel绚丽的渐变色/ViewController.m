//
//  ViewController.m
//  UILabel绚丽的渐变色
//
//  Created by 陈胜华 on 16/8/10.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "ViewController.h"
#import "DFChangeLabel.h"

@interface ViewController (){
    UIImageView *v;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DFChangeLabel *dfChnageLable = [[DFChangeLabel alloc]initWithFrame:CGRectMake(10, 164, [UIScreen mainScreen].bounds.size.width-20, 40)];
    //dfChnageLable.colors = @[[UIColor redColor],[UIColor  greenColor],[UIColor  greenColor]];
    dfChnageLable.title = @"骚年转动吧!!!";
    [self.view addSubview:dfChnageLable];
    
//    v = [[UIImageView alloc]init];
//    v.frame = CGRectMake(10, 205, 77, 55);
//    v.image = [UIImage imageNamed:@"1"];
//    [self.view addSubview:v];
//    
//    // 利用定时器,切换渐变颜色
//    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(imageFrameChange)];
//    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)imageFrameChange{
    
    CGRect frame = v.frame;
        
    if (frame.origin.y == 205) {
        frame.origin.y += 2;
    } else {
        frame.origin.y -= 2;
    }
    [v setFrame:frame];
}

@end
