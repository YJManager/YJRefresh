//
//  YJRefreshNormalHeader.m
//  YJRefreshDemo
//
//  Created by YJHou on 2017/4/12.
//  Copyright © 2017年 Houmanager. All rights reserved.
//

#import "YJRefreshNormalHeader.h"

@interface YJRefreshNormalHeader (){
    __unsafe_unretained UIImageView *_arrowView;
}
@property (weak, nonatomic) UIActivityIndicatorView *loadingView;

@end

@implementation YJRefreshNormalHeader


- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle{
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    self.loadingView = nil;
    [self setNeedsLayout];
}

- (void)prepareSetting{
    [super prepareSetting];
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    self.backgroundColor = [UIColor grayColor];
}

- (void)layoutPlaceSubviews{
    [super layoutPlaceSubviews];
    
    // 箭头的中心点
    CGFloat arrowCenterX = self.width_Refesh * 0.5;
    if (!self.stateLabel.hidden) {
        CGFloat stateWidth = self.stateLabel.textWith_Refresh;
        CGFloat timeWidth = 0.0;
        if (!self.lastUpdatedTimeLabel.hidden) {
            timeWidth = self.lastUpdatedTimeLabel.textWith_Refresh;
        }
        CGFloat textWidth = MAX(stateWidth, timeWidth);
        arrowCenterX -= textWidth / 2 + self.labelLeftInset;
    }
    CGFloat arrowCenterY = self.height_Refesh * 0.5;
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    
    if (self.arrowView.constraints.count == 0) {
        self.arrowView.size_Refesh = self.arrowView.image.size;
        self.arrowView.center = arrowCenter;
    }
    
    if (self.loadingView.constraints.count == 0) {
        self.loadingView.center = arrowCenter;
    }
    self.arrowView.tintColor = self.stateLabel.textColor;
}

- (void)setState:(YJRefreshState)state{
    YJRefreshCheckState
    
    if (state == YJRefreshStateIdle) {
        if (oldState == YJRefreshStateRefreshing) {
            self.arrowView.transform = CGAffineTransformIdentity;
            
            [UIView animateWithDuration:YJRefreshSlowAnimationDuration animations:^{
                self.loadingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
                if (self.state != YJRefreshStateIdle) return;
                
                self.loadingView.alpha = 1.0;
                [self.loadingView stopAnimating];
                self.arrowView.hidden = NO;
            }];
        } else {
            [self.loadingView stopAnimating];
            self.arrowView.hidden = NO;
            [UIView animateWithDuration:YJRefreshFastAnimationDuration animations:^{
                self.arrowView.transform = CGAffineTransformIdentity;
            }];
        }
    } else if (state == YJRefreshStatePulling) {
        [self.loadingView stopAnimating];
        self.arrowView.hidden = NO;
        [UIView animateWithDuration:YJRefreshFastAnimationDuration animations:^{
            self.arrowView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
        }];
    } else if (state == YJRefreshStateRefreshing) {
        self.loadingView.alpha = 1.0; // 防止refreshing -> idle的动画完毕动作没有被执行
        [self.loadingView startAnimating];
        self.arrowView.hidden = YES;
    }
}

#pragma mark - Lazy
- (UIImageView *)arrowView{
    if (!_arrowView) {
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yj_refresh_arrow"]];
        [self addSubview:_arrowView = arrowView];
    }
    return _arrowView;
}

- (UIActivityIndicatorView *)loadingView{
    if (!_loadingView) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
        loadingView.hidesWhenStopped = YES;
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}



@end
