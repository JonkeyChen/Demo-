//
//  DFChangeLabel.m
//  UILabel绚丽的渐变色
//
//  Created by 陈胜华 on 16/8/10.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "DFChangeLabel.h"

@interface DFChangeLabel ()

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) CAGradientLayer *gradientLayer;
@end

@implementation DFChangeLabel

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        // 创建 label 并显示文字,将其添加到 view 上.
        UILabel *label = [[UILabel alloc]init];
        self.label = label;
        label.text = @"ლ(′◉❥◉｀ლ),老婆";
        [self addSubview:label];
        // 创建渐变层
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        self.gradientLayer = gradientLayer;
        // 设置渐变色的颜色,随机颜色渐变
        gradientLayer.colors = @[(id)[self randomColor].CGColor,(id)[self randomColor].CGColor,(id)[self randomColor].CGColor];
        // 疑问:渐变层能不能加在label上
        // 不能，mask原理：默认会显示mask层底部的内容，如果渐变层放在mask层上，就不会显示了
        
        // 添加渐变层到控制器的view图层上
        [self.layer addSublayer:gradientLayer];
        // 利用定时器,切换渐变颜色
        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(textColorChange)];
        [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.label.text = title;
}

//2.2设置子控件的 frame 和图层的 frame
- (void)layoutSubviews {
    
    [super layoutSubviews];
    // 设置其尺寸.
    CGRect temp = self.label.frame;
    temp.size.width = self.frame.size.width;
    self.label.frame = temp;
    [self.label sizeToFit];
    self.label.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    self.gradientLayer.frame = self.label.frame;
    
    // mask层工作原理:按照透明度裁剪，只保留非透明部分，文字就是非透明的，因此除了文字，其他都被裁剪掉，这样就只会显示文字下面渐变层的内容，相当于留了文字的区域，让渐变层去填充文字的颜色。
    // 设置渐变层的裁剪层
    self.gradientLayer.mask = self.label.layer;
    
    // 注意:一旦把label层设置为mask层，label层就不能显示了,会直接从父层中移除，然后作为渐变层的mask层，且label层的父层会指向渐变层，这样做的目的：以渐变层为坐标系，方便计算裁剪区域，如果以其他层为坐标系，还需要做点的转换，需要把别的坐标系上的点，转换成自己坐标系上点，判断当前点在不在裁剪范围内，比较麻烦。
    // 父层改了，坐标系也就改了，需要重新设置label的位置，才能正确的设置裁剪区域。
    self.label.frame = self.gradientLayer.bounds;
}

// 设置随机颜色方法
- (UIColor *)randomColor{
    
    CGFloat r = arc4random_uniform(255)/255.0;
    CGFloat g = arc4random_uniform(255)/255.0;
    CGFloat b = arc4random_uniform(255)/255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

- (void)textColorChange
{
    
    if (_colors == nil) {
        self.gradientLayer.colors = @[(id)[self randomColor].CGColor,
                                      (id)[self randomColor].CGColor,
                                      (id)[self randomColor].CGColor,
                                      (id)[self randomColor].CGColor,
                                      (id)[self randomColor].CGColor];
        
    } else {
        NSMutableArray *colorArrays = [[NSMutableArray alloc]init];
        
        [_colors enumerateObjectsUsingBlock:^(UIColor * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            id color = (id)obj.CGColor;
            [colorArrays addObject:color];
        }];
        
        self.gradientLayer.colors = colorArrays;
    }
}

@end
