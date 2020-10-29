//
//  BUUIResponderHelper.h
//  BUSDKProject
//
//  Created by ranny_90 on 2017/5/20.
//  Copyright © 2017年 ranny_90. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUUIResponderHelper : NSObject

// 获取当前应用的广义mainWindow
+ (nullable UIWindow *)mainWindow;

// 获取广义mainWindow的rootViewController
+ (nullable UIViewController*)mainWindowRootViewController;

// 广义mainWindow的大小（兼容iOS7）
+ (CGSize)windowSize;


// 获取指定UIResponder的链下游第一个ViewController对象
+ (nullable UIViewController*)nextViewControllerFor:(UIResponder* _Nullable)responder;

// 获取指定UIResponder的链下游第一个UINavigationController对象
+ (nullable UINavigationController*)nextNavigationControllerFor:(UIResponder* _Nullable)responder;

/** 查找当前显示的ViewController*/
+ (UIViewController *)topViewController;

+ (UIViewController *)recursiveFindCurrentShowViewControllerFromViewController:(UIViewController *)fromVC;
@end

NS_ASSUME_NONNULL_END
