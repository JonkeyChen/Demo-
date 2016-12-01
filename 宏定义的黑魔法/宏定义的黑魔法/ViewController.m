//
//  ViewController.m
//  宏定义的黑魔法
//
//  Created by 陈胜华 on 16/8/8.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "ViewController.h"

//对象宏
#define My_PI 3.14159265358979323846264338327950288
//函数宏
#define Puls(x,y) (x+y)

#define Min(A,B) A>B?B:A

#define NSLogRect(rect)   NSLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define NSLogSize(size)   NSLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define NSLogPoint(point) NSLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)

static NSInteger funPlus(CGFloat x,CGFloat y) {
    return x + y;
}

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    NSLog(@"%.2f",My_PI*Puls(3, 5));
    NSLog(@"%lu",funPlus(3, 5));
//    NSLog(@"%d",MAX(6, 5));
//
//    NSLogRect(self.view.frame);
    
//    NSString *string =@"www.ABCDEFGHIJKLMN.com.cn";
    //取0~第7-1个
//    NSString *string1 = [string substringToIndex:7];
//    NSLog(@"%@",string1);
    //取第7个~结尾
//    NSString *string2 = [string substringFromIndex:7];
//    NSLog(@"%@",string2);
    //取第4个后面的长度为2的字符
//    NSString *string3 = [string substringWithRange:NSMakeRange(4, 2)];
//    NSLog(@"%@",string3);
    
    //判断字符串是否包含字符串，可以用来判断文件类型
//    if ([string hasPrefix:@"www."]) {//前
//        NSLog(@"字符串前面包含(www.)");
//    }
//
//    if ([string hasSuffix:@".com.cn"]) {//后
//        NSLog(@"字符串后面包含(.com.cn)");
//    }
//    
//    if ([string rangeOfString:@"ABC"].location != NSNotFound) {
//        NSLog(@"这个字符串中有ABC");
//    }
    
//    NSString *string = @"www.&A&B&C&D&E&F&G";
//    //将字符串以“&”为分割线，分割成数组
//    NSArray *separateElementsArray = [string componentsSeparatedByString:@"&"];
//    NSLog(@"\n%@",separateElementsArray);
//    //将数组元素拼接成字符串
//    NSString *string1 = [separateElementsArray componentsJoinedByString:@""];
//    NSLog(@"%@",string1);
    
//    NSLog(@"=================设备相关信息的获取========================");
//    //1.设备相关信息的获取
//    NSString *strName = [[UIDevice currentDevice] name];
//    NSLog(@"设备名称：%@", strName);//e.g. "My iPhone"
//    NSString *strId = [[UIDevice currentDevice] identifierForVendor].UUIDString;
//    NSLog(@"设备唯一标识：%@", strId);//UUID,5.0后不可用
//    NSString *strSysName = [[UIDevice currentDevice] systemName];
//    NSLog(@"系统名称：%@", strSysName);// e.g. @"iOS"
//    NSString *strSysVersion = [[UIDevice currentDevice] systemVersion];
//    NSLog(@"系统版本号：%@", strSysVersion);// e.g. @"4.0"
//    NSString *strModel = [[UIDevice currentDevice] model];
//    NSLog(@"设备模式：%@", strModel);// e.g. @"iPhone", @"iPod touch"
//    NSString *strLocModel = [[UIDevice currentDevice] localizedModel];
//    NSLog(@"本地设备模式：%@", strLocModel);// localized version of model
//    
//    NSLog(@"==================app应用相关信息的获取=======================");
//    
//    //2.NSBundle
//    //app应用相关信息的获取
//    NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];
//    NSString *strAppName = [dicInfo objectForKey:@"CFBundleDisplayName"];
//    NSLog(@"App应用名称：%@", strAppName);
//    NSString *strAppVersion = [dicInfo objectForKey:@"CFBundleShortVersionString"];
//    NSLog(@"App应用版本：%@", strAppVersion);
//    NSString *strAppBuild = [dicInfo objectForKey:@"CFBundleVersion"];
//    NSLog(@"App应用Build版本：%@", strAppBuild);
//    
//    NSLog(@"==================获取用户的本地化信息设置=======================");
//    
//    //3. NSLocale可以获取用户的本地化信息设置，例如货币类型，国家，语言，数字，日期格式的格式化，提供正确的地理位置显示等等
//    NSArray *languageArray = [NSLocale preferredLanguages];
//    NSString *language = [languageArray objectAtIndex:0];
//    NSLog(@"语言：%@", language);//en
//    NSLocale *locale = [NSLocale currentLocale];
//    NSString *country = [locale localeIdentifier];
//    NSLog(@"国家：%@", country); //en_US
}

@end
