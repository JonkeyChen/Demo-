//
//  ViewController.m
//  RunTime学习
//
//  Created by 陈胜华 on 16/8/12.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "ViewController.h"

#import "Person.h"
#import "User.h"
#import "NSObject+JSONExtension.h"
#import "Book.h"
#import "NSObject+Category.h"

static NSString *getDoucmentFilePath(NSString *fileName) {

    NSString *filePath = [[NSBundle mainBundle]pathForResource:fileName ofType:@"plist"];
    
    return filePath;
}

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self json];
    
    NSObject *obj = [[NSObject alloc]init];
    obj.numbers = @10;
    obj.name    = @"xxx";
}

/// 字典转模型demo
- (void)json {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"model.json" ofType:nil];
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:NULL];
    
    User *user = [User objectWithDict:json];
    Book *book = user.books[0];
    NSLog(@"%@",book.name);
}

/// 归解档demo
- (void)archiver {
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"temp.plist"];
    
    //    Person *person = [[Person alloc] init];
    
    // 归档
    //    person.name = @"人人";
    //    [NSKeyedArchiver archiveRootObject:person toFile:path];
    
    // 解档
    Person *person = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"%@",person.name);
    
    NSLog(@"%@",path);
}
@end
