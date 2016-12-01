//
//  MainViewController.m
//  MacProjectTest
//
//  Created by 陈胜华 on 16/8/3.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (weak) IBOutlet NSPopUpButton *itemMenu;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    NSMutableArray *menuItemArray = [[NSMutableArray alloc]init];
    for (int index = 0; index < 5; index ++) {
        NSString *menuTitle = [NSString stringWithFormat:@"标题%d",index];
        
        [menuItemArray addObject:menuTitle];
    }
    [_itemMenu removeAllItems];
    [_itemMenu addItemsWithTitles:menuItemArray];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}

- (IBAction)_efOnClcikItem:(NSPopUpButton*)sender {
    NSLog(@"items测试 %lu",[sender indexOfSelectedItem]);
    
}

@end
