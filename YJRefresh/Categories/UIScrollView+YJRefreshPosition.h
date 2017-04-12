//
//  UIScrollView+YJRefreshPosition.h
//  YJRefreshDemo
//
//  Created by YJHou on 2016/3/10.
//  Copyright © 2016年 Houmanager. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (YJRefreshPosition)

@property (nonatomic, assign) CGFloat insetTop_Refesh;     /**< 顶部 */
@property (nonatomic, assign) CGFloat insetBottom_Refesh;  /**< 底部 */
@property (nonatomic, assign) CGFloat insetLeft_Refesh;    /**< 左部 */
@property (nonatomic, assign) CGFloat insetRight_Refesh;   /**< 右部 */

@property (nonatomic, assign) CGFloat offsetX_Refesh;      /**< X */
@property (nonatomic, assign) CGFloat offsetY_Refesh;      /**< Y */

@property (nonatomic, assign) CGFloat contentW_Refesh;     /**< 宽 */
@property (nonatomic, assign) CGFloat contentH_Refesh;     /**< 高 */

@end
