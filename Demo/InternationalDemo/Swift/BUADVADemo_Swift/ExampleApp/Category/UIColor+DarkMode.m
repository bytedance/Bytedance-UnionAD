//
//  BUADVADemo_Swift
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

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
