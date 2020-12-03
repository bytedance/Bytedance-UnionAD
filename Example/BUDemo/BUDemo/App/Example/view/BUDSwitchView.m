//
//  BUDSwitchView.m
//  BUDemo
//
//  Created by Rush.D.Xzj on 2020/10/22.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDSwitchView.h"

@interface BUDSwitchView ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UISwitch *switchView;

@end

@implementation BUDSwitchView


- (id)initWithTitle:(NSString *)title on:(BOOL)on height:(CGFloat)height {
    if (self = [self initWithFrame:CGRectZero]) {
        self.label.text = title;
        [self.label sizeToFit];
        
        self.switchView.on = on;
        
        [self addSubview:self.label];
        [self addSubview:self.switchView];
        
        CGFloat labelWidth = self.label.frame.size.width;
        CGFloat labelHeight = self.label.frame.size.height;
        CGFloat labelY = (height - labelHeight) / 2.0f;
        
        CGFloat switchViewWidth = self.switchView.frame.size.width;
        CGFloat switchViewHeight = self.switchView.frame.size.height;
        CGFloat switchViewX = labelWidth + 5;
        CGFloat switchViewY = (height - switchViewHeight) / 2.0f;
        
        CGFloat width = switchViewX + switchViewWidth;
        
        self.frame = CGRectMake(0, 0, width, height);
        self.label.frame = CGRectMake(0, labelY, labelWidth, labelHeight);
        self.switchView.frame = CGRectMake(switchViewX, switchViewY, switchViewWidth, switchViewHeight);
    }
    return self;
}


- (BOOL)isOn {
    return self.switchView.on;
}

#pragma mark - UI Getter
- (UILabel *)label {
    if (_label == nil) {
        _label = [UILabel new];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:17];
    }
    return _label;
}
- (UISwitch *)switchView {
    if (_switchView == nil) {
        _switchView = [UISwitch new];
    }
    return _switchView;
}

@end
