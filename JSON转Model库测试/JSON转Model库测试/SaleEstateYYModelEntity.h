//
//  SaleEntity.h
//  JSON转Model库测试
//
//  Created by 陈胜华 on 16/8/17.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaleResultEntity : NSObject

@property (nonatomic,assign) BOOL IsFollow;//是否跟盘
@property (nonatomic,assign) BOOL IsSole;//是否独家
@property (nonatomic,assign) BOOL IsOnline;//是否外网展示
@property (nonatomic,assign) BOOL RotatedIn;//是否一盘一处
@property (nonatomic,assign) BOOL IsAnyTimeSee;//是否随时可看(钥匙)
@property (nonatomic,assign) BOOL IsTop;//是否置顶
@property (nonatomic,assign) BOOL IsHot;//是否热盘
@property (nonatomic,assign) BOOL IsManWu;//是否满五年
@property (nonatomic,assign) BOOL IsManEr;//是否满二年
@property (nonatomic,assign) BOOL IsOnly;//是否唯一
@property (nonatomic,assign) BOOL IsKeys;//是否有钥匙
@property (nonatomic,assign) BOOL IsMetro;//是否地铁房
@property (nonatomic,assign) BOOL IsSchool;//是否学区
@property (nonatomic,assign) BOOL IsManager;//是否经理推荐
@property (nonatomic,assign) BOOL isRegion;//是否区域推荐
@property (nonatomic,assign) BOOL isExclusive;//是否新增独家人
@property (nonatomic,assign) BOOL IsJiShou;//是否急售（限时出售）
@property (nonatomic,assign) BOOL IsDel;//是否删除
@property (nonatomic,assign) BOOL Label1;//预留标签1
@property (nonatomic,assign) BOOL Label2;//是否含有视频
@property (nonatomic,assign) BOOL Label3;//预留标签3
@property (nonatomic,assign) BOOL Label4;//预留标签4
@property (nonatomic,assign) BOOL Label5;//预留标签5

@property (nonatomic,assign) double SalePrice;//售价
@property (nonatomic,assign) double UnitSalePrice;//单价
@property (nonatomic,assign) double RentPrice;//租价
@property (nonatomic,assign) double GArea;//建筑面积
@property (nonatomic,assign) double Lat;
@property (nonatomic,assign) double Lng;

@property (nonatomic,strong) NSString *PostId;//房源ID
@property (nonatomic,strong) NSString *AgencyPropId;//agency房源id
@property (nonatomic,strong) NSString *PostType;//租售类型 S:租 R:售 B:租售
@property (nonatomic,strong) NSString *EstateName;//小区名称
@property (nonatomic,strong) NSString *EstateCode;//小区code
@property (nonatomic,strong) NSString *Address;//楼盘地址
@property (nonatomic,strong) NSString *Title;//房源标题
@property (nonatomic,strong) NSString *Keywords;//关键字
@property (nonatomic,strong) NSString *EstateImageUrl;//房源默认图片路径
@property (nonatomic,strong) NSString *Direction;//朝向
@property (nonatomic,strong) NSString *TencentVistaUrl;//腾讯街景
@property (nonatomic,strong) NSString *Fitment;//装修情况
@property (nonatomic,strong) NSString *RegionName;//区域名称
@property (nonatomic,strong) NSString *GscopeName;//板块名称
@property (nonatomic,strong) NSString *FloorDisplay;//显示楼层

@property (nonatomic,assign) NSInteger RoomCount;//房间数
@property (nonatomic,assign) NSInteger HallCount;//客厅数
@property (nonatomic,assign) NSInteger ToiletCount;//卫浴数
@property (nonatomic,assign) NSInteger BalconyCount;//阳台数
@property (nonatomic,assign) NSInteger KitchenCount;//厨房数
@property (nonatomic,assign) NSInteger RegionId;//区域id
@property (nonatomic,assign) NSInteger GscopeId;//板块id
@property (nonatomic,assign) NSInteger EstateSimilarPostsCnt;//小区同价位房源数量
@property (nonatomic,assign) NSInteger RegionSimilarPostsCnt;//周边同价位房源数量
@property (nonatomic,assign) NSInteger Floor;//所在楼层
@property (nonatomic,assign) NSInteger FloorTotal;//总楼层
@property (nonatomic,assign) NSTimeInterval OpDate;//建造年代

@property (nonatomic, copy)NSString *RentType;// 租房类型(整租/合租)
@property (nonatomic, copy)NSString *RentPayType;// 房租支付方式

@property (nonatomic, copy)NSString *MatchSchoolsName;//对口学校名称拼接字符串 以英文逗号分隔（,）;
@property (nonatomic, assign)BOOL IsHasDealData;//是否成交
@property (nonatomic, strong)NSArray *RailWayInfos;//	List<RailWayToEstateResponse>	房源地铁信息;
@property (nonatomic, copy) NSString *ApplianceInfo; // 租房配套信息

///最近是否浏览过改房源（此字段不是数据字典中的）
@property (nonatomic,assign) BOOL IsRecentlyVisitEstate;
@property (nonatomic,strong) NSString *PostVideoUrl;    //视频URL
@property (nonatomic,strong) NSString *PaNo;    //街景PaNo

@end

@interface SaleEstateYYModelEntity : NSObject

@property (nonatomic,strong) NSArray<SaleResultEntity*> *Result;
@property (nonatomic,  copy) NSString *ResultNo;
@property (nonatomic,  copy) NSString *Total;

@end
