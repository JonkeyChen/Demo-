//
//  ViewController.m
//  UICollectionView水平缩放布局
//
//  Created by 陈胜华 on 16/8/11.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "ViewController.h"
#import "DFHorizontalLayout.h"
#import "DFCornerLayout.h"
#import "DFWaterFlowNoarmlLayout.h"
#import "DFWaterFlowLayout.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,DFWaterFlowLayoutDelegate>

@property (nonatomic,strong) UICollectionView *myHorizontalView;
@property (nonatomic,strong) UICollectionView *myCornerView;
@property (nonatomic,strong) UICollectionView *myWaterView;

@end

static NSString *collectionCellID1  = @"CollecitonCellIdnetifier1";
static NSString *collectionCellID2 = @"CollecitonCellIdnetifier2";
static NSString *collectionCellID3 = @"CollecitonCellIdnetifier3";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _myCornerView = ({
        //设置布局因素 : 流水布局
        DFCornerLayout *flowLayout = [[DFCornerLayout alloc]init];
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2.0-200/2.0,
                                                                                             0,
                                                                                             200,
                                                                                             200) collectionViewLayout:flowLayout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.dataSource = self;
        collectionView.delegate   = self;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectionCellID2];
        [self.view addSubview:collectionView];
        collectionView;
    });
    
    _myHorizontalView = ({
        //设置布局因素 : 流水布局(比较常用的布局)
        DFHorizontalLayout *flowLayout = [[DFHorizontalLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/3.0, [UIScreen mainScreen].bounds.size.width/3.0);
        
        //创建 collectionView 初始化时加入布局
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, self.view.bounds.size.width/3.0)
                                                             collectionViewLayout:flowLayout];
        //只是为了验证 控件已经加到 view 上  ()
        collectionView.backgroundColor = [UIColor blackColor];
        //一般是将 控制器 设置为 数据源, 也就是在控制器中处理各种数据.
        collectionView.dataSource = self;
        //关于 cell 的注册
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectionCellID1];
        [self.view addSubview:collectionView];
        collectionView;
    });
    
    //DFWaterFlowNoarmlLayout *flowLayout = [[DFWaterFlowNoarmlLayout alloc]init];
    
    _myWaterView = ({
        DFWaterFlowLayout *flowLayout = [[DFWaterFlowLayout alloc]init];
        //flowLayout.delegate = self;
        flowLayout.rowHeight = ([UIScreen mainScreen].bounds.size.width-40)/3.0;

        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,
                                                                                             CGRectGetMaxY(_myHorizontalView.frame),
                                                                                             CGRectGetWidth(self.view.frame),
                                                                                             CGRectGetHeight(self.view.frame)-CGRectGetMaxY(_myHorizontalView.frame))
                                                             collectionViewLayout:flowLayout];
        collectionView.backgroundColor = [UIColor redColor];
        collectionView.dataSource = self;
        collectionView.delegate   = self;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectionCellID3];
        [self.view addSubview:collectionView];
        collectionView;
    });
}

//返回每一组的项目数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == _myHorizontalView) {
    return 200;
    } else if (collectionView == _myCornerView){
        return 5;
    } else {
        return 100;
    }
}

//返回每一个 item 的 cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == _myHorizontalView) {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID1 forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
//        cell.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"2.png"].CGImage);
    return cell;
    } else if (collectionView == _myCornerView) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID2 forIndexPath:indexPath];
        cell.backgroundColor = [UIColor yellowColor];
        cell.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"2.png"].CGImage);
        cell.layer.masksToBounds = YES;
        cell.layer.cornerRadius  = CGRectGetWidth(cell.frame)/2.0;
        return cell;
    } else {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID3 forIndexPath:indexPath];
        cell.backgroundColor = [UIColor yellowColor];
//        cell.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"2.png"].CGImage);
        return cell;
    }
    return  nil;
}

- (CGFloat)waterFlowLayout:(DFWaterFlowLayout *)waterFlowLayout indexPath:(NSIndexPath *)indexPath width:(CGFloat)width {
    return 100;
}

@end
