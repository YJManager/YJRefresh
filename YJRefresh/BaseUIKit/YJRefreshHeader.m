//
//  YJRefreshHeader.m
//  YJRefreshDemo
//
//  Created by YJHou on 2017/4/10.
//  Copyright © 2017年 Houmanager. All rights reserved.
//

#import "YJRefreshHeader.h"

NSString *const YJRefreshHeaderLastUpdatedTimeKey    = @"YJRefreshHeaderLastUpdatedTimeKey";
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
    self.lastUpdatedTimeKey = YJRefreshHeaderLastUpdatedTimeKey;
    self.h_Refesh = YJRefreshHeaderHeight; // 顶部高度
}

- (void)layoutPlaceSubviews{
    [super layoutPlaceSubviews];
    self.y_Refesh = - self.h_Refesh - self.ignoredScrollViewContentInsetTop;
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    [super scrollViewContentOffsetDidChange:change];
    
    if (self.state == YJRefreshStateRefreshing) {
        if (self.window == nil) return;
        
        CGFloat insetT = - self.superScrollView.offsetY_Refesh > _superScrollViewOriginalInset.top ? - self.superScrollView.offsetY_Refesh : _superScrollViewOriginalInset.top;
        insetT = insetT > self.h_Refesh + _superScrollViewOriginalInset.top ? self.h_Refesh + _superScrollViewOriginalInset.top : insetT;
        self.superScrollView.insetTop_Refesh = insetT;
        
        self.insetTDelta = _superScrollViewOriginalInset.top - insetT;
        return;
    }
    
    _superScrollViewOriginalInset = self.superScrollView.contentInset;
    
    CGFloat offsetY = self.superScrollView.offsetY_Refesh;
    CGFloat happenOffsetY = - self.superScrollViewOriginalInset.top;
    
    if (offsetY > happenOffsetY) return;
    
    CGFloat normal2pullingOffsetY = happenOffsetY - self.h_Refesh;
    CGFloat pullingPercent = (happenOffsetY - offsetY) / self.h_Refesh;
    
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
        
        // 保存刷新时间
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:self.lastUpdatedTimeKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
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
                CGFloat top = self.superScrollViewOriginalInset.top + self.h_Refesh;
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

- (NSDate *)lastUpdatedTime{
    return [[NSUserDefaults standardUserDefaults] objectForKey:self.lastUpdatedTimeKey];
}

#pragma mark - Support

@end
