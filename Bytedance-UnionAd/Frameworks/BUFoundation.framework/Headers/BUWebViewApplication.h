//
//  BUJSApplication.h
//  BURexxar
//
//  Created by muhuai on 2017/4/26.
//  Copyright © 2017年 muhuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "BURexxarEngine.h"
#import "BUWebViewDefine.h"

extern NSString *const kBUBytedanceScheme;
extern NSString *const kBUBytedanceDomReadyHost;

@interface BUWebViewApplication : NSObject


+ (BOOL)handleRequest:(NSURLRequest *)request withWebView:(UIView<BUWebView> *)webView viewController:(UIViewController *)viewController;

+ (void)fireEvent:(NSString *)eventName data:(NSDictionary *)data withWebView:(UIView<BUWebView> *)webview;

/**
 注册JSBridge别名
 @warning 会优先查找别名
 @param alias 新名
 @param orig 原名
 */
+ (void)registeJSBAlias:(NSString *)alias for:(NSString *)orig;
@end
