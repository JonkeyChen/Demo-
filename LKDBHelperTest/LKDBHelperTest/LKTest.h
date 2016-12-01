    //
//  LKTest.h
//  LKDBHelperTest
//
//  Created by 陈胜华 on 16/8/18.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LKDBHelper.h>
#import "LKTestForeign.h"


#import <UIKit/UIKit.h>

@interface LKTest : NSObject

@property(copy,nonatomic)NSString* name;
@property NSUInteger  age;
@property BOOL isGirl;

@property(strong,nonatomic)LKTestForeign* address;
@property(strong,nonatomic)NSArray* blah;
@property(strong,nonatomic)NSDictionary* hoho;

@property(nonatomic,strong) NSURL *url;


@property char like;

@property (nonatomic,strong) UIImage *img ;
@property (nonatomic,strong) NSDate *date ;
@property (nonatomic,strong) UIColor *color;
@property (nonatomic,copy) NSString *error ;
@property (nonatomic,assign) NSTimeInterval score;
@property (nonatomic,copy  ) NSData *data ;


//1.获取新闻数据库地址
+ (LKDBHelper *)getStockNewsLKDBHelper;
//2.插入新闻数据库
+ (void)insertToStockNewsDB:(LKTest *)model;
//3.查询新闻数据库
+ (NSMutableArray *)selectStockNewsWithWhere:(id)where orderBy:(NSString *)orderBy;
//4、更新数据库，返回值bool类型
+ (BOOL)upDateToHistoryDBSet:(NSString *)set where:(id)where;

@end
