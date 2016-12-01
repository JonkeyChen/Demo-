//
//  ViewController.m
//  JSON转Model库测试
//
//  Created by 陈胜华 on 16/8/17.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "ViewController.h"
#import "YYModel.h"
#import "SaleEstateYYModelEntity.h"
#import "SaleEstateMantleEntity.h"
#import "MTLJSONAdapter.h"
#import "SaleEstateMJEntity.h"
#import "SaleEstateEntity.h"



@interface ViewController (){
    NSTimeInterval _timeStart;
    NSTimeInterval _timeEnd;
}
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInteger cycleTimes       = 10;//循环次数
    NSTimeInterval totleTime   = 0;//总时间
    NSTimeInterval averageTime = 0;//平均时间
    
    NSDictionary *jsonData = [NSDictionary dictionaryWithContentsOfFile:@"/Users/Jonkey/Desktop/DemoSets/JSON转Model库测试/JSON转Model库测试/DataSource.plist"];
    //NSLog(@"%@",jsonData);

    NSLog(@"===============YYModel=======================");
    for (int i = 0; i < cycleTimes ; i++) {
        _timeStart = [self getCurSystemTimeInterval];
        SaleEstateYYModelEntity *saleEntity = [SaleEstateYYModelEntity yy_modelWithJSON:jsonData];
        _timeEnd   = [self  getCurSystemTimeInterval];
        //NSLog(@"YYModel转换时间: %f毫秒",_timeEnd -  _timeStart);
        totleTime  += _timeEnd -  _timeStart;
    }
    averageTime = totleTime/cycleTimes;
    NSLog(@"|| 循环次数:%lu",cycleTimes);
    NSLog(@"|| 总时间 :%f毫秒",totleTime);
    NSLog(@"|| 平均装换时间:%f\n\n",averageTime);

    /*******************************************************/
    
    NSLog(@"===============Mantle=======================");
    totleTime = 0;
    for (int i = 0; i < cycleTimes ; i++) {
        _timeStart = [self getCurSystemTimeInterval];
        SaleEstateMantleEntity *saleEntity = [MTLJSONAdapter modelOfClass:[SaleEstateMantleEntity class]
                                                       fromJSONDictionary:jsonData
                                                                    error:nil];
        _timeEnd   = [self  getCurSystemTimeInterval];
        //NSLog(@"Mantle转换换时间: %f毫秒",_timeEnd -  _timeStart);
        totleTime  += _timeEnd -  _timeStart;
    }
    averageTime = totleTime/cycleTimes;
    NSLog(@"|| 循环次数:%lu",cycleTimes);
    NSLog(@"|| 总时间 :%f毫秒",totleTime);
    NSLog(@"|| 平均装换时间:%f\n\n",averageTime);
    
    /*******************************************************/
    
    NSLog(@"===============MJExtersion==================");
    totleTime = 0;
    for (int i = 0; i < cycleTimes ; i++) {
        _timeStart = [self getCurSystemTimeInterval];
        SaleEstateMJEntity *saleEntity = [SaleEstateMJEntity mj_objectWithKeyValues:jsonData];
        _timeEnd   = [self  getCurSystemTimeInterval];
        //NSLog(@"MJExtersion转换换时间: %f毫秒",_timeEnd -  _timeStart);
        totleTime  += _timeEnd -  _timeStart;
    }
    averageTime = totleTime/cycleTimes;
    NSLog(@"|| 循环次数:%lu",cycleTimes);
    NSLog(@"|| 总时间 :%f毫秒",totleTime);
    NSLog(@"|| 平均装换时间:%f\n\n",averageTime);
    
    
    /*******************************************************/
    
    NSLog(@"===============Custom==================");
    totleTime = 0;
    for (int i = 0; i < cycleTimes ; i++) {
        _timeStart = [self getCurSystemTimeInterval];
        SaleEstateEntity *saleEntity = [SaleEstateEntity encoderCode:jsonData];
        _timeEnd   = [self  getCurSystemTimeInterval];
        //NSLog(@"MJExtersion转换换时间: %f毫秒",_timeEnd -  _timeStart);
        totleTime  += _timeEnd -  _timeStart;
        
        [saleEntity.result enumerateObjectsUsingBlock:^(SaleEstateResultEntity * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //NSLog(@"%d,%d,%@",obj.isFollow,obj.isTop,obj.address);
        }];
    }
    averageTime = totleTime/cycleTimes;
    NSLog(@"|| 循环次数:%lu",cycleTimes);
    NSLog(@"|| 总时间 :%f毫秒",totleTime);
    NSLog(@"|| 平均装换时间:%f\n\n",averageTime);
}

///获取当前时间的时间戳（毫秒）
- (NSTimeInterval)getCurSystemTimeInterval{
    NSTimeInterval dateInterval = [[NSDate date] timeIntervalSince1970] * 1000;
    return dateInterval;
}

@end
