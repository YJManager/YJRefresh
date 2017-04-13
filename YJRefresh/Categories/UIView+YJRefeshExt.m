//
//  UIView+YJRefeshExt.m
//  YJRefreshDemo
//
//  Created by YJHou on 2016/3/10.
//  Copyright © 2016年 Houmanager. All rights reserved.
//

#import "UIView+YJRefeshExt.h"

@implementation UIView (YJRefeshExt)

- (void)setX_Refesh:(CGFloat)x_Refesh{
    CGRect frame = self.frame;
    frame.origin.x = x_Refesh;
    self.frame = frame;
}

- (CGFloat)x_Refesh{
    return self.frame.origin.x;
}

- (void)setY_Refesh:(CGFloat)y_Refesh{
    CGRect frame = self.frame;
    frame.origin.y = y_Refesh;
    self.frame = frame;
}

- (CGFloat)y_Refesh{
    return self.frame.origin.y;
}

- (void)setWidth_Refesh:(CGFloat)width_Refesh{
    CGRect frame = self.frame;
    frame.size.width = width_Refesh;
    self.frame = frame;
}

- (CGFloat)width_Refesh{
    return self.frame.size.width;
}

- (void)setHeight_Refesh:(CGFloat)height_Refesh{
    CGRect frame = self.frame;
    frame.size.height = height_Refesh;
    self.frame = frame;
}

- (CGFloat)height_Refesh{
    return self.frame.size.height;
}

- (void)setOrigin_Refesh:(CGPoint)origin_Refesh{
    CGRect frame = self.frame;
    frame.origin = origin_Refesh;
    self.frame = frame;
}

- (CGPoint)origin_Refesh{
    return self.frame.origin;
}

- (void)setSize_Refesh:(CGSize)size_Refesh{
    CGRect frame = self.frame;
    frame.size = size_Refesh;
    self.frame = frame;
}

- (CGSize)size_Refesh{
    return self.frame.size;
}

@end
