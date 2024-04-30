//
//  BUMDCustomNativeView.m
//  BUMDemo
//
//  Created by bytedance on 2021/10/21.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "BUMDCustomNativeView.h"

@implementation BUMDCustomNativeView

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
