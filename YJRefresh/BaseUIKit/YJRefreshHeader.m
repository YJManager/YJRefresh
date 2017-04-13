//
//  YJRefreshHeader.m
//  YJRefreshDemo
//
//  Created by YJHou on 2017/4/10.
//  Copyright © 2017年 Houmanager. All rights reserved.
//

#import "YJRefreshHeader.h"

const CGFloat YJRefreshHeaderHeight = 54.0;

@interface YJRefreshHeader ()

@property (nonatomic, assign) CGFloat insetTDelta; /**< 顶部 */

@end

@implementation YJRefreshHeader

+ (instancetype)headerWithRefreshingBlock:(YJRefreshingBlock)refreshingBlock{
    YJRefreshHeader *header = [[self alloc] init];
    header.startRefreshingBlock = refreshingBlock;
    return header;
}

+ (instancetype)headerWithRefreshingTarget:(id)target action:(SEL)action{
    YJRefreshHeader *header = [[self alloc] init];
    [header setRefreshingTarget:target action:action];
    return header;
}

- (void)prepareSetting{
    [super prepareSetting];
}

- (void)layoutPlaceSubviews{
    [super layoutPlaceSubviews];
    self.y_Refesh = -self.height_Refesh - self.refreshHeaderWithSuperViewGap;
    self.height_Refesh = YJRefreshHeaderHeight; // 顶部高度
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    [super scrollViewContentOffsetDidChange:change];
    
    if (self.state == YJRefreshStateRefreshing) {
        if (self.window == nil) return;
        
        CGFloat insetT = -self.superScrollView.offsetY_Refesh > _superScrollViewOriginalInset.top ? -self.superScrollView.offsetY_Refesh : _superScrollViewOriginalInset.top;
        insetT = insetT > self.height_Refesh + _superScrollViewOriginalInset.top ? self.height_Refesh + _superScrollViewOriginalInset.top : insetT;
        self.superScrollView.insetTop_Refesh = insetT;
        
        self.insetTDelta = _superScrollViewOriginalInset.top - insetT;
        return;
    }
    
    _superScrollViewOriginalInset = self.superScrollView.contentInset;
    
    CGFloat offsetY = self.superScrollView.offsetY_Refesh;
    CGFloat happenOffsetY = -self.superScrollViewOriginalInset.top;
    
    if (offsetY > happenOffsetY) return; // 向上滚动直接返回
    
    /** 刷新控件完全漏出的高度 是个负数 */
    CGFloat normal2pullingOffsetY = happenOffsetY - self.height_Refesh;
    CGFloat pullingPercent = (happenOffsetY - offsetY) / self.height_Refesh;
    
    if (self.superScrollView.isDragging) { // 如果正在拖拽
        self.pullingPercent = pullingPercent;
        if (self.state == YJRefreshStateIdle && offsetY < normal2pullingOffsetY) {
            self.state = YJRefreshStatePulling;
        } else if (self.state == YJRefreshStatePulling && offsetY >= normal2pullingOffsetY) {
            self.state = YJRefreshStateIdle;
        }
    } else if (self.state == YJRefreshStatePulling) {// 即将刷新 && 手松开
        [self startRefreshing];
    } else if (pullingPercent < 1) {
        self.pullingPercent = pullingPercent;
    }
}

- (void)setState:(YJRefreshState)state{
    YJRefreshCheckState
    // 根据状态做事情
    if (state == YJRefreshStateIdle) {
        if (oldState != YJRefreshStateRefreshing) return;
        
        // 恢复inset和offset
        [UIView animateWithDuration:YJRefreshSlowAnimationDuration animations:^{
            self.superScrollView.insetTop_Refesh += self.insetTDelta;
            if (self.isAutomaticallyChangeAlpha) self.alpha = 0.0;
        } completion:^(BOOL finished) {
            self.pullingPercent = 0.0;
            if (self.stopRefreshingBlock) {
                self.stopRefreshingBlock();
            }
        }];
    } else if (state == YJRefreshStateRefreshing) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:YJRefreshFastAnimationDuration animations:^{
                CGFloat top = self.superScrollViewOriginalInset.top + self.height_Refesh;
                // 增加滚动区域top
                self.superScrollView.insetTop_Refesh = top;
                // 设置滚动位置
                [self.superScrollView setContentOffset:CGPointMake(0, -top) animated:NO];
            } completion:^(BOOL finished) {
                [self executeRefreshingCallback];
            }];
        });
    }
}

#pragma mark - Public
- (void)stopRefreshing{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.state = YJRefreshStateIdle;
    });
}

#pragma mark - Support
- (BOOL)isRefreshing{
    return [super isRefreshing];
}

@end
