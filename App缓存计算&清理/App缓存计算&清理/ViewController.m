//
//  ViewController.m
//  App缓存计算&清理
//
//  Created by 陈胜华 on 16/8/12.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    CGFloat size = [self calculateCache];
    
    UIImageView *imagev = [[UIImageView alloc]init];
    imagev.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width);
    imagev.image = [UIImage imageNamed:@"2"];
    [self.view addSubview:imagev];
    
    NSLog(@"%.2f",size);
}

//计算缓存大小
- (CGFloat)calculateCache{
    CGFloat folderSize = 0;
    //获取路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)firstObject];
    //获取所有文件的数组
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    NSLog(@"文件数：%ld",files.count);
    for(NSString *path in files) {
        NSString*filePath = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",path]];
        //累加
        folderSize += [[NSFileManager defaultManager]attributesOfItemAtPath:filePath error:nil].fileSize;
    }
    //转换为M为单位
    CGFloat sizeM = folderSize /1024.0/1024.0;
    return sizeM;
}


//清除缓存
- (void)removeCache{
    //获取路径
    NSString*cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)objectAtIndex:0];
    //返回路径中的文件数组
    NSArray*files = [[NSFileManager defaultManager]subpathsAtPath:cachePath];
    NSLog(@"文件数：%ld",[files count]);
    for(NSString *p in files){
        NSError*error;
        NSString*path = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",p]];
        if([[NSFileManager defaultManager]fileExistsAtPath:path]) {
            BOOL isRemove = [[NSFileManager defaultManager]removeItemAtPath:path error:&error];
            if(isRemove) {
                NSLog(@"清除成功");
            } else {
                NSLog(@"清除失败");
            } 
        }
    }
}

@end
