//
//  SignNameViewController.m
//  电子签名
//
//  Created by 陈胜华 on 16/12/1.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "SignNameViewController.h"
#import "SignNameView.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface SignNameViewController ()
@property (nonatomic,strong) SignNameView *signView;
@end

@implementation SignNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *headerContent = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
    headerContent.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:headerContent];
    
    UIButton *etbtnCancle = [[UIButton alloc]init];
    etbtnCancle.frame = CGRectMake(15,20, 50, 20);
    [etbtnCancle setTitle:@"清除" forState:UIControlStateNormal];
    [etbtnCancle addTarget:self action:@selector(onClickCancle) forControlEvents:UIControlEventTouchUpInside];
    [headerContent addSubview:etbtnCancle];
    
    UIButton *etbtnFinish = [[UIButton alloc]init];
    etbtnFinish.frame = CGRectMake(ScreenWidth - 15 - 50, 20    , 50, 20);
    [etbtnFinish setTitle:@"完成" forState:UIControlStateNormal];
    [etbtnFinish addTarget:self action:@selector(onClickFinish) forControlEvents:UIControlEventTouchUpInside];
    [headerContent addSubview:etbtnFinish];
    
    self.signView = [[SignNameView alloc]initWithFrame:CGRectMake(0, 60, ScreenWidth, ScreenHeight - 60)];
    self.signView.currentImage = _signImage;
    self.signView.pathColor = [UIColor greenColor];
    [self.view addSubview:self.signView];
}

- (void)onClickCancle{
    [self.signView clear];
}
- (void)onClickFinish{
    if (_signBlock) {
        _signBlock(_signView.currentImage);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    NSLog(@"%s",object_getClassName(self));
}

@end
