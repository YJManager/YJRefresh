//
//  YJRefreshHeader.h
//  YJRefreshDemo
//
//  Created by YJHou on 2017/4/10.
//  Copyright © 2017年 Houmanager. All rights reserved.
//  顶部下拉刷新组件, 具体实现效果请自定义子类

#import "YJRefreshComponent.h"

@interface YJRefreshHeader : YJRefreshComponent

@property (nonatomic, assign) CGFloat refreshHeaderWithSuperViewGap; /**< RefreshHeader 和 scrollView间距 */

+ (instancetype)headerWithRefreshingBlock:(YJRefreshingBlock)refreshingBlock;
+ (instancetype)headerWithRefreshingTarget:(id)target action:(SEL)action;

/** 初始化条件 */
- (void)prepareSetting NS_REQUIRES_SUPER;

/** 布局控件 */
- (void)layoutPlaceSubviews NS_REQUIRES_SUPER;

/** 是否正在刷新 */
- (BOOL)isRefreshing;

@end
