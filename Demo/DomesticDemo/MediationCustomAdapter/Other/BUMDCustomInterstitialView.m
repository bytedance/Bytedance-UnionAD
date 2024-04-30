//
//  BUMDCustomInterstitialView.m
//  BUMDemo
//
//  Created by bytedance on 2021/11/3.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "BUMDCustomInterstitialView.h"

@interface BUMDCustomInterstitialView ()

@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, assign) BOOL isShowing;

@end

@implementation BUMDCustomInterstitialView

+ (instancetype)interstitialViewWithSize:(CGSize)size {
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    BUMDCustomInterstitialView *view = [[BUMDCustomInterstitialView alloc] initWithFrame:frame];
    [view setupView];
    return view;
}

- (void)setupView {
    self.backgroundColor = [UIColor blackColor];
    self.contentLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.contentLabel.text = @"自定义插屏广告展示";
    self.contentLabel.textColor = [UIColor whiteColor];
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    self.contentLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    [self addSubview:self.contentLabel];
    
    self.closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 57, 34)];
    [self.closeButton setTitle:@"[X]" forState:UIControlStateNormal];
    [self.closeButton setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.3]];
    self.closeButton.frame = CGRectOffset(self.closeButton.frame, self.frame.size.width - self.closeButton.frame.size.width - 15, 60);
    [self addSubview:self.closeButton];
    [self.closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    self.closeButton.layer.cornerRadius = 17;
    [self.closeButton clipsToBounds];
}

- (void)showInViewController:(UIViewController *)viewController {
    if (self.isShowing || !viewController) return;
    self.isShowing = YES;
    self.contentLabel.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1 animations:^{
        self.contentLabel.transform = CGAffineTransformMakeScale( 1.5, 1.5);
    }];
    [viewController.view addSubview:self];
}

- (void)closeAction {
    if (!self.isShowing) return;
    self.isShowing = NO;
    [self removeFromSuperview];
    if (self.closeCallback) {
        self.closeCallback(self);
    }
}

@end
