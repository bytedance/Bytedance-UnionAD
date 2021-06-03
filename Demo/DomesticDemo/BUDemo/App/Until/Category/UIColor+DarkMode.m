//
//  UIColor+DarkMode.m
//  BUDemo
//
//  Created by Willie on 2021/3/22.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "UIColor+DarkMode.h"

@implementation UIColor (DarkMode)

+ (UIColor *)bud_systemBackgroundColor {
    if (@available(iOS 13.0, *)) {
        return UIColor.systemBackgroundColor;
    } else {
        return UIColor.whiteColor;
    }
}

@end
