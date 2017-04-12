//
//  UIScrollView+YJRefresh.m
//  YJRefreshDemo
//
//  Created by YJHou on 2017/4/12.
//  Copyright © 2017年 Houmanager. All rights reserved.
//

#import "UIScrollView+YJRefresh.h"
#import <objc/runtime.h>
#import "YJRefreshHeader.h"
#import "YJRefreshFooter.h"
#import "NSObject+YJRefresh.h"

static const char YJRefreshReloadDataBlockKey = '\0';   /**< 刷新 */
static const char YJRefreshHeaderKey = '\0';            /**< 头 */
static const char YJRefreshFooterKey = '\0';            /**< 尾部 */

@implementation UIScrollView (YJRefresh)

- (void)setYj_reloadDataBlock:(void (^)(NSInteger))yj_reloadDataBlock{
    NSString *key = @"yj_reloadDataBlock";
    [self willChangeValueForKey:key];
    objc_setAssociatedObject(self, &YJRefreshReloadDataBlockKey, yj_reloadDataBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:key];
}

- (void (^)(NSInteger))yj_reloadDataBlock{
    return objc_getAssociatedObject(self, &YJRefreshReloadDataBlockKey);
}

#pragma mark - Refresh_Header
- (void)setHeader_Refresh:(YJRefreshHeader *)header_Refresh{
    if (header_Refresh != self.header_Refresh) {
        // 1.移除旧的，添加新的
        [self.header_Refresh removeFromSuperview];
        [self insertSubview:header_Refresh atIndex:0];
        
        // 2. 保存新的
        NSString *key = @"header_Refresh";
        [self willChangeValueForKey:key];
        objc_setAssociatedObject(self, &YJRefreshHeaderKey, header_Refresh, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:key];
    }
    
}

- (YJRefreshHeader *)header_Refresh{
    YJRefreshHeader *header = objc_getAssociatedObject(self, &YJRefreshHeaderKey);
    return header;
}

#pragma mark - Refresh_Footer
- (void)setFooter_Refresh:(YJRefreshFooter *)footer_Refresh{
    if (footer_Refresh != self.footer_Refresh) {
        [self.footer_Refresh removeFromSuperview];
        [self insertSubview:footer_Refresh atIndex:0];
        
        NSString *key = @"footer_Refresh";
        [self willChangeValueForKey:key];
        objc_setAssociatedObject(self, &YJRefreshFooterKey, footer_Refresh, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:key];
    }
}

- (YJRefreshFooter *)footer_Refresh{
    return objc_getAssociatedObject(self, &YJRefreshFooterKey);
}

#pragma mark - OtherFunction
- (NSInteger)yj_totalDataCount_Refresh{
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        
        for (NSInteger section = 0; section<tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        
        for (NSInteger section = 0; section<collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}

#pragma mark - Private_Function
- (void)_executeReloadDataBlock{
    if (self.yj_reloadDataBlock) {
        self.yj_reloadDataBlock(self.yj_totalDataCount_Refresh);
    }
}

@end


#pragma mark - UITableView
@implementation UITableView (YJRefresh)

+ (void)load{
    [self yj_exchangeInstanceMethod1:@selector(reloadData) method2:@selector(yj_reloadData)];
}

- (void)yj_reloadData{
    [self yj_reloadData];
    [self _executeReloadDataBlock];
}
@end

#pragma mark - UICollectionView
@implementation UICollectionView (YJRefresh)

+ (void)load{
    [self yj_exchangeInstanceMethod1:@selector(reloadData) method2:@selector(yj_reloadData)];
}

- (void)yj_reloadData{
    [self yj_reloadData];
    [self _executeReloadDataBlock];
}

@end
