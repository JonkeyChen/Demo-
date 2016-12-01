//
//  CustomView.h
//  DeallocTest1
//
//  Created by 陈胜华 on 16/11/18.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CustomBlock)();

@interface CustomView : UIView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title withBlock:(CustomBlock)block;

@end
