//
//  SaleEntity.m
//  JSON转Model库测试
//
//  Created by 陈胜华 on 16/8/17.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "SaleEstateYYModelEntity.h"

@implementation SaleResultEntity

@end

@implementation SaleEstateYYModelEntity

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"Result" : [SaleResultEntity class]
             };
}


@end
