//
//  BUSplashAdView.h
//  BUAdSDK
//
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BUSplashAdDelegate;

@interface BUSplashAdView : UIView
/**
The unique identifier of splash ad.
 */
@property (nonatomic, copy, readonly, nonnull) NSString *slotID;

/**
 Maximum allowable load timeout, default 2s, unit s.
 */
@property (nonatomic, assign) NSTimeInterval tolerateTimeout;


/**
 Whether hide skip button, default NO.
 If you hide the skip button, you need to customize the countdown.
 */
@property (nonatomic, assign) BOOL hideSkipButton;

/**
 The delegate for receiving state change messages.
 */
@property (nonatomic, weak, nullable) id<BUSplashAdDelegate> delegate;

/*
 required.
 Root view controller for handling ad actions.
 */
@property (nonatomic, weak) UIViewController *rootViewController;

/**
 Whether the splash ad data has been loaded.
 */
@property (nonatomic, getter=isAdValid, readonly) BOOL adValid;


/**
 Initializes splash ad with slot id and frame.
 @param slotID : the unique identifier of splash ad
 @param frame : the frame of splashAd view. It is recommended for the mobile phone screen.
 @return BUSplashAdView
 */
- (instancetype)initWithSlotID:(NSString *)slotID frame:(CGRect)frame;

/**
 Load splash ad datas.
 Start the countdown(@tolerateTimeout) as soon as you request datas.
 */
- (void)loadAdData;

@end


@protocol BUSplashAdDelegate <NSObject>

@optional
/**
 This method is called when splash ad material loaded successfully.
 */
- (void)splashAdDidLoad:(BUSplashAdView *)splashAd;

/**
 This method is called when splash ad material failed to load.
 @param error : the reason of error
 */
- (void)splashAd:(BUSplashAdView *)splashAd didFailWithError:(NSError *)error;

/**
 This method is called when splash ad slot will be showing.
 */
- (void)splashAdWillVisible:(BUSplashAdView *)splashAd;

/**
 This method is called when splash ad is clicked.
 */
- (void)splashAdDidClick:(BUSplashAdView *)splashAd;

/**
 This method is called when splash ad is closed.
 */
- (void)splashAdDidClose:(BUSplashAdView *)splashAd;

/**
 This method is called when splash ad is about to close.
 */
- (void)splashAdWillClose:(BUSplashAdView *)splashAd;

@end

NS_ASSUME_NONNULL_END

