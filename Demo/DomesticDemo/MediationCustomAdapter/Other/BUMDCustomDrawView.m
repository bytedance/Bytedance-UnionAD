//
//  BUMDCustomDrawView.m
//  BUMDemo
//
//  Created by ByteDance on 2022/5/6.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import "BUMDCustomDrawView.h"

@implementation BUMDCustomDrawView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor lightGrayColor];
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

@end
