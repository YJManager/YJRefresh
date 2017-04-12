//
//  YJConfiguration.m
//  YJRefreshDemo
//
//  Created by YJHou on 2016/3/10.
//  Copyright © 2016年 Houmanager. All rights reserved.
//

#import "YJConfiguration.h"

@implementation YJConfiguration
@end

const CGFloat YJRefreshLabelLeftInset = 25.0f;
const CGFloat YJRefreshHeaderHeight = 44.0;
const CGFloat YJRefreshFooterHeight = 44.0;
const CGFloat YJRefreshFastAnimationDuration = 0.25;
const CGFloat YJRefreshSlowAnimationDuration = 0.4;

NSString *const YJRefreshKeyPathContentOffset        = @"contentOffset";
NSString *const YJRefreshKeyPathContentInset         = @"contentInset";
NSString *const YJRefreshKeyPathContentSize          = @"contentSize";
NSString *const YJRefreshKeyPathPanState             = @"state";

NSString *const YJRefreshHeaderLastUpdatedTimeKey    = @"YJRefreshHeaderLastUpdatedTimeKey";

NSString *const YJRefreshHeaderIdleText              = @"下拉刷新";
NSString *const YJRefreshHeaderPullingText           = @"松开立即刷新";
NSString *const YJRefreshHeaderRefreshingText        = @"正在刷新数据...";

NSString *const YJRefreshAutoFooterIdleText          = @"YJRefreshAutoFooterIdleText";
NSString *const YJRefreshAutoFooterRefreshingText    = @"YJRefreshAutoFooterRefreshingText";
NSString *const YJRefreshAutoFooterNoMoreDataText    = @"YJRefreshAutoFooterNoMoreDataText";

NSString *const YJRefreshBackFooterIdleText          = @"YJRefreshBackFooterIdleText";
NSString *const YJRefreshBackFooterPullingText       = @"YJRefreshBackFooterPullingText";
NSString *const YJRefreshBackFooterRefreshingText    = @"YJRefreshBackFooterRefreshingText";
NSString *const YJRefreshBackFooterNoMoreDataText    = @"YJRefreshBackFooterNoMoreDataText";

NSString *const YJRefreshHeaderLastTimeText          = @"最后更新:";
NSString *const YJRefreshHeaderDateTodayText         = @"今天";
NSString *const YJRefreshHeaderNoneLastDateText      = @"无记录";

