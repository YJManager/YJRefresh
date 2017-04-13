//
//  YJRefreshComponent.h
//  YJRefreshDemo
//
//  Created by YJHou on 2016/4/12.
//  Copyright © 2016年 Houmanager. All rights reserved.
//  刷新的基类

#import <UIKit/UIKit.h>
#import "UIView+YJRefeshExt.h"
#import "YJConfiguration.h"
#import "UIScrollView+YJRefreshPosition.h"
#import "UIScrollView+YJRefresh.h"
#import "UILabel+YJRefeshExt.h"

@interface YJRefreshComponent : UIView{
    UIEdgeInsets _superScrollViewOriginalInset;     /**< 记录scrollView刚开始的inset  */
    __weak UIScrollView *_superScrollView;          /**< 父控件 */
}
@property (nonatomic, assign, readonly) UIEdgeInsets    superScrollViewOriginalInset;   /**< 记录scrollView刚开始的inset */
@property (nonatomic, weak, readonly)   UIScrollView   *superScrollView;                /**< 父控件 */
@property (nonatomic, assign)           YJRefreshState  state;                          /**< 刷新状态 一般交给子类内部实现 */

@property (nonatomic, copy) YJRefreshingBlock startRefreshingBlock; /**< 开始刷新的Block */
@property (nonatomic, copy) YJRefreshingBlock stopRefreshingBlock;  /**< 停止刷新的Block */

/** 是否正在刷新 */
- (BOOL)isRefreshing;

- (void)setRefreshingTarget:(id)target action:(SEL)action;
/** 由子类触发回调 */
- (void)executeRefreshingCallback;


- (void)startRefreshing;
- (void)startRefreshingWithCompletionBlock:(YJRefreshingBlock)completionBlock;

- (void)stopRefreshing;
- (void)stopRefreshingWithCompletionBlock:(YJRefreshingBlock)completionBlock;

- (void)prepareSetting NS_REQUIRES_SUPER; /**< 准备工作 */
- (void)layoutPlaceSubviews NS_REQUIRES_SUPER;  /** 摆放子控件frame */
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
- (void)scrollViewPanStateDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;

@property (nonatomic, assign) CGFloat pullingPercent;  /**< 拉拽的百分比(子类重写) */
@property (assign, nonatomic, getter=isAutomaticallyChangeAlpha) BOOL automaticallyChangeAlpha;  /** 根据拖拽比例自动切换透明度 */

@end
