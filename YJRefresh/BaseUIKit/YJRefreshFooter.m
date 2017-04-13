//
//  YJRefreshFooter.m
//  YJRefreshDemo
//
//  Created by YJHou on 2017/4/10.
//  Copyright © 2017年 Houmanager. All rights reserved.
//

#import "YJRefreshFooter.h"

@interface YJRefreshFooter ()

@end

@implementation YJRefreshFooter

+ (instancetype)footerWithRefreshingBlock:(YJRefreshingBlock)refreshingBlock{
    YJRefreshFooter *footer = [[self alloc] init];
    footer.startRefreshingBlock = refreshingBlock;
    return footer;
}

+ (instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action{
    YJRefreshFooter *footer = [[self alloc] init];
    [footer setRefreshingTarget:target action:action];
    return footer;
}

- (void)prepareSetting{
    [super prepareSetting];
    self.h_Refesh = YJRefreshFooterHeight;
    self.automaticallyHidden = NO;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) {
        if ([self.superScrollView isKindOfClass:[UITableView class]] || [self.superScrollView isKindOfClass:[UICollectionView class]]) {
            [self.superScrollView setYj_reloadDataBlock:^(NSInteger totalDataCount) {
                if (self.isAutomaticallyHidden) {
                    self.hidden = (totalDataCount == 0);
                }
            }];
        }
    }
}

#pragma mark - Public
- (void)endRefreshingWithNoMoreData{
    self.state = YJRefreshStateNoMoreData;
}

- (void)resetNoMoreData{
    self.state = YJRefreshStateIdle;
}

@end
