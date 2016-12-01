//
//  SignNameViewController.h
//  电子签名
//
//  Created by 陈胜华 on 16/12/1.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FinshSignName)(UIImage *image);

@interface SignNameViewController : UIViewController

@property (nonatomic,strong) UIImage *signImage;

@property (nonatomic,  copy) FinshSignName signBlock ;

@end
