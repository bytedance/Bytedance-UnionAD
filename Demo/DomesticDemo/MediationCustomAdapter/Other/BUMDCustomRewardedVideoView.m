//
//  BUMDCustomRewardedVideoView.m
//  BUMDemo
//
//  Created by bytedance on 2021/10/20.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "BUMDCustomRewardedVideoView.h"

@interface BUMDCustomRewardedVideoView ()

@property (nonatomic, strong) UIButton *skipButton;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, assign) BOOL isShowing;

@end

@implementation BUMDCustomRewardedVideoView

+ (instancetype)fullscreenView {
    BUMDCustomRewardedVideoView *view = [[BUMDCustomRewardedVideoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [view setupView];
    return view;
}

- (void)setupView {
    self.backgroundColor = [UIColor blackColor];
    self.contentLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.contentLabel.text = @"自定义激励视频广告展示";
    self.contentLabel.textColor = [UIColor whiteColor];
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    self.contentLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    [self addSubview:self.contentLabel];
    
    self.skipButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 57, 34)];
    [self.skipButton setTitle:@"跳过" forState:UIControlStateNormal];
    [self.skipButton setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.3]];
    self.skipButton.frame = CGRectOffset(self.skipButton.frame, self.frame.size.width - self.skipButton.frame.size.width - 15, 60);
    [self addSubview:self.skipButton];
    [self.skipButton addTarget:self action:@selector(skipAction) forControlEvents:UIControlEventTouchUpInside];
    self.skipButton.layer.cornerRadius = 17;
    [self.skipButton clipsToBounds];
}

- (void)callAction:(void(^)(NSInteger times))action withTimes:(NSInteger)times {
    if (!action || times <= 0) return;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        action(times - 1);
        [self callAction:action withTimes:times - 1];
    });
}

- (void)skipAction {
    if (self.skipCallback) self.skipCallback(self);
    [self dismiss:YES];
}

- (void)showInViewController:(UIViewController *)viewController {
    if (self.isShowing || !viewController) return;
    self.isShowing = YES;
    self.contentLabel.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1 animations:^{
        self.contentLabel.transform = CGAffineTransformMakeScale( 1.5, 1.5);
    }];
    [self callAction:^(NSInteger times) {
        if (times != 0) {
            [UIView animateWithDuration:1 animations:^{
                NSInteger factor = times % 2;
                self.contentLabel.transform = CGAffineTransformMakeScale( 0.5 + factor, 0.5 + factor);
            }];
            return;
        }
        [self dismiss:NO];
    } withTimes:5];
    [viewController.view addSubview:self];
}

- (void)dismiss:(BOOL)skip {
    if (!self.isShowing) return;
    self.isShowing = NO;
    [self removeFromSuperview];
    if (self.dismissCallback) {
        self.dismissCallback(self, skip);
    }
}
@end
