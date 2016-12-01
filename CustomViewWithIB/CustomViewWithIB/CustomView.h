//
//  CustomView.h
//  CustomViewWithIB
//
//  Created by 陈胜华 on 16/8/10.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface CustomView : UIView

+ (CustomView*)initCustomView;

+ (CustomView *)initCustomView:(CGRect)frame;

@end
