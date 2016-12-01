//
//  BaseEntity.m
//  LKDBHelperTest
//
//  Created by 陈胜华 on 16/8/18.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "BaseEntity.h"

#define DB_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"BaseEntity.db"]]

@implementation BaseEntity

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {

    }
    return self;
}

//重载选择 使用的LKDBHelper
+(LKDBHelper *)getUsingLKDBHelper
{
    static LKDBHelper* db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#if TARGET_IPHONE_SIMULATOR//模拟器
        
        db = [[LKDBHelper alloc] initWithDBPath:DB_PATH];
        
#elif TARGET_OS_IPHONE//真机
        
        db = [[LKDBHelper alloc] initWithDBName:@"xx"];
        
#endif
        
    });
    return db;
}

//在类 初始化的时候
+(void)initialize
{
    //remove unwant property
    //比如 getTableMapping 返回nil 的时候   会取全部属性  这时候 就可以 用这个方法  移除掉 不要的属性
    [self removePropertyWithColumnName:@"error"];
}

@end
