//
//  YJRefreshNormalHeader.h
//  YJRefreshDemo
//
//  Created by YJHou on 2017/4/12.
//  Copyright © 2017年 Houmanager. All rights reserved.
//  左边箭头正常样式的刷新头

#import "YJRefreshHeader.h"

@interface YJRefreshNormalHeader : YJRefreshHeader

@property (weak, nonatomic, readonly) UIImageView *arrowView;
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;

@property (copy, nonatomic) NSString *(^lastUpdatedTimeText)(NSDate *lastUpdatedTime);

@property (weak, nonatomic, readonly) UILabel *stateLabel;
@property (weak, nonatomic, readonly) UILabel *lastUpdatedTimeLabel;

@property (assign, nonatomic) CGFloat labelLeftInset;

@property (strong, nonatomic, readonly) NSDate *lastUpdatedTime;    /**< 上一次下拉刷新成功的时间 */


@end
