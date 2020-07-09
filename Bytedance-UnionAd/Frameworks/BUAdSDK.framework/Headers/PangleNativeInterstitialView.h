//
//  PangleNativeInterstitialView.h
//  BUDemo
//
//  Created by bytedance on 2020/4/24.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BUAdSDK/BUNativeAd.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PangleNativeInterstitialViewDelegate <NSObject>

- (void)nativeInterstitialAdWillClose:(BUNativeAd *)nativeAd;
- (void)nativeInterstitialAdDidClose:(BUNativeAd *)nativeAd;

@end

@interface PangleNativeInterstitialView : UIViewController

@property (nonatomic, getter=isAdValid, readonly) BOOL adValid;

- (void)refreshUIWithAd:(BUNativeAd *_Nonnull)nativeAd;
- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController delegate:(id <PangleNativeInterstitialViewDelegate>)delegate;
@end

NS_ASSUME_NONNULL_END
