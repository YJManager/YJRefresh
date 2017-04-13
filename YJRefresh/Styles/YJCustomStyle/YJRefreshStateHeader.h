//
//  YJRefreshStateHeader.h
//  YJRefreshDemo
//
//  Created by YJHou on 2017/4/11.
//  Copyright © 2017年 Houmanager. All rights reserved.
//

#import "YJRefreshHeader.h"

@interface YJRefreshStateHeader : YJRefreshHeader

@property (copy, nonatomic) NSString *(^lastUpdatedTimeText)(NSDate *lastUpdatedTime);

@property (weak, nonatomic, readonly) UILabel *stateLabel;
@property (weak, nonatomic, readonly) UILabel *lastUpdatedTimeLabel;

@property (assign, nonatomic) CGFloat labelLeftInset;

@end
