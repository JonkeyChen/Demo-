//
//  UserEntity.h
//  LKDBHelperTest
//
//  Created by 陈胜华 on 16/8/18.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "BaseEntity.h"

@interface CompanyEntity : NSObject

@property (nonatomic,copy) NSString *companyNo;
@property (nonatomic,copy) NSString *companyJob;

@end

@interface UserEntity : BaseEntity

@property (nonatomic,  copy) NSString *mobile;        
@property (nonatomic,  copy) NSString *ID;
@property (nonatomic,  copy) NSString *user_name;
@property (nonatomic,strong) CompanyEntity *company;
@end
