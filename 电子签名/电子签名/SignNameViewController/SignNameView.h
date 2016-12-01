//
//  SignNameView.h
//  电子签名
//
//  Created by 陈胜华 on 16/12/1.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignNameView : UIView

///字体颜色
@property (nonatomic,strong) UIColor *pathColor;//defalut color is redColor
///字体大小
@property (nonatomic,assign) CGFloat width; //defalut = 2
///当前图片Image对象
@property (nonatomic,strong) UIImage *currentImage;
///清空内容
- (void)clear;

@end
