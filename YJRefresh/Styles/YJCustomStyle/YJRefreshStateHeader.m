//
//  YJRefreshStateHeader.m
//  YJRefreshDemo
//
//  Created by YJHou on 2017/4/13.
//  Copyright © 2017年 Houmanager. All rights reserved.
//

#import "YJRefreshStateHeader.h"
#import "NSDate+YJRefresh.h"

NSString *const YJRefreshHeaderLastUpdatedTimeKey    = @"YJRefreshHeaderLastUpdatedTimeKey";

@interface YJRefreshStateHeader (){
    __unsafe_unretained UILabel *_lastUpdatedTimeLabel;
    __unsafe_unretained UILabel *_stateLabel;
}
@property (strong, nonatomic) NSMutableDictionary *stateTitlesDict;

@end

@implementation YJRefreshStateHeader


- (void)prepareSetting{
    [super prepareSetting];
    
    self.labelLeftInset = YJRefreshLabelLeftInset;
    self.lastUpdatedTimeKey = YJRefreshHeaderLastUpdatedTimeKey;
    
    [self setTitle:YJRefreshHeaderIdleText forState:YJRefreshStateIdle];
    [self setTitle:YJRefreshHeaderPullingText forState:YJRefreshStatePulling];
    [self setTitle:YJRefreshHeaderRefreshingText forState:YJRefreshStateRefreshing];
}

- (void)layoutPlaceSubviews{
    [super layoutPlaceSubviews];
    
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
        }
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
