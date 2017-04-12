//
//  NSDate+YJRefresh.m
//  YJRefreshDemo
//
//  Created by YJHou on 2017/4/12.
//  Copyright © 2017年 Houmanager. All rights reserved.
//

#import "NSDate+YJRefresh.h"

@implementation NSDate (YJRefresh)

+ (NSCalendar *)yj_currentCalendar{
    // 9.x用currentCalendar有时异常,8.0以后用最新的API
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }
    return [NSCalendar currentCalendar];
}

+ (NSDateFormatter *)yj_getDateFormatterWithDate:(NSDate *)date{
    // 1.获得年月日
    NSCalendar *calendar = [self yj_currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:date];
    NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    
    // 2.格式化日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if ([cmp1 day] == [cmp2 day]) { // 今天
        formatter.dateFormat = @" HH:mm";
    } else if ([cmp1 year] == [cmp2 year]) { // 今年
        formatter.dateFormat = @"MM-dd HH:mm";
    } else {
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    }
    return formatter;
}

- (BOOL)yj_isToday{
    
    // 1.获得年月日
    NSCalendar *calendar = [NSDate yj_currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:self];
    NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    
    BOOL isToday = NO;
    if ([cmp1 day] == [cmp2 day]) { // 今天
        isToday = YES;
    }
    return isToday;
}

@end
