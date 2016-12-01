//
//  ViewController.m
//  ExpandTableViewTest
//
//  Created by 陈胜华 on 16/11/17.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "ViewController.h"
#import "YFAssistantTableView.h"
#import "RecordHeaderCell.h"
#import "RecordCell.h"

static NSString *cellIndentifier       = @"RecordCell";
static NSString *cellIndentifierHeader = @"RecordHeaderCell";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,YFAssistantDelegate>

@property (nonatomic,strong) YFAssistantTableView *tableView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
}
- (void)setupTableView {
    
    self.tableView = [[YFAssistantTableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.assistantDelegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"RecordHeaderCell" bundle:nil] forCellReuseIdentifier:cellIndentifierHeader];
    [self.tableView registerNib:[UINib nibWithNibName:@"RecordCell" bundle:nil] forCellReuseIdentifier:cellIndentifier];
    self.tableView.retractWhenSpread = YES;
    [self.view addSubview:self.tableView];
    
}

#pragma mark tableView delegate

- (void)tableView:(YFAssistantTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:[tableView logicIndexPath2Actual:indexPath] animated:YES];
    [tableView spreadAssistant:indexPath];
    
}

#pragma mark tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

- (UITableViewCell *)tableView:(YFAssistantTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RecordHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifierHeader forIndexPath:[tableView logicIndexPath2Actual:indexPath]];

    return cell;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

#pragma mark YFAssistantTableView delegate

- (BOOL)YFAssistantTableView:(YFAssistantTableView *)tableView shouldSpreadAssistantAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (UITableViewCell *)YFAssistantTableView:(YFAssistantTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier forIndexPath:[tableView logicIndexPath2Actual:indexPath]];
    
    return cell;
}

- (CGFloat )YFAssistantTableView:(YFAssistantTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (UITableViewRowAnimation )YFAssistantTableViewRetractAnimation:(YFAssistantTableView *)tableView{
    
    return UITableViewRowAnimationTop;
}

- (UITableViewRowAnimation )YFAssistantTableViewSpreadAnimation:(YFAssistantTableView *)tableView{
    
    return UITableViewRowAnimationTop;
}

@end
