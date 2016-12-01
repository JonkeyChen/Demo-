//
//  ViewController.m
//  FooterDatePickerViewTest
//
//  Created by 陈胜华 on 16/11/28.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "ViewController.h"

#import "STPickerArea.h"
#import "STPickerSingle.h"
#import "STPickerDate.h"

@interface ViewController ()<UITextFieldDelegate, STPickerAreaDelegate, STPickerSingleDelegate, STPickerDateDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textArea;
@property (weak, nonatomic) IBOutlet UITextField *textSingle;
@property (weak, nonatomic) IBOutlet UITextField *textDate;
@end

@implementation ViewController

#pragma mark - --- lift cycle 生命周期 ---
- (void)viewDidLoad {
    
    [super viewDidLoad];
}


#pragma mark - --- delegate 视图委托 ---

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.textArea) {
        [self.textArea resignFirstResponder];
        
        
        STPickerArea *pickerArea = [[STPickerArea alloc]init];
        [pickerArea setDelegate:self];
        [pickerArea setContentMode:STPickerContentModeCenter];
        [pickerArea show];
        
    }
    
    if (textField == self.textSingle) {
        [self.textSingle resignFirstResponder];
        
        NSMutableArray *arrayData = [NSMutableArray array];
        for (int i = 1; i < 1000; i++) {
            NSString *string = [NSString stringWithFormat:@"%d", i];
            [arrayData addObject:string];
        }
        
        STPickerSingle *pickerSingle = [[STPickerSingle alloc]init];
        [pickerSingle setArrayData:arrayData];
        [pickerSingle setTitle:@"请选择价格"];
        [pickerSingle setTitleUnit:@"人民币"];
        [pickerSingle setContentMode:STPickerContentModeCenter];
        [pickerSingle setDelegate:self];
        [pickerSingle show];
    }
    
    
    if (textField == self.textDate) {
        [self.textDate resignFirstResponder];
        
        STPickerDate *pickerDate = [[STPickerDate alloc]init];
        [pickerDate setDelegate:self];
        [pickerDate show];
    }
    
}

- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
    NSString *text = [NSString stringWithFormat:@"%@ %@ %@", province, city, area];
    self.textArea.text = text;
}

- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle
{
    NSString *text = [NSString stringWithFormat:@"%@ 人民币", selectedTitle];
    self.textSingle.text = text;
}

- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSString *text = [NSString stringWithFormat:@"%zd年%zd月%zd日", year, month, day];
    self.textDate.text = text;
}
@end
