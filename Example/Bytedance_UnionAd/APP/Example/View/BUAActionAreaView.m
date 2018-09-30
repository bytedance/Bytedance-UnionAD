//
//  BUAActionAreaView.m
//  BUAemo
//
//  Created by carl on 2017/12/4.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import "BUAActionAreaView.h"
#import <WMAdSDK/WMAdSDK.h>

@implementation BUAActionAreaView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buildupView];
    }
    return self;
}

- (void)configWitModel:(WMMaterialMeta *)model {
    if (![model isKindOfClass:[WMMaterialMeta class]]) {
        return;
    }
    self.subTitleLabel.text = model.source;
    [self.actionButton setTitle:@"立即下载" forState:UIControlStateNormal];
    [self.actionButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    self.actionButton.frame = CGRectMake(width - 100 - 5, 0, 100, height);
    self.subTitleLabel.frame = CGRectMake(0, 0, width - 100 - 5, height);
}

- (void)buildupView {
    self.subTitleLabel = [UILabel new];
    [self addSubview:self.subTitleLabel];
    self.actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.actionButton];
}

@end
