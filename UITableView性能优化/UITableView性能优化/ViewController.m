//
//  ViewController.m
//  UITableView性能优化
//
//  Created by 陈胜华 on 16/8/9.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "ViewController.h"
#import "MyTableViewController.h"

NSString *const cellIdentitfier  = @"MyContentCell";

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, assign) CGFloat lastScrollOffset;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[_tableView registerNib:[UINib nibWithNibName:@"MyContentCell" bundle:nil] forCellReuseIdentifier:cellIdentitfier];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentitfier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 40;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentitfier];
    
    cell.textLabel.text = [NSString stringWithFormat:@"  第%lu行",indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MyTableViewController *myTableVC = [[MyTableViewController alloc]init];
    [self presentViewController:myTableVC animated:YES completion:nil];
}
// 通常这个方法，用来做cell的动画
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_lastScrollOffset <= 0) {
        // 先将其平移至最右边
        cell.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(self.view.frame), 0);
    } else {
        // 先将其平移至最左边
        cell.transform = CGAffineTransformMakeTranslation(-CGRectGetWidth(self.view.frame), 0);
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        // 再将所有形变量删除，返回默认状态
        cell.transform = CGAffineTransformIdentity;
    }];
    
}
//滚动监听
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView != self.tableView) return;
    
    CGFloat y = scrollView.contentOffset.y;
    
    if (y > _lastScrollOffset) {//用户往上拖动
        // x=0 y=0 左
        // x=1 y=0 -angle 右
    } else {//用户往下拖动
        // x=0 y=1 -angle 左
        // x=1 y=1 右
    }
    //存储最后的y值
    _lastScrollOffset = y;
    
    NSLog(@"%.2f",_lastScrollOffset);
}




@end
