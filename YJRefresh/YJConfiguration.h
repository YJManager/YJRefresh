//
//  YJConfiguration.h
//  YJRefreshDemo
//
//  Created by YJHou on 2016/3/10.
//  Copyright © 2016年 Houmanager. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/message.h>

typedef NS_ENUM(NSInteger, YJRefreshState) {
    YJRefreshStateIdle = 1,    /**< 普通闲置状态 */
    YJRefreshStatePulling,     /**< 松开就可以进行刷新的状态 */
    YJRefreshStateWillRefresh, /**< 即将刷新的状态 */
    YJRefreshStateRefreshing,  /**< 正在刷新中的状态 */
    YJRefreshStateNoMoreData   /** 所有数据加载完毕，没有更多的数据了 */
};

/** 刷新通用 Block */
typedef void(^YJRefreshingBlock)();

// 日志输出
#ifdef DEBUG
#define YJRefreshLog(...) NSLog(__VA_ARGS__)
#else
#define YJRefreshLog(...)
#endif


// 常量
UIKIT_EXTERN const CGFloat YJRefreshLabelLeftInset;                 /**< 左边距 */
UIKIT_EXTERN const CGFloat YJRefreshFooterHeight;                   /**< 底部高度 */
UIKIT_EXTERN const CGFloat YJRefreshFastAnimationDuration;          /**< 快速动画时间 */
UIKIT_EXTERN const CGFloat YJRefreshSlowAnimationDuration;          /**< 慢速动画时间 */

UIKIT_EXTERN NSString *const YJRefreshHeaderIdleText;
UIKIT_EXTERN NSString *const YJRefreshHeaderPullingText;
UIKIT_EXTERN NSString *const YJRefreshHeaderRefreshingText;

UIKIT_EXTERN NSString *const YJRefreshAutoFooterIdleText;
UIKIT_EXTERN NSString *const YJRefreshAutoFooterRefreshingText;
UIKIT_EXTERN NSString *const YJRefreshAutoFooterNoMoreDataText;

UIKIT_EXTERN NSString *const YJRefreshBackFooterIdleText;
UIKIT_EXTERN NSString *const YJRefreshBackFooterPullingText;
UIKIT_EXTERN NSString *const YJRefreshBackFooterRefreshingText;
UIKIT_EXTERN NSString *const YJRefreshBackFooterNoMoreDataText;

UIKIT_EXTERN NSString *const YJRefreshHeaderLastTimeText;
UIKIT_EXTERN NSString *const YJRefreshHeaderDateTodayText;
UIKIT_EXTERN NSString *const YJRefreshHeaderNoneLastDateText;

// 状态检查
#define YJRefreshCheckState \
YJRefreshState oldState = self.state; \
if (state == oldState) return; \
[super setState:state];


@interface YJConfiguration : NSObject
@end
