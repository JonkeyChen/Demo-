//
//  ViewController.m
//  电子签名
//
//  Created by 陈胜华 on 16/12/1.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "ViewController.h"
#import "SignNameViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *etbtn;

@property (nonatomic,strong) UIImage *signImage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [_etbtn addTarget:self action:@selector(onClickSign:) forControlEvents:UIControlEventTouchDown];
}

- (void)onClickSign:(UIButton*)sender {
    SignNameViewController *signVC = [[SignNameViewController alloc]init];
    signVC.signImage = _signImage;
    signVC.signBlock = ^(UIImage* image) {
        _signImage = image;
        if (image) {
            [_etbtn setTitle:@"" forState:UIControlStateNormal];
            [_etbtn setBackgroundImage:image forState:UIControlStateNormal];
        } else {
            [_etbtn setBackgroundImage:image forState:UIControlStateNormal];
            [_etbtn setTitle:@"点击签署你的姓名" forState:UIControlStateNormal];
        }
    };
    [self presentViewController:signVC animated:YES completion:nil];
}

@end
