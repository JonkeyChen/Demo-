
//
//  SaleEstateMJEntity.m
//  JSON转Model库测试
//
//  Created by 陈胜华 on 16/8/17.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "SaleEstateMJEntity.h"

@implementation SaleEstateMJResultEntity

+ (void)load{
    [SaleEstateMJResultEntity mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
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
    }];
}

@end

@implementation SaleEstateMJEntity


//+ (void)load {
//
//    [SaleEstateMJEntity mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
//        return @{
//                 @"resultNo" : @"ResultNo",
//                 @"total":@"Total"
//                 };
//    }];
//
//    [SaleEstateMJEntity mj_setupObjectClassInArray:^NSDictionary *{
//    }];
//}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"resultNo" : @"ResultNo",
             @"total":@"Total",
             @"result":@"Result"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{
             @"result" : @"SaleEstateMJResultEntity"
             };
}

@end
