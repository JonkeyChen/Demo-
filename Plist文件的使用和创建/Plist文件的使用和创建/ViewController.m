//
//  ViewController.m
//  Plist文件的使用和创建
//
//  Created by 陈胜华 on 16/8/12.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "ViewController.h"

static NSString *getDoucmentPathWithName(NSString *fileName) {
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[path objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",fileName]];
    return filePath;
}

static NSString *wirteToTempFileName(NSString*fileName ,id dataSource){
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[path objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",fileName]];
    
    if ([dataSource isKindOfClass:[NSDictionary class]]) {
        [dataSource writeToFile:filePath atomically:YES];
        return filePath;
    } else if ([dataSource isKindOfClass:[NSArray class]]) {
        [dataSource writeToFile:filePath atomically:YES];
        return filePath;
    }
    return nil;
}

static id readDataFromBundle(NSString*fileName,NSString *filePath) {
    
    if (filePath) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        
        id jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        return jsonData;
        
    } else if (fileName && !filePath) {
        NSString *filePath_ = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
        
        if (fileName) {
            NSData *data = [NSData dataWithContentsOfFile:filePath_];
            
            id jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            return jsonData;
        }
    }
    
    return nil;
}

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self readSystemPlistFiles];
    
    [self createPlistFilesByCode];
}

/*!
 *  @brief 创建的plist文件&&读取
 */
- (void)readSystemPlistFiles{
    //1.创建步骤，Command+N -> 选择Resource --> PropertyPlist --> xx（文件名）.plist
    //2.设置plist文件结构(.plist文件的实质就是一个json数据的容器)
    //3.读取文件
    //3.1获取已有完整路径
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Resource" ofType:@"plist"];
    //3.2根据文件路径读取json数据,注意：如果Root是NSArray结构，就用NSArray读取接收；如果是NSDictory,就用NSDictory读取接收
    NSArray *resourcePlist = [NSArray arrayWithContentsOfFile:plistPath];
    NSLog(@"%@",resourcePlist);
}



/*!
 *  @brief 代码创建plist文件
 */
- (void)createPlistFilesByCode {
    //1.读取文件路径
    NSString *filePath = getDoucmentPathWithName(@"PropertyList");
    
    //2.根据文件路径，读取接收数据
    NSMutableArray<NSDictionary*> *resourcePlist = [[NSMutableArray alloc]initWithContentsOfFile:filePath];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc ] init];
    [dic setObject:@"总管达人" forKey:@"name"];
    [dic setObject:@"123456" forKey:@"password"];
    [resourcePlist addObject:dic];
    
    //3.写入文件
    [resourcePlist writeToFile:filePath atomically:YES];
    
    NSLog(@"%@",resourcePlist);
}


@end
