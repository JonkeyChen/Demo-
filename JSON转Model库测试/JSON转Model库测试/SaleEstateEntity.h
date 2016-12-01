//
//  SaleEstateEntity.h
//  JSON转Model库测试
//
//  Created by 陈胜华 on 16/8/18.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaleEstateResultEntity : NSObject

@property (nonatomic,assign) BOOL isFollow;//是否跟盘
@property (nonatomic,assign) BOOL isSole;//是否独家
@property (nonatomic,assign) BOOL isOnline;//是否外网展示
@property (nonatomic,assign) BOOL rotatedIn;//是否一盘一处
@property (nonatomic,assign) BOOL isAnyTimeSee;//是否随时可看(钥匙)
@property (nonatomic,assign) BOOL isTop;//是否置顶
@property (nonatomic,assign) BOOL isHot;//是否热盘
@property (nonatomic,assign) BOOL isManWu;//是否满五年
@property (nonatomic,assign) BOOL isManEr;//是否满二年
@property (nonatomic,assign) BOOL isOnly;//是否唯一
@property (nonatomic,assign) BOOL isKeys;//是否有钥匙
@property (nonatomic,assign) BOOL isMetro;//是否地铁房
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

///最近是否浏览过改房源（此字段不是数据字典中的）
@property (nonatomic,assign) BOOL isRecentlyVisitEstate;
@property (nonatomic,strong) NSString *postVideoUrl;    //视频URL
@property (nonatomic,strong) NSString *paNo;    //街景PaNo


@end

@interface SaleEstateEntity : NSObject

@property (nonatomic,assign) NSInteger resultNo;
@property (nonatomic,assign) NSInteger total;
@property (nonatomic,strong) NSArray<SaleEstateResultEntity *> *result;

+ (SaleEstateEntity*)encoderCode:(id)dict;

@end
