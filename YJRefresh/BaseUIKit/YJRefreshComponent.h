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

typedef NS_ENUM(NSInteger, YJRefreshState) {
    YJRefreshStateIdle = 1,    /**< 普通闲置状态 */
    YJRefreshStatePulling,     /**< 松开就可以进行刷新的状态 */
    YJRefreshStateWillRefresh, /**< 即将刷新的状态 */
    YJRefreshStateRefreshing,  /**< 正在刷新中的状态 */
    YJRefreshStateNoMoreData   /** 所有数据加载完毕，没有更多的数据了 */
};

/** 1.开始刷新后的回调(进入刷新状态后的回调) */
typedef void (^YJRefreshComponentbeginRefreshingCompletionBlock)();
/** 2.进入刷新状态的回调ing */
typedef void (^YJRefreshComponentRefreshingBlock)();
/** 3.结束刷新后的回调 */
typedef void (^YJRefreshComponentEndRefreshingCompletionBlock)();


@interface YJRefreshComponent : UIView{
    UIEdgeInsets _scrollViewOriginalInset;       /**< 记录scrollView刚开始的inset  */
    __weak UIScrollView *_superScrollView;       /**< 父控件 */
}


@property (copy, nonatomic) YJRefreshComponentRefreshingBlock refreshingBlock;
- (void)setRefreshingTarget:(id)target refreshingAction:(SEL)action;
- (void)executeRefreshingCallback;                   /**< 触发回调（交给子类去调用） */


- (void)beginRefreshing;
- (void)beginRefreshingWithCompletionBlock:(void (^)())completionBlock;
@property (copy, nonatomic) YJRefreshComponentbeginRefreshingCompletionBlock beginRefreshingCompletionBlock;
@property (copy, nonatomic) YJRefreshComponentEndRefreshingCompletionBlock endRefreshingCompletionBlock;

- (void)endRefreshing;
- (void)endRefreshingWithCompletionBlock:(void (^)())completionBlock;
- (BOOL)isRefreshing;
@property (nonatomic, assign) YJRefreshState state;  /**< 刷新状态 一般交给子类内部实现 */

#pragma mark - 交给子类去访问
@property (assign, nonatomic, readonly) UIEdgeInsets scrollViewOriginalInset;
@property (weak, nonatomic, readonly) UIScrollView   *superScrollView;

#pragma mark - 子类必须实现
- (void)prepare NS_REQUIRES_SUPER; /**< 准备工作 */
- (void)placeSubviews NS_REQUIRES_SUPER;  /** 摆放子控件frame */
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
- (void)scrollViewPanStateDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;


#pragma mark - 其他
@property (assign, nonatomic) CGFloat pullingPercent;  /**< 拉拽的百分比(交给子类重写) */
@property (assign, nonatomic, getter=isAutomaticallyChangeAlpha) BOOL automaticallyChangeAlpha;  /** 根据拖拽比例自动切换透明度 */

@end
