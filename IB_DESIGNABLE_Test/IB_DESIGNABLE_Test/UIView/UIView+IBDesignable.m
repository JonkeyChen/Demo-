//
//  UIView+IBDesignable.m
//  IB_DESIGNABLE_Test
//
//  Created by 陈胜华 on 16/8/3.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import "UIView+IBDesignable.h"
#import <objc/runtime.h>

static void *Key = @"Key";

@implementation UIView (IBDesignable)

- (void)setCorner:(NSString *)corner {
    objc_setAssociatedObject(self, &Key, corner, OBJC_ASSOCIATION_ASSIGN);
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius  = [corner intValue];
}

- (NSString*)corner {
    return objc_getAssociatedObject(self, &Key);
}

//- (void)setHotName:(NSString *)hotName{
//    objc_setAssociatedObject(self, &AddPropertyKey, hotName, OBJC_ASSOCIATION_COPY);
//}
//- (NSString *)hotName{
//    NSString *hotNameStr = objc_getAssociatedObject(self, &AddPropertyKey);
//    if ([hotNameStr isEqualToString:@""]||hotNameStr==nil||hotNameStr.length == 0) {
//        return @"属性未赋值";
//    } else {
//        return hotNameStr;//objc_getAssociatedObject(self, &AddPropertyKey);
//    }
//}

@end
