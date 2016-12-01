//
//  main.m
//  ExampleRuntime
//
//  Created by 陈胜华 on 16/8/15.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyClass.h"
#import <objc/runtime.h>

/**
 关联对象操作函数包括以下：
 
 // 设置关联对象
 void objc_setAssociatedObject ( id object, const void *key, id value, objc_AssociationPolicy policy );
 
 // 获取关联对象
 id objc_getAssociatedObject ( id object, const void *key );
 
 // 移除关联对象
 void objc_removeAssociatedObjects ( id object );
 关联对象及相关实例已经在前面讨论过了，在此不再重复。
 
 */

/**
 属性操作相关函数包括以下：
 
 // 获取属性名
 const char * property_getName ( objc_property_t property );
 
 // 获取属性特性描述字符串
 const char * property_getAttributes ( objc_property_t property );
 
 // 获取属性中指定的特性
 char * property_copyAttributeValue ( objc_property_t property, const char *attributeName );
 
 // 获取属性的特性列表
 objc_property_attribute_t * property_copyAttributeList ( objc_property_t property, unsigned int *outCount );
 
 */

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        
        MyClass *myClass = [[MyClass alloc] init];
        unsigned int outCount = 0;
        
        Class cls = myClass.class;
        
        // 类名
        NSLog(@"class name: %s", class_getName(cls));
        
        NSLog(@"==========================================================");
        
        // 父类
        NSLog(@"super class name: %s", class_getName(class_getSuperclass(cls)));
        NSLog(@"==========================================================");
        
        // 是否是元类
        NSLog(@"MyClass is %@ a meta-class", (class_isMetaClass(cls) ? @"" : @"not"));
        NSLog(@"==========================================================");
        
        Class meta_class = objc_getMetaClass(class_getName(cls));
        NSLog(@"%s's meta-class is %s", class_getName(cls), class_getName(meta_class));
        NSLog(@"==========================================================");
        
        // 变量实例大小
        NSLog(@"instance size: %zu", class_getInstanceSize(cls));
        NSLog(@"==========================================================");
        
        // 成员变量
        Ivar *ivars = class_copyIvarList(cls, &outCount);
        for (int i = 0; i < outCount; i++) {
            Ivar ivar = ivars[i];
            NSLog(@"instance variable's name: %s at index: %d", ivar_getName(ivar), i);
        }
        
        free(ivars);
        
        Ivar string = class_getInstanceVariable(cls, "_string");
        if (string != NULL) {
            NSLog(@"instace variable %s", ivar_getName(string));
        }
        
        NSLog(@"==========================================================");
        
        // 属性操作 - 属性名字
        objc_property_t * properties = class_copyPropertyList(cls, &outCount);
        for (int i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            //获取属性特性描述字符串 property_getAttributes
            NSLog(@"property's name: %s ||| 属性特性描述字符串: %s", property_getName(property),property_getAttributes(property));
        }
        
        free(properties);
        
        objc_property_t array = class_getProperty(cls, "array");
        if (array != NULL) {
            NSLog(@"property %s", property_getName(array));
        }
        
        NSLog(@"==========================================================");
        
        // 方法操作
        Method *methods = class_copyMethodList(cls, &outCount);
        for (int i = 0; i < outCount; i++) {
            Method method = methods[i];
            NSLog(@"method's signature: %s", method_getName(method));
        }
        
        free(methods);
        
        Method method1 = class_getInstanceMethod(cls, @selector(method1));
        if (method1 != NULL) {
            NSLog(@"method %s", method_getName(method1));
        }
        
        Method classMethod = class_getClassMethod(cls, @selector(classMethod1));
        if (classMethod != NULL) {
            NSLog(@"class method : %s", method_getName(classMethod));
        }
        
        NSLog(@"MyClass is%@ responsd to selector: method3WithArg1:arg2:", class_respondsToSelector(cls, @selector(method3WithArg1:arg2:)) ? @"" : @" not");
        
        IMP imp = class_getMethodImplementation(cls, @selector(method1));
        imp();
        
        NSLog(@"==========================================================");
        
        // 协议
        Protocol * __unsafe_unretained * protocols = class_copyProtocolList(cls, &outCount);
        Protocol * protocol;
        for (int i = 0; i < outCount; i++) {
            protocol = protocols[i];
            NSLog(@"protocol name: %s", protocol_getName(protocol));
        }
        
        NSLog(@"MyClass is%@ responsed to protocol %s", class_conformsToProtocol(cls, protocol) ? @"" : @" not", protocol_getName(protocol));
        
        NSLog(@"==========================================================");

    }
    return 0;
}
