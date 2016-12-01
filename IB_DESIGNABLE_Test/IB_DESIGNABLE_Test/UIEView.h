//
//  UIEView.h
//  IB_DESIGNABLE_Test
//
//  Created by 陈胜华 on 16/8/3.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface UIEView : UIView

@property(nonatomic,assign) IBInspectable CGFloat corner;
@property(nonatomic,assign) IBInspectable CGFloat boardWidth;
@property(nonatomic,assign) IBInspectable UIColor *boardColor;

@end
