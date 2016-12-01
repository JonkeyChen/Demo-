//
//  UIEView.m
//  IB_DESIGNABLE_Test
//
//  Created by 陈胜华 on 16/8/3.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "UIEView.h"

@implementation UIEView

- (instancetype)init {
    if (self = [super init]) {
        [self setConfigure];
        NSLog(@"%@", NSStringFromClass([self class]));
        NSLog(@"%@", NSStringFromClass([super class]));
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setConfigure];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setConfigure];;
    }
    return self;
}

- (void)setConfigure {
    
}

- (void)setCorner:(CGFloat)corner {
    _corner = corner;
    if (corner > 0) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius  = _corner;
        [self setNeedsLayout];
    }
}

- (void)setBoardWidth:(CGFloat)boardWidth {
    _boardWidth = boardWidth;
    
    if (boardWidth > 0) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius  = _corner;
        self.layer.borderWidth   = boardWidth;
        [self setNeedsLayout];
    }
}

- (void)setBoardColor:(UIColor *)boardColor {
    _boardColor = boardColor;
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius  = _corner;
    self.layer.borderWidth   = _boardWidth;
    self.layer.borderColor   = boardColor.CGColor;
    [self setNeedsLayout];
}

@end
