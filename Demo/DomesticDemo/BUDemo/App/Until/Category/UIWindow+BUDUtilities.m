//
//  UIWindow+BUUtilities.m
//  BUFoundation
//
//  Created by Rush.D.Xzj on 2020/12/17.
//

#import "UIWindow+BUDUtilities.h"

@implementation UIWindow (BUDUtilities)

+ (UIWindow *)bud_mainWindow
{
    UIWindow *window = nil;
    if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
        window = [[UIApplication sharedApplication].delegate window];
    }
    if (![window isKindOfClass:[UIView class]]) {
        window = [UIApplication sharedApplication].keyWindow;
    }
    
    if (!window) {
        if (@available(iOS 15.0, *)) {
            
        } else {
            for (UIWindow *keyWin in [UIApplication sharedApplication].windows) {
                if (keyWin.isKeyWindow) {
                    window = keyWin;
                    break;
                }
            }
        }
    }
    if (!window) {
        if (@available(iOS 13.0, *)) {
            for (UIWindowScene *scene in [UIApplication sharedApplication].connectedScenes) {
                for (UIWindow *subWindow in scene.windows) {
                    if (subWindow.isKeyWindow) {
                        return subWindow;
                    }
                }
            }
        }
    }
    return window;
}

@end
