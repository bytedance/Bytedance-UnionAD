//
//  BUMDCustomInterstitialView.h
//  BUMDemo
//
//  Created by bytedance on 2021/11/3.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUMDCustomInterstitialView : UIView

+ (instancetype)interstitialViewWithSize:(CGSize)size;

- (void)showInViewController:(UIViewController *)viewController;

@property (nonatomic, copy) void(^closeCallback)(BUMDCustomInterstitialView *view);

@end

NS_ASSUME_NONNULL_END
