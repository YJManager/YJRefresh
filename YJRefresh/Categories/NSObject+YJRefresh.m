//
//  NSObject+YJRefresh.m
//  YJRefreshDemo
//
//  Created by YJHou on 2017/4/11.
//  Copyright © 2017年 Houmanager. All rights reserved.
//

#import "NSObject+YJRefresh.h"
#import <objc/runtime.h>

@implementation NSObject (YJRefresh)

/** 交换对象方法 */
+ (void)yj_exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2{
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}

/** 交换类方法 */
+ (void)yj_exchangeClassMethod1:(SEL)method1 method2:(SEL)method2{
    method_exchangeImplementations(class_getClassMethod(self, method1), class_getClassMethod(self, method2));
}

@end
