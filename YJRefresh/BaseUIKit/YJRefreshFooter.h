//
//  YJRefreshFooter.h
//  YJRefreshDemo
//
//  Created by YJHou on 2017/4/10.
//  Copyright © 2017年 Houmanager. All rights reserved.
//  上拉刷新控件

#import "YJRefreshComponent.h"

@interface YJRefreshFooter : YJRefreshComponent

+ (instancetype)footerWithRefreshingBlock:(YJRefreshingBlock)refreshingBlock;
+ (instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

- (void)endRefreshingWithNoMoreData;
- (void)resetNoMoreData;

@property (assign, nonatomic) CGFloat ignoredScrollViewContentInsetBottom;  /**< 忽略多少scrollView的contentInset的bottom */
@property (assign, nonatomic, getter=isAutomaticallyHidden) BOOL automaticallyHidden;

@end
