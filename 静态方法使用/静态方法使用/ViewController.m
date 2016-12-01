//
//  ViewController.m
//  静态方法使用
//
//  Created by 陈胜华 on 16/8/5.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "ViewController.h"

/*!
 *  @brief 格式化时间数值（60秒）为时间格式显示（01:00）
 *
 *  @param seconds 时间数值
 *  @param isLeft  是否为倒计时
 *
 *  @return String
 */
static NSString * formatTimeInterval(CGFloat seconds, BOOL isLeft)
{
    seconds = MAX(0, seconds);
    
    NSInteger s = seconds;
    NSInteger m = s / 60;
    NSInteger h = m / 60;
    
    s = s % 60;
    m = m % 60;
    
    NSMutableString *format = [(isLeft && seconds >= 0.5 ? @"-" : @"") mutableCopy];
    if (h != 0) {
        [format appendFormat:@"%lu:%0.2lu", h, m];
    } else {
        [format appendFormat:@"%lu", m];
    }
    [format appendFormat:@":%0.2lu", s];
    
    return format;
}

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *timeString = formatTimeInterval(100,NO);
    
    NSLog(@"右边 = %@",timeString);
    NSLog(@"左边 = %@",formatTimeInterval(100,YES));
}

@end
