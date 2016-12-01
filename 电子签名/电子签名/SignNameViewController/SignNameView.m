//
//  SignNameView.m
//  电子签名
//
//  Created by 陈胜华 on 16/12/1.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "SignNameView.h"
#import "SignBezierPath.h"



@interface SignNameView ()

@property (nonatomic,  weak) UIBezierPath   *path;
@property (nonatomic,strong) NSMutableArray *pathArray;

@end

@implementation SignNameView

- (NSMutableArray *)pathArray {
    if (!_pathArray) {
        _pathArray = [[NSMutableArray alloc]init];
    }
    return _pathArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _pathColor = [UIColor redColor];
        _width     = 2 ;
        self.backgroundColor = [UIColor whiteColor];
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:panGesture];
    }
    return self;
}

- (void)setPathColor:(UIColor *)pathColor {
    _pathColor = pathColor;
}

- (void)setCurrentImage:(UIImage *)currentImage {
    _currentImage = currentImage;
    if (_currentImage != nil) {
        [self.pathArray addObject:currentImage];
    }
}

///移动手指，记录移动的的CGPoint ,将这些CGPoint添加到path上
- (void)pan:(UIPanGestureRecognizer*)gesture {
    CGPoint currentPoint = [gesture locationInView:self];
    if (gesture.state == UIGestureRecognizerStateBegan) {
        //开始状态
        SignBezierPath *path = [SignBezierPath bezierPath];
        path.color = _pathColor ;
        [path setLineWidth:_width];
        [path setLineJoinStyle:kCGLineJoinRound];
        [path setLineCapStyle:kCGLineCapRound];
        [path moveToPoint:currentPoint];
        self.path = path;
        [self.pathArray addObject:self.path];
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        //移动状态
        [self.path addLineToPoint:currentPoint];
        [self setNeedsDisplay];
    }
}

///绘制路径
- (void)drawRect:(CGRect)rect {
    for (SignBezierPath *path in self.pathArray) {
        if ([path isKindOfClass:[UIImage class]]) {
            UIImage *image = (UIImage*)path;
            [image drawInRect:rect];
        } else {
            [path.color set];
            [path stroke];
        }
    }
    //实时获取当前 size内容的图片
    _currentImage = [self saveDrawToImageObject:self];
}

///暂时可以不用上，保存当前图片(如果考虑性能，则最后完成后，再保存当前size为一张图片；如果不考虑性能，则实时的将size转化为对应的图片)
- (void)save {
    _currentImage = [self saveDrawToImageObject:self];
}
///清空内容
- (void)clear {
    [self.pathArray removeAllObjects];
    [self setNeedsDisplay];
}

///将UIView的内容生成一张图片
- (UIImage*)saveDrawToImageObject:(UIView*)contentView {
    UIGraphicsBeginImageContextWithOptions(contentView.bounds.size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //将UIView的内容渲染到上下文中
    [contentView.layer renderInContext:ctx];
    //从上下文中生成一张图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if (_pathArray.count == 0) {//数组元为空，则表示没有绘制过图片
        return nil;
    }
    return newImage;
}

@end
