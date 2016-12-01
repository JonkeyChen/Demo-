//
//  ViewController.h
//  LKDBHelperTest
//
//  Created by 陈胜华 on 16/8/18.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextViewDelegate>

@property(strong,nonatomic)NSMutableString* ms;

@property (weak, nonatomic) IBOutlet UITextView  *etxvTable;
@property (weak, nonatomic) IBOutlet UITextField *etxfUserName;
@property (weak, nonatomic) IBOutlet UITextField *etxfUserID;
@property (weak, nonatomic) IBOutlet UITextField *etxfUserMobile;
@property (weak, nonatomic) IBOutlet UITextField *etxfUserJob;

@end

