//
//  BUMDCustomSplashView.m
//  BUMDemo
//
//  Created by bytedance on 2021/10/21.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "BUMDCustomSplashView.h"
#import "BUMDStoreViewController.h"

@interface BUMDCustomSplashView ()

@property (nonatomic, strong) UIButton *skipButton;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, assign) BOOL isShowing;

@property (nonatomic, weak) UIViewController *rootViewController;
@end

@implementation BUMDCustomSplashView

+ (instancetype)splashViewWithSize:(CGSize)size rootViewController:(nonnull UIViewController *)rootViewController {
    BUMDCustomSplashView *view = [[BUMDCustomSplashView alloc] initWithFrame:(CGRect){CGPointZero, size}];
    [view setupView];
    view.rootViewController = rootViewController;
    return view;
}

- (void)setupView {
    self.backgroundColor = [UIColor blackColor];
    self.contentLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.contentLabel.text = @"自定义开屏广告展示";
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
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClick)]];
}

- (void)callAction:(void(^)(NSInteger times))action withTimes:(NSInteger)times {
    if (!action || times <= 0) return;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        action(times - 1);
        [self callAction:action withTimes:times - 1];
    });
}

- (void)skipAction {
    [self dismiss:YES];
}

- (void)didClick {
    if (!self.rootViewController) return;
    BUMDStoreViewController *vc = [[BUMDStoreViewController alloc] init];
    [vc openAppStoreWithAppId:@"1142110895" fromViewController:self.rootViewController complete:^{
        
    }];
    if (self.didClickAction) self.didClickAction(self);
}

- (void)showInWindow:(UIWindow *)window {
    if (self.isShowing || !window) return;
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
    [window addSubview:self];
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
