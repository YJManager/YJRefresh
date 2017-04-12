//
//  NSObject+YJRefresh.h
//  YJRefreshDemo
//
//  Created by YJHou on 2017/4/11.
//  Copyright © 2017年 Houmanager. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YJRefresh)

/** 交换对象方法 */
+ (void)yj_exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2;
/** 交换类方法 */
+ (void)yj_exchangeClassMethod1:(SEL)method1 method2:(SEL)method2;

@end
