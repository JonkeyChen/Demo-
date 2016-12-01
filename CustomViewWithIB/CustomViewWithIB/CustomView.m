//
//  CustomView.m
//  CustomViewWithIB
//
//  Created by 陈胜华 on 16/8/10.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView


+ (CustomView *)initCustomView {
    return [[[NSBundle mainBundle]loadNibNamed:@"CustomView" owner:nil options:nil] firstObject];
}

+ (CustomView *)initCustomView:(CGRect)frame{
    
    CustomView *customView = [[[NSBundle mainBundle]loadNibNamed:@"CustomView" owner:nil options:nil] firstObject];
    
    customView.frame = frame;
    
    return customView;    
}

@end
