//
//  ViewController.m
//  仿淘宝商品详情Test
//
//  Created by 陈胜华 on 16/11/21.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"

static NSString *cellIndentifierCell = @"TableViewCell";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIImageView *headerImageV;
@property (nonatomic,strong) UIView      *headerView;
@property (nonatomic,strong) UIView      *headerNav;
@property (nonatomic,strong) UILabel     *headerTitleLabel;

@property (nonatomic,assign) CGFloat     screenWidth;
@property (nonatomic,assign) CGFloat     screenHeight;
@property (nonatomic,assign) CGSize      headerSize;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _screenWidth = CGRectGetWidth(self.view.frame);
    _screenHeight= CGRectGetHeight(self.view.frame);

    if (!_headerImageV) {//最内层的背景视图
        UIImage *image = [UIImage imageNamed:@"3.jpg"];
        _headerImageV = [[UIImageView alloc]init];
        _headerImageV.frame = CGRectMake(0, 0, _screenWidth,(_screenWidth/_screenHeight)*image.size.height);
        _headerImageV.image = image;
        _headerSize = _headerImageV.frame.size;
        [self.view addSubview:_headerImageV];
    }
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:cellIndentifierCell];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.rowHeight  = 280;
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    
    if (!_headerView) {//透明的headerView，让tableView显示往下延展
        _headerView = [[UIView alloc]init];
        _headerView.frame = _headerImageV.frame;
        _headerView.backgroundColor = [UIColor clearColor];
        [_tableView setTableHeaderView:_headerView];
    }
    
    if (!_headerNav) {//导航栏背景视图, defalut alpha = 0
        _headerNav = [[UIView alloc]init];
        _headerNav.frame = CGRectMake(0, 0, _screenWidth, 64);
        _headerNav.backgroundColor = [UIColor whiteColor];
        _headerNav.alpha = 0;
        [self.view addSubview:_headerNav];
        
        //导航栏标题
        _headerTitleLabel = [[UILabel alloc]init];
        _headerTitleLabel.frame  = CGRectMake(_screenWidth/2.0 - 50, 20+13, 100, 17);
        _headerTitleLabel.font   = [UIFont systemFontOfSize:15];
        _headerTitleLabel.text   = @"商品名称xxx";
        [_headerNav addSubview:_headerTitleLabel];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  10;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifierCell];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat contentOffY = scrollView.contentOffset.y;
    
    if (contentOffY <= 0) {//向下拉，等比例缩放背景视图
        
        _headerNav.alpha = 0;
        
        CGFloat currentWidth = (_headerSize.width/_headerSize.height)*(_headerSize.height - contentOffY);
       
        _headerImageV.frame = CGRectMake(_screenWidth/2.0 - currentWidth/2.0, 0, currentWidth,(_headerSize.height - contentOffY));
    } else {//向上拉

        //渐变导航栏背景颜色
        _headerNav.alpha = contentOffY/_headerSize.height;
        
        _headerImageV.frame = CGRectMake(0, 0, _headerSize.width, _headerSize.height);
    }
    
    if (contentOffY <= 0) {
        
    }
}

@end
