//
//  NSDate+YJRefresh.h
//  YJRefreshDemo
//
//  Created by YJHou on 2017/4/12.
//  Copyright © 2017年 Houmanager. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YJRefresh)

+ (NSCalendar *)yj_currentCalendar;

+ (NSDateFormatter *)yj_getDateFormatterWithDate:(NSDate *)date;

- (BOOL)yj_isToday;

@end
