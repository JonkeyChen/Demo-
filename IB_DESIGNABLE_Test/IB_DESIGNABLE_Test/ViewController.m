//
//  ViewController.m
//  IB_DESIGNABLE_Test
//
//  Created by 陈胜华 on 16/8/3.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "ViewController.h"
#import "UICircleSlider.h"
#import "UIEView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UICircleSlider *circleSlider;


@end

@implementation ViewController

- (IBAction)onClick:(id)sender {
}
- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIEView *v = [[UIEView alloc]init];
    
    [self.view addSubview:v];
    
}


@end
