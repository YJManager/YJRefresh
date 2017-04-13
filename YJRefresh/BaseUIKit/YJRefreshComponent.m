//
//  YJRefreshComponent.m
//  YJRefreshDemo
//
//  Created by YJHou on 2016/4/12.
//  Copyright © 2016年 Houmanager. All rights reserved.
//

#import "YJRefreshComponent.h"

NSString *const YJRefreshKeyPathContentOffset        = @"contentOffset";
NSString *const YJRefreshKeyPathContentSize          = @"contentSize";
NSString *const YJRefreshKeyPathPanState             = @"state";

@interface YJRefreshComponent ()

@property (nonatomic, strong) UIPanGestureRecognizer *pan; /**< 手势 */
@property (weak, nonatomic) id refreshingTarget;     /**< 回调对象 */
@property (assign, nonatomic) SEL refreshingAction;  /**< 回调方法 */
@property (copy, nonatomic) YJRefreshingBlock beginRefreshingBlock;

@end

@implementation YJRefreshComponent

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareSetting];
        self.state = YJRefreshStateIdle;
    }
    return self;
}

- (void)prepareSetting{
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.backgroundColor = [UIColor clearColor];
}

- (void)layoutSubviews{
    [self layoutPlaceSubviews];
    [super layoutSubviews];
}

- (void)layoutPlaceSubviews{}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]]) return;
    
    // 1.旧的父控件移除监听
    [self _removeObservers];
    
    // 2.添加新的控件监听
    if (newSuperview) {
        self.w_Refesh = newSuperview.w_Refesh;
        self.x_Refesh = 0;
        
        _superScrollView = (UIScrollView *)newSuperview;
        _superScrollView.alwaysBounceVertical = YES;
        _superScrollViewOriginalInset = _superScrollView.contentInset;
        [self _addObservers];
    }
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    // 预防view还没显示出来就调用了beginRefreshing
    if (self.state == YJRefreshStateWillRefresh) {
        self.state = YJRefreshStateRefreshing;
    }
}

- (void)setRefreshingTarget:(id)target action:(SEL)action{
    self.refreshingTarget = target;
    self.refreshingAction = action;
}

- (void)setState:(YJRefreshState)state{
    _state = state;
    
    // 加入主队列的目的是等setState:方法调用完毕、设置完文字后再去布局子控件
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setNeedsLayout];
    });
}

#pragma mark 进入刷新状态
- (void)startRefreshing{
    [UIView animateWithDuration:YJRefreshFastAnimationDuration animations:^{
        self.alpha = 1.0;
    }];
    self.pullingPercent = 1.0;
    if (self.window) {
        self.state = YJRefreshStateRefreshing;
    } else {
        // 预防正在刷新中时，调用本方法使得header inset回置失败
        if (self.state != YJRefreshStateRefreshing) {
            self.state = YJRefreshStateWillRefresh;
            // 刷新(预防从另一个控制器回到这个控制器的情况，回来要重新刷新一下)
            [self setNeedsDisplay];
        }
    }
}

- (void)startRefreshingWithCompletionBlock:(YJRefreshingBlock)completionBlock{
    self.beginRefreshingBlock = completionBlock;
    [self startRefreshing];
}

- (void)stopRefreshing{
    self.state = YJRefreshStateIdle;
}

- (void)stopRefreshingWithCompletionBlock:(YJRefreshingBlock)completionBlock{
    self.stopRefreshingBlock = completionBlock;
    [self stopRefreshing];
}

- (BOOL)isRefreshing{
    return self.state == YJRefreshStateRefreshing || self.state == YJRefreshStateWillRefresh;
}

- (void)setAutomaticallyChangeAlpha:(BOOL)automaticallyChangeAlpha{
    _automaticallyChangeAlpha = automaticallyChangeAlpha;
    if (self.isRefreshing) return;
    if (automaticallyChangeAlpha) {
        self.alpha = self.pullingPercent;
    } else {
        self.alpha = 1.0;
    }
}

- (void)setPullingPercent:(CGFloat)pullingPercent{
    _pullingPercent = pullingPercent;
    
    if (self.isRefreshing) return;
    
    if (self.isAutomaticallyChangeAlpha) {
        self.alpha = pullingPercent;
    }
}

#pragma mark - PrivateFunction
- (void)_addObservers{
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.superScrollView addObserver:self forKeyPath:YJRefreshKeyPathContentOffset options:options context:nil];
    [self.superScrollView addObserver:self forKeyPath:YJRefreshKeyPathContentSize options:options context:nil];
    self.pan = self.superScrollView.panGestureRecognizer;
    [self.pan addObserver:self forKeyPath:YJRefreshKeyPathPanState options:options context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    // 1.手势不可用
    if (!self.userInteractionEnabled) return;
    
    if ([keyPath isEqualToString:YJRefreshKeyPathContentSize]) {
        [self scrollViewContentSizeDidChange:change];
    }
    
    // 2.控件看不见了
    if (self.hidden) return;
    if ([keyPath isEqualToString:YJRefreshKeyPathContentOffset]) {
        [self scrollViewContentOffsetDidChange:change];
    } else if ([keyPath isEqualToString:YJRefreshKeyPathPanState]) {
        [self scrollViewPanStateDidChange:change];
    }
}

- (void)_removeObservers{
    [self.superview removeObserver:self forKeyPath:YJRefreshKeyPathContentOffset];
    [self.superview removeObserver:self forKeyPath:YJRefreshKeyPathContentSize];;
    [self.pan removeObserver:self forKeyPath:YJRefreshKeyPathPanState];
    self.pan = nil;
}

#pragma mark - PublicFunction
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{}
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change{}
- (void)scrollViewPanStateDidChange:(NSDictionary *)change{}

- (void)executeRefreshingCallback{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.startRefreshingBlock) {
            self.startRefreshingBlock();
        }
        if ([self.refreshingTarget respondsToSelector:self.refreshingAction]) {
            ((void (*)(void *, SEL, UIView *))objc_msgSend)((__bridge void *)(self.refreshingTarget), self.refreshingAction, self);
        }
        if (self.beginRefreshingBlock) {
            self.beginRefreshingBlock();
        }
    });
}

@end
