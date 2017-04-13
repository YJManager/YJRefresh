//
//  YJRefreshNormalHeader.m
//  YJRefreshDemo
//
//  Created by YJHou on 2017/4/12.
//  Copyright © 2017年 Houmanager. All rights reserved.
//

#import "YJRefreshNormalHeader.h"
#import "NSDate+YJRefresh.h"

NSString *const YJRefreshHeaderLastUpdatedTimeKey    = @"YJRefreshHeaderLastUpdatedTimeKey";

@interface YJRefreshNormalHeader (){
    __unsafe_unretained UIImageView *_arrowView;
    __unsafe_unretained UILabel *_lastUpdatedTimeLabel;
    __unsafe_unretained UILabel *_stateLabel;
}
@property (weak, nonatomic) UIActivityIndicatorView *loadingView;
@property (strong, nonatomic) NSMutableDictionary *stateTitlesDict;

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
    
    self.labelLeftInset = YJRefreshLabelLeftInset;
    self.lastUpdatedTimeKey = YJRefreshHeaderLastUpdatedTimeKey;
    
    [self setTitle:YJRefreshHeaderIdleText forState:YJRefreshStateIdle];
    [self setTitle:YJRefreshHeaderPullingText forState:YJRefreshStatePulling];
    [self setTitle:YJRefreshHeaderRefreshingText forState:YJRefreshStateRefreshing];
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
    
    //ooooooo
    if (self.stateLabel.hidden) return;
    
    BOOL noConstrainsOnStatusLabel = self.stateLabel.constraints.count == 0;
    
    if (self.lastUpdatedTimeLabel.hidden) {
        if (noConstrainsOnStatusLabel) self.stateLabel.frame = self.bounds;
    } else {
        CGFloat stateLabelH = self.height_Refesh * 0.5;
        if (noConstrainsOnStatusLabel) {
            self.stateLabel.x_Refesh = 0;
            self.stateLabel.y_Refesh = 0;
            self.stateLabel.width_Refesh = self.width_Refesh;
            self.stateLabel.height_Refesh = stateLabelH;
        }
        
        if (self.lastUpdatedTimeLabel.constraints.count == 0) {
            self.lastUpdatedTimeLabel.x_Refesh = 0;
            self.lastUpdatedTimeLabel.y_Refesh = stateLabelH;
            self.lastUpdatedTimeLabel.width_Refesh = self.width_Refesh;
            self.lastUpdatedTimeLabel.height_Refesh = self.height_Refesh - self.lastUpdatedTimeLabel.y_Refesh;
        }
    }

}

- (void)setState:(YJRefreshState)state{
    YJRefreshCheckState
    
    if (state == YJRefreshStateIdle) {
        if (oldState == YJRefreshStateRefreshing) {
            
            // 保存刷新时间
            [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:YJRefreshHeaderLastUpdatedTimeKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
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
    
    self.stateLabel.text = self.stateTitlesDict[@(state)];
    self.lastUpdatedTimeKey = YJRefreshHeaderLastUpdatedTimeKey;
}

- (void)setLastUpdatedTimeKey:(NSString *)lastUpdatedTimeKey{
    
    if (self.lastUpdatedTimeLabel.hidden) return;
    
    NSDate *lastUpdatedTime = [[NSUserDefaults standardUserDefaults] objectForKey:lastUpdatedTimeKey];
    
    if (self.lastUpdatedTimeText) {
        self.lastUpdatedTimeLabel.text = self.lastUpdatedTimeText(lastUpdatedTime);
        return;
    }
    
    if (lastUpdatedTime) {
        
        NSDateFormatter *formatter = [NSDate yj_getDateFormatterWithDate:lastUpdatedTime];
        NSString *time = [formatter stringFromDate:lastUpdatedTime];
        NSString *todayString = [lastUpdatedTime yj_isToday]?YJRefreshHeaderDateTodayText:@"";
        self.lastUpdatedTimeLabel.text = [NSString stringWithFormat:@"%@%@%@", YJRefreshHeaderLastTimeText, todayString, time];
    } else {
        self.lastUpdatedTimeLabel.text = [NSString stringWithFormat:@"%@%@", YJRefreshHeaderLastTimeText, YJRefreshHeaderNoneLastDateText];
    }
}

- (NSDate *)lastUpdatedTime{
    return [[NSUserDefaults standardUserDefaults] objectForKey:YJRefreshHeaderLastUpdatedTimeKey];
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

- (void)setTitle:(NSString *)title forState:(YJRefreshState)state{
    if (title == nil) return;
    self.stateTitlesDict[@(state)] = title;
    self.stateLabel.text = self.stateTitlesDict[@(self.state)];
}

- (NSMutableDictionary *)stateTitlesDict{
    if (!_stateTitlesDict) {
        _stateTitlesDict = [NSMutableDictionary dictionary];
    }
    return _stateTitlesDict;
}

- (UILabel *)stateLabel{
    if (!_stateLabel) {
        [self addSubview:_stateLabel = [UILabel label_Refresh]];
    }
    return _stateLabel;
}

- (UILabel *)lastUpdatedTimeLabel{
    if (!_lastUpdatedTimeLabel) {
        [self addSubview:_lastUpdatedTimeLabel = [UILabel label_Refresh]];
    }
    return _lastUpdatedTimeLabel;
}

@end
