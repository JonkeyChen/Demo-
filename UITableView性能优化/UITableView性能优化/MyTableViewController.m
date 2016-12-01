

//
//  MyTableViewController.m
//  UITableView性能优化
//
//  Created by 陈胜华 on 16/8/10.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "MyTableViewController.h"

@interface MyTableViewController ()
@property (weak, nonatomic) IBOutlet UIView *myHeaderView;
@property (weak, nonatomic) IBOutlet UIView *myFooterView;

@end

@implementation MyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = self.myHeaderView.frame;
    
    frame.size.height = 200;
    
    [self.myHeaderView setFrame:frame];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIndentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"  第%lu行",indexPath.row];
    
    return cell;
}

@end
