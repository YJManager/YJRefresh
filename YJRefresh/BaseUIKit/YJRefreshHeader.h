//
//  YJRefreshHeader.h
//  YJRefreshDemo
//
//  Created by YJHou on 2017/4/10.
//  Copyright © 2017年 Houmanager. All rights reserved.
//  顶部下拉刷新

#import "YJRefreshComponent.h"

@interface YJRefreshHeader : YJRefreshComponent

+ (instancetype)headerWithRefreshingBlock:(YJRefreshComponentRefreshingBlock)refreshingBlock;
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

@property (nonatomic, copy) NSString *lastUpdatedTimeKey;           /**< 最后更新时间 */
@property (strong, nonatomic, readonly) NSDate *lastUpdatedTime;    /**< 上一次下拉刷新成功的时间 */

@property (assign, nonatomic) CGFloat ignoredScrollViewContentInsetTop; /**< 忽略多少scrollView的contentInset的top */

@end
