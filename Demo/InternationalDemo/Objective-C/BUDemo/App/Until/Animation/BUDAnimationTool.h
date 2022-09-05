//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <BUAdSDK/BUAdSDK.h>
typedef void (^BUDAnimationCompletion)(void);
NS_ASSUME_NONNULL_BEGIN

@interface BUDAnimationTool : NSObject
@property (nonatomic, strong, nullable) UIViewController *splashContainerVC;

+ (instancetype)sharedInstance;
- (void)transitionFromView:(UIView *)fromView toView:(BUSplashZoomOutView *)toView splashCompletion:(BUDAnimationCompletion)splashCompletion;
@end

NS_ASSUME_NONNULL_END
