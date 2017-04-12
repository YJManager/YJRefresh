//
//  UIScrollView+YJRefreshPosition.m
//  YJRefreshDemo
//
//  Created by YJHou on 2016/3/10.
//  Copyright © 2016年 Houmanager. All rights reserved.
//

#import "UIScrollView+YJRefreshPosition.h"

@implementation UIScrollView (YJRefreshPosition)

- (void)setInsetTop_Refesh:(CGFloat)insetTop_Refesh{
    UIEdgeInsets inset = self.contentInset;
    inset.top = insetTop_Refesh;
    self.contentInset = inset;
}

- (CGFloat)insetTop_Refesh{
    return self.contentInset.top;
}

- (void)setInsetBottom_Refesh:(CGFloat)insetBottom_Refesh{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = insetBottom_Refesh;
    self.contentInset = inset;
}

- (CGFloat)insetBottom_Refesh{
    return self.contentInset.bottom;
}

- (void)setInsetLeft_Refesh:(CGFloat)insetLeft_Refesh{
    UIEdgeInsets inset = self.contentInset;
    inset.left = insetLeft_Refesh;
    self.contentInset = inset;
}

- (CGFloat)insetLeft_Refesh{
    return self.contentInset.left;
}


- (void)setInsetRight_Refesh:(CGFloat)insetRight_Refesh{
    UIEdgeInsets inset = self.contentInset;
    inset.right = insetRight_Refesh;
    self.contentInset = inset;
}

- (CGFloat)insetRight_Refesh{
    return self.contentInset.right;
}


- (void)setOffsetX_Refesh:(CGFloat)offsetX_Refesh{
    CGPoint offset = self.contentOffset;
    offset.x = offsetX_Refesh;
    self.contentOffset = offset;
}

- (CGFloat)offsetX_Refesh{
    return self.contentOffset.x;
}

- (void)setOffsetY_Refesh:(CGFloat)offsetY_Refesh{
    CGPoint offset = self.contentOffset;
    offset.y = offsetY_Refesh;
    self.contentOffset = offset;
}

- (CGFloat)offsetY_Refesh{
    return self.contentOffset.y;
}


- (void)setContentW_Refesh:(CGFloat)contentW_Refesh{
    CGSize size = self.contentSize;
    size.width = contentW_Refesh;
    self.contentSize = size;
}

- (CGFloat)contentW_Refesh{
    return self.contentSize.width;
}

- (void)setContentH_Refesh:(CGFloat)contentH_Refesh{
    CGSize size = self.contentSize;
    size.height = contentH_Refesh;
    self.contentSize = size;
}

- (CGFloat)contentH_Refesh{
    return self.contentSize.height;
}

@end
