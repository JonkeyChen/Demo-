
//
//  SaleEstateEntity.m
//  JSON转Model库测试
//
//  Created by 陈胜华 on 16/8/18.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "SaleEstateEntity.h"

@implementation SaleEstateResultEntity


@end

@implementation SaleEstateEntity

+ (SaleEstateEntity*)encoderCode:(id)dict{
    
    if ([dict isKindOfClass:[NSDictionary class]]) {
        SaleEstateEntity *saleEstateEntity = [[SaleEstateEntity alloc]init];
        saleEstateEntity.resultNo = [dict[@"ResultNo"] integerValue];
        saleEstateEntity.total    = [dict[@"Total"] integerValue];
        
        NSArray<NSDictionary*> *dictResult = dict[@"Result"];
        NSMutableArray *dictReusltArray = [NSMutableArray array];
        [dictResult enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SaleEstateResultEntity *saleEstateResultEntity = [[SaleEstateResultEntity alloc]init];
            saleEstateResultEntity.isFollow     = [obj[@"IsFollow"] boolValue];
            saleEstateResultEntity.isSole       = [obj[@"IsSole"] boolValue];
            saleEstateResultEntity.isOnline     = [obj[@"IsOnline"] boolValue];
            saleEstateResultEntity.rotatedIn    = [obj[@"RotatedIn"] boolValue];
            saleEstateResultEntity.isAnyTimeSee = [obj[@"IsAnyTimeSee"] boolValue];
            saleEstateResultEntity.isTop        = [obj[@"IsTop"] boolValue];
            saleEstateResultEntity.isHot        = [obj[@"IsHot"] boolValue];
            saleEstateResultEntity.isManWu      = [obj[@"IsManWu"] boolValue];
            saleEstateResultEntity.isOnly       = [obj[@"IsOnly"] boolValue];
            saleEstateResultEntity.isKeys       = [obj[@"IsKeys"] boolValue];
            saleEstateResultEntity.isMetro      = [obj[@"IsFollow"] boolValue];
            //            saleEstateResultEntity.<#isFollow#> = [dict[@"<#isFollow#>"] <#boolValue#>];
            saleEstateResultEntity.address      = obj[@"Address"];
            [dictReusltArray addObject:saleEstateResultEntity];
        }];
        saleEstateEntity.result = dictReusltArray;
        
        return saleEstateEntity;
    }
    return nil;
}

/*
@property (nonatomic,assign) BOOL isSchool;//是否学区
@property (nonatomic,assign) BOOL isManager;//是否经理推荐
@property (nonatomic,assign) BOOL isRegion;//是否区域推荐
@property (nonatomic,assign) BOOL isExclusive;//是否新增独家人
@property (nonatomic,assign) BOOL isJiShou;//是否急售（限时出售）
@property (nonatomic,assign) BOOL isDel;//是否删除
@property (nonatomic,assign) BOOL label1;//预留标签1
@property (nonatomic,assign) BOOL label2;//是否含有视频
@property (nonatomic,assign) BOOL label3;//预留标签3
@property (nonatomic,assign) BOOL label4;//预留标签4
@property (nonatomic,assign) BOOL label5;//预留标签5

@property (nonatomic,assign) double salePrice;//售价
@property (nonatomic,assign) double unitSalePrice;//单价
@property (nonatomic,assign) double rentPrice;//租价
@property (nonatomic,assign) double gArea;//建筑面积
@property (nonatomic,assign) double lat;
@property (nonatomic,assign) double lng;

@property (nonatomic,strong) NSString *postId;//房源ID
@property (nonatomic,strong) NSString *agencyPropId;//agency房源id
@property (nonatomic,strong) NSString *postType;//租售类型 S:租 R:售 B:租售
@property (nonatomic,strong) NSString *estateName;//小区名称
@property (nonatomic,strong) NSString *estateCode;//小区code
@property (nonatomic,strong) NSString *address;//楼盘地址
@property (nonatomic,strong) NSString *title;//房源标题
@property (nonatomic,strong) NSString *keywords;//关键字
@property (nonatomic,strong) NSString *estateImageUrl;//房源默认图片路径
@property (nonatomic,strong) NSString *direction;//朝向
@property (nonatomic,strong) NSString *tencentVistaUrl;//腾讯街景
@property (nonatomic,strong) NSString *fitment;//装修情况
@property (nonatomic,strong) NSString *regionName;//区域名称
@property (nonatomic,strong) NSString *gscopeName;//板块名称
@property (nonatomic,strong) NSString *floorDisplay;//显示楼层

@property (nonatomic,assign) NSInteger roomCount;//房间数
@property (nonatomic,assign) NSInteger hallCount;//客厅数
@property (nonatomic,assign) NSInteger toiletCount;//卫浴数
@property (nonatomic,assign) NSInteger balconyCount;//阳台数
@property (nonatomic,assign) NSInteger kitchenCount;//厨房数
@property (nonatomic,assign) NSInteger regionId;//区域id
@property (nonatomic,assign) NSInteger gscopeId;//板块id
@property (nonatomic,assign) NSInteger estateSimilarPostsCnt;//小区同价位房源数量
@property (nonatomic,assign) NSInteger regionSimilarPostsCnt;//周边同价位房源数量
@property (nonatomic,assign) NSInteger floor;//所在楼层
@property (nonatomic,assign) NSInteger floorTotal;//总楼层
@property (nonatomic,assign) NSTimeInterval opDate;//建造年代

@property (nonatomic, copy)NSString *rentType;// 租房类型(整租/合租)
@property (nonatomic, copy)NSString *rentPayType;// 房租支付方式

@property (nonatomic, copy)NSString *matchSchoolsName;//对口学校名称拼接字符串 以英文逗号分隔（,）;
@property (nonatomic, assign)BOOL isHasDealData;//是否成交
@property (nonatomic, strong)NSArray *railWayInfos;//	List<RailWayToEstateResponse>	房源地铁信息;
@property (nonatomic, copy) NSString *applianceInfo; // 租房配套信息
*/
@end
