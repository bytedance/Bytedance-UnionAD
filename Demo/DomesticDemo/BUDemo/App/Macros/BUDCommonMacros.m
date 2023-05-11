//
//  BUDCommonMacros.m
//  BUDAdSDK
//
//  Created by 崔亚楠 on 2018/10/23.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDCommonMacros.h"
#import <UIKit/UIKit.h>
#import "UIWindow+BUDUtilities.h"

UIInterfaceOrientation bud_currentInterfaceOrientation(void) {
    UIInterfaceOrientation orientation = UIInterfaceOrientationUnknown;
    if (@available(iOS 13.0, *)) {
        orientation = [UIWindow bud_mainWindow].windowScene.interfaceOrientation;
    } else {
        orientation = [UIApplication sharedApplication].statusBarOrientation;
    }
    return orientation;
}

UIEdgeInsets buad_safe_area_insets (void) {
    static UIEdgeInsets _BUDSafeAreaInsetsValue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 11.0, *)) {
            _BUDSafeAreaInsetsValue = [UIWindow bud_mainWindow].safeAreaInsets;
        } else {
            _BUDSafeAreaInsetsValue = UIEdgeInsetsZero;
        }
    });
    return  _BUDSafeAreaInsetsValue;
}

BOOL bud_is_notch_screen(void) {
    static BOOL _is_notch_screen;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIEdgeInsets insets = buad_safe_area_insets();
        UIInterfaceOrientation orientation = bud_currentInterfaceOrientation();
        if (orientation != UIInterfaceOrientationLandscapeLeft && orientation != UIInterfaceOrientationLandscapeRight) {
            /* 竖屏
             * iPhone 12    {47, 0, 34, 0}
             * iPhone X     {44, 0, 34, 0}
             * iPhone 8     {20, 0, 0, 0}
             */
            _is_notch_screen = insets.top > 20;
        } else {
            /* 横屏
             * iPhone 12    {0, 47, 21, 47}
             * iPhone X     {0, 44, 21, 44}
             * iPhone 8     {0, 0, 0, 0}
             */
            _is_notch_screen = insets.left > 20;
        }
    });
    return _is_notch_screen;
}
