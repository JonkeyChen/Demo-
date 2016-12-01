//
//  ViewController.m
//  UserCenterScrollViewTest
//
//  Created by 陈胜华 on 16/11/17.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "ViewController.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
static NSString *cellIndentifier = @"ViewController";

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic,assign) CGFloat headerHieght;
@property (nonatomic,assign) CGFloat headerWidth ;

@property (nonatomic,strong) UIImageView *backImageV;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UIImageView *headerImg;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (!_backImageV) {
        UIImage *image = [UIImage imageNamed:@"back"];
        _backImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, image.size.height*0.8)];
        _backImageV.image = image;
        [self.view addSubview:_backImageV];
        
        _headerWidth  = _backImageV.frame.size.width;
        _headerHieght = _backImageV.frame.size.height;
    }
    
    if (!_headImageView) {
        _headImageView=[[UIImageView alloc]init];
        _headImageView.frame=CGRectMake(0, 64, ScreenWidth, 170);
        _headImageView.backgroundColor=[UIColor clearColor];
        _headImageView.userInteractionEnabled = YES;
        
        _headerImg=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2-35, 50, 70, 70)];
        _headerImg.center=CGPointMake(ScreenWidth/2, 70);
        [_headerImg setImage:[UIImage imageNamed:@"header"]];
        [_headerImg.layer setMasksToBounds:YES];
        [_headerImg.layer setCornerRadius:35];
        _headerImg.backgroundColor=[UIColor whiteColor];
        _headerImg.userInteractionEnabled=YES;
        [_headImageView addSubview:_headerImg];
    }
    
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
        _tableView.backgroundColor=[UIColor clearColor];
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIndentifier];
        [self.view addSubview:_tableView];
    }
    
    [_tableView setTableHeaderView:_headImageView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return  10;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    cell.textLabel.text = [NSString stringWithFormat:@"标题"];
    cell.backgroundColor = [UIColor whiteColor];
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat contentOffsety = scrollView.contentOffset.y;
 
    if (contentOffsety < 0 ) {//往下拉
        CGRect rect = _backImageV.frame;
        rect.size.height = _headerHieght - contentOffsety;
        rect.size.width = _headerWidth* (_headerHieght-contentOffsety)/_headerHieght;
        rect.origin.x =  -(rect.size.width-_headerWidth)/2;
        rect.origin.y = 0;
        _backImageV.frame = rect;
    } else {//往上顶
        CGRect rect = _backImageV.frame;
        rect.size.height = _headerHieght;
        rect.size.width = _headerWidth;
        rect.origin.x = 0;
        rect.origin.y = -contentOffsety;
        _backImageV.frame = rect;
    }
    
    NSLog(@"%ld",(long)contentOffsety);
}

@end
