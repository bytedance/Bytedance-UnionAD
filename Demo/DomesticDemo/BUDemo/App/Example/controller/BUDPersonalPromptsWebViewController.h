//
//  BUDPersonalPromptsWebViewController.h
//  BUDemo
//
//  Created by bytedance on 2020/12/15.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BUAdSDK/BUAdSDK.h>
NS_ASSUME_NONNULL_BEGIN
@class BUNativeAd;
@interface BUDPersonalPromptsWebViewController : UIViewController
- (instancetype)initWithNativeAd:(BUNativeAd *)nativeAd;
@end

NS_ASSUME_NONNULL_END
