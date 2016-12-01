//
//  DFChangeLabel.h
//  UILabel绚丽的渐变色
//
//  Created by 陈胜华 on 16/8/10.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DFChangeLabel : UIView

@property (nonatomic,copy) NSString *title;

@property (nonatomic,strong) NSArray<UIColor*> *colors;

@end
