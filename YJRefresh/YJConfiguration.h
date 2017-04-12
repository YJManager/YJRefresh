//
//  YJConfiguration.h
//  YJRefreshDemo
//
//  Created by YJHou on 2016/3/10.
//  Copyright © 2016年 Houmanager. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/message.h>

@interface YJConfiguration : NSObject
@end

// 日志输出
#ifdef DEBUG
#define YJRefreshLog(...) NSLog(__VA_ARGS__)
#else
#define YJRefreshLog(...)
#endif

// 运行时objc_msgSend
#define YJRefreshMsgSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)
#define YJRefreshMsgTarget(target) (__bridge void *)(target)

// 常量
UIKIT_EXTERN const CGFloat YJRefreshLabelLeftInset;                 /**< 左边距 */
UIKIT_EXTERN const CGFloat YJRefreshHeaderHeight;                   /**< 头部高度 */
UIKIT_EXTERN const CGFloat YJRefreshFooterHeight;                   /**< 底部高度 */
UIKIT_EXTERN const CGFloat YJRefreshFastAnimationDuration;          /**< 快速动画时间 */
UIKIT_EXTERN const CGFloat YJRefreshSlowAnimationDuration;          /**< 慢速动画时间 */

UIKIT_EXTERN NSString *const YJRefreshKeyPathContentOffset;
UIKIT_EXTERN NSString *const YJRefreshKeyPathContentSize;
UIKIT_EXTERN NSString *const YJRefreshKeyPathContentInset;
UIKIT_EXTERN NSString *const YJRefreshKeyPathPanState;

UIKIT_EXTERN NSString *const YJRefreshHeaderLastUpdatedTimeKey;

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


