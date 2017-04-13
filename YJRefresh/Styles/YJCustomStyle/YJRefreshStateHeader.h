//
//  YJRefreshStateHeader.h
//  YJRefreshDemo
//
//  Created by YJHou on 2017/4/13.
//  Copyright © 2017年 Houmanager. All rights reserved.
//  本类是显示刷新状态和刷新时间的公用类
//  样式是:如:     正在刷新...
//              最后刷新:16:00
//  添加组件请继承添加

#import "YJRefreshHeader.h"

@interface YJRefreshStateHeader : YJRefreshHeader

@property (copy, nonatomic) NSString *(^lastUpdatedTimeText)(NSDate *lastUpdatedTime);

@property (weak, nonatomic, readonly) UILabel *stateLabel;
@property (weak, nonatomic, readonly) UILabel *lastUpdatedTimeLabel;

@property (copy, nonatomic) NSString *lastUpdatedTimeKey;
@property (strong, nonatomic, readonly) NSDate *lastUpdatedTime;    /**< 上一次下拉刷新成功的时间 */
@property (assign, nonatomic) CGFloat labelLeftInset;

@end
