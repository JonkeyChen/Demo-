//
//  UICircleSlider.h
//  homer
//
//  Created by yu dezhi on 7/3/16.
//  Copyright (c) 2016 Quatanium Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface UICircleSlider : UIControl

///当前值
@property (nonatomic) IBInspectable NSInteger currentValue;
///外圈半斤
@property (nonatomic) IBInspectable double innerCircleRadius;
///内圈小圆半斤
@property (nonatomic) IBInspectable double outerCircleRadius;

- (void)initUICircleSliderWithTotalNum:(NSInteger)totalNum drawNum:(NSInteger)drawNum startAngle:(double)startAngle numScale:(NSInteger)numScale innerCircleDiameter:(double)innerCircleDiameter;

@end
