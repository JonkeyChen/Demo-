//
//  SaleEstateListArrayEntity.m
//  SaleHouse
//
//  Created by 苏军朋 on 16/6/27.
//  Copyright © 2016年 苏军朋. All rights reserved.
//

#import "SaleEstateMantleEntity.h"

@implementation SaleEstateListDetailEntity

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    
    return @{@"postId":@"PostId",
             @"agencyPropId":@"PropId",
             @"postType":@"PostType",
             @"estateName":@"EstateName",
             @"estateCode":@"EstateCode",
             @"address":@"Address",
             @"unitSalePrice":@"UnitSalePrice",
             @"rentPrice":@"RentPrice",
             @"title":@"Title",
             @"keywords":@"KeyWords",
             @"estateImageUrl":@"DefaultImage",
             @"roomCount":@"RoomCount",
             @"hallCount":@"HallCount",
             @"toiletCount":@"ToiletCount",
             @"balconyCount":@"BalconyCount",
             @"kitchenCount":@"KitchenCount",
             @"gArea":@"GArea",
             @"direction":@"Direction",
             
             @"isFollow":@"IsFollow",
             @"isSole":@"IsSole",
             @"isOnline":@"IsOnline",
             @"rotatedIn":@"RotatedIn",
             @"isAnyTimeSee":@"IsAnyTimeSee",
             @"isTop":@"IsTop",
             @"isHot":@"IsHot",
             @"isManWu":@"IsManWu",
             @"isManEr":@"IsManEr",
             @"isOnly":@"IsOnly",
             @"isKeys":@"IsKeys",
             @"isMetro":@"IsMetro",
             @"isSchool":@"IsSchool",
             @"isManager":@"IsManager",
             @"isRegion":@"IsRegion",
             @"isExclusive":@"IsExclusive",
             @"isJiShou":@"IsJiShou",
             @"isDel":@"IsDel",
             @"label1":@"Label1",
             @"label2":@"Label2",
             @"label3":@"Label3",
             @"label4":@"Label4",
             @"label5":@"Label5",
             
             @"salePrice":@"SalePrice",
             @"tencentVistaUrl":@"TencentVistaUrl",
             @"fitment":@"Fitment",
             @"lat":@"Lat",
             @"lng":@"Lng",
             @"regionId":@"RegionId",
             @"gscopeId":@"GScopeId",
             @"regionName":@"RegionName",
             @"gscopeName":@"GscopeName",
             @"estateSimilarPostsCnt":@"EstateSimilarPostsCnt",
             @"regionSimilarPostsCnt":@"RegionSimilarPostsCnt",
             @"floor":@"Floor",
             @"floorTotal":@"FloorTotal",
             @"floorDisplay":@"FloorDisplay",
             @"opDate":@"OpDate",
             @"rentType":@"RentType",
             @"rentPayType":@"RentPayType",
             @"railWayInfos":@"RailWayInfos",
             @"matchSchoolsName":@"MatchSchoolsName",
             @"isHasDealData":@"IsHasDealData",
             @"applianceInfo":@"ApplianceInfo",
             @"postVideoUrl":@"PostVideoUrl",
             @"paNo":@"PaNo",
             };
}

@end


@implementation SaleEstateMantleEntity

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return@{
            @"result":@"Result",
            @"resultNo":@"ResultNo",
            @"message":@"Message",
            @"total":@"Total"
            };
}

+(NSValueTransformer *)resultJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[SaleEstateListDetailEntity class]];
}

@end
