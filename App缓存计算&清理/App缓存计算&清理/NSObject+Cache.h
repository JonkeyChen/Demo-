//
//  NSObject+Cache.h
//  App缓存计算&清理
//
//  Created by 陈胜华 on 16/10/25.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (Cache)

/*!
 *  @brief 计算缓存大小（以M为单位）
 *
 *  @return 大小
 */
+ (CGFloat)calculateCache;

/*!
 *  @brief 清除缓存
 *
 *  @return 成功/失败
 */
+ (BOOL)removeCache;

@end
