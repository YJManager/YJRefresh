//
//  UIScrollView+YJRefresh.h
//  YJRefreshDemo
//
//  Created by YJHou on 2017/4/12.
//  Copyright © 2017年 Houmanager. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJRefreshHeader, YJRefreshFooter;
@interface UIScrollView (YJRefresh)

@property (nonatomic, copy) void (^yj_reloadDataBlock)(NSInteger totalDataCount);

@property (strong, nonatomic) YJRefreshHeader *header_Refresh;
@property (strong, nonatomic) YJRefreshFooter *footer_Refresh;

@end
