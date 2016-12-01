//
//  CustomView.m
//  DeallocTest1
//
//  Created by 陈胜华 on 16/11/18.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "CustomView.h"

@interface CustomView ()

@property (nonatomic,copy ) CustomBlock tapBlock;

@end

@implementation CustomView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title withBlock:(CustomBlock)block{
    
    if (self = [super initWithFrame:frame]) {
        
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(0, 0, CGRectGetWidth(frame)/2.0, CGRectGetHeight(frame));
        label.clipsToBounds = YES;
        label.text = title;
        label.backgroundColor = [UIColor orangeColor];
        [self addSubview:label];
        
        self.backgroundColor = [UIColor greenColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapContentView:)];
        [self addGestureRecognizer:tap];
        
        _tapBlock = block;
    }
    
    return self;
}

- (void)tapContentView:(UITapGestureRecognizer*)tap {
    
    if (_tapBlock) {
        
        _tapBlock();
    }
}

@end
