//
//  ViewController.m
//  Runtime动态添加View手势
//
//  Created by 陈胜华 on 16/8/15.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Gesture.h"

@interface ViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIButton *ebtnLogin;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.view setTapActionWithBlock:^(UITapGestureRecognizer *gesture) {
        NSLog(@"%@",gesture);
    }];
    
    [self.view setPinchActionWithBlock:^(UIPinchGestureRecognizer *pinchGesture) {
        NSLog(@"%@",pinchGesture);
    }];
    
    _ebtnLogin = ({
        UIButton *etbtn = [[UIButton alloc]init];
        [etbtn setBackgroundColor:[UIColor greenColor]];
        etbtn.frame = CGRectMake(10, 100, 100, 100);
        [self.view addSubview:etbtn];
        etbtn;
    });
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}

@end
