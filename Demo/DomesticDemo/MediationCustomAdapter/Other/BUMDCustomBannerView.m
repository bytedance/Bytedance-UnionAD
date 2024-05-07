//
//  BUMDCustomBannerView.m
//  BUMDemo
//
//  Created by bytedance on 2021/10/20.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "BUMDCustomBannerView.h"

@implementation BUMDCustomBannerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setTitle:@"banner广告模拟" forState:UIControlStateNormal];
        self.backgroundColor = [UIColor grayColor];
        self.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - 30, 0, 30, 30)];
        [btn setTitle:@"[X]" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    if (self.superview && self.didMoveToSuperViewCallback) {
        self.didMoveToSuperViewCallback(self);
        self.didMoveToSuperViewCallback = nil;
    }
}

- (void)close {
    if (self.closeAction) self.closeAction(self);
}

@end
