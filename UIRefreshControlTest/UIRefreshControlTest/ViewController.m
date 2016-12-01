//
//  ViewController.m
//  UIRefreshControlTest
//
//  Created by 陈胜华 on 16/11/16.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong ,nonatomic) NSMutableArray *modelArray;

@property (strong ,nonatomic) UITableView *tableView;

@property (strong ,nonatomic) UIRefreshControl *refreshControl;

@end

@implementation ViewController

static NSString *const CellId = @"cell";

- (NSMutableArray *)modelArray{
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}


- (void)viewDidLoad{
    [super viewDidLoad];

    self.tableView = ({
        UITableView *tableView_ = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [tableView_ registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([self class])];
        tableView_.dataSource = self;
        [self.view addSubview:tableView_];
        tableView_;
    });
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
    refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [refresh addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    self.tableView.refreshControl = refresh;
    
    [self.refreshControl beginRefreshing];
}


- (void)refresh{
    
    if (self.refreshControl.isRefreshing){
        [self.modelArray removeAllObjects];//清除旧数据，每次都加载最新的数据
        self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"加载中..."];
        [self addData];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }
}

//加载数据
- (void)addData{
    NSDate *date = [[NSDate alloc]init];
    for (int i = 0; i < 20; i++) {
        [self.modelArray addObject:date];
    }
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.modelArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    cell.textLabel.text = [dateFormatter stringFromDate:self.modelArray[indexPath.row]];
    return cell;
}

@end
