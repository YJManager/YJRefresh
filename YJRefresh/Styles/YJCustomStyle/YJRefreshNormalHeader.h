//
//  YJRefreshNormalHeader.h
//  YJRefreshDemo
//
//  Created by YJHou on 2017/4/12.
//  Copyright © 2017年 Houmanager. All rights reserved.
//  左边箭头正常样式的刷新头

#import "YJRefreshStateHeader.h"

@interface YJRefreshNormalHeader : YJRefreshStateHeader

@property (weak, nonatomic, readonly) UIImageView *arrowView;
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;


@end
