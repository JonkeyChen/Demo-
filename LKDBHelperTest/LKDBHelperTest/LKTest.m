//
//  LKTest.m
//  LKDBHelperTest
//
//  Created by 陈胜华 on 16/8/18.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "LKTest.h"

@implementation LKTest

//1.获取新闻数据库地址
+ (LKDBHelper *)getStockNewsLKDBHelper {
    
    static LKDBHelper* db;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        NSString* dbpath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/LKTest.db"];
        
        db = [[LKDBHelper alloc]initWithDBPath:dbpath];
        
    });
    
    return db;
}

//2.插入新闻数据库
+ (void)insertToStockNewsDB:(LKTest *)model {
    
    LKDBHelper*globalHelper = [LKTest getStockNewsLKDBHelper];
    
    //保存到数据库
    
    [globalHelper insertToDB:model];
    
}

//3.查询新闻数据库
+ (NSMutableArray *)selectStockNewsWithWhere:(id)where orderBy:(NSString *)orderBy {
    
    LKDBHelper* globalHelper = [LKTest getStockNewsLKDBHelper];
    
    NSMutableArray *array = [globalHelper search:[LKTest class] where:where orderBy:orderBy offset:0 count:0];
    
    return array;
}

//4、更新数据库，返回值bool类型
+ (BOOL)upDateToHistoryDBSet:(NSString *)set where:(id)where{
    
    LKDBHelper* globalHelper = [LKTest getStockNewsLKDBHelper];
    
    //更新数据库
    
    BOOL isUpdate = [globalHelper updateToDB:[LKTest class] set:set where:where];
    
    return isUpdate;
}



+(NSString *)getTableName{
    
    return @"LKTestTable";
}

@end
