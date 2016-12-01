//
//  MyClass.h
//  ExampleRuntime
//
//  Created by 陈胜华 on 16/8/15.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyClass : NSObject <NSCopying, NSCoding>

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, copy) NSString *string;

- (void)method1;

- (void)method2;

+ (void)classMethod1;

@end
