//
//  BUMDCustomSplashView.h
//  BUMDemo
//
//  Created by bytedance on 2021/10/21.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUMDCustomSplashView : UIView

+ (instancetype)splashViewWithSize:(CGSize)size rootViewController:(UIViewController *)rootViewController;

@property (nonatomic, copy) void(^didClickAction)(BUMDCustomSplashView *view);

@property (nonatomic, copy) void(^dismissCallback)(BUMDCustomSplashView *view, BOOL skip);

- (void)showInWindow:(UIWindow *)window;
@end

NS_ASSUME_NONNULL_END
