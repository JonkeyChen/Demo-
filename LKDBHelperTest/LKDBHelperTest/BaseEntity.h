//
//  BaseEntity.h
//  LKDBHelperTest
//
//  Created by 陈胜华 on 16/8/18.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LKDBHelper.h>

@interface BaseEntity : NSObject

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (LKDBHelper *)getUsingLKDBHelper;

@end