//
//  BUNativeAdsManager.h
//  BUAdSDK
//
//  Created by chenren on 24/05/2017.
//  Copyright © 2017 bytedance. All rights reserved.
//

/**
 BUNativeAdsManager适用于同时请求多条广告，
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BUAdSlot.h"
#import "BUMaterialMeta.h"
#import "BUNativeAd.h"

@protocol BUNativeAdsManagerDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface BUNativeAdsManager : NSObject

@property (nonatomic, strong, nullable) BUAdSlot *adslot;
@property (nonatomic, strong, nullable) NSArray<BUNativeAd *> *data;
/// 广告位加载展示响应的代理回调，可以设置为遵循<BUNativeAdDelegate>的任何类型，不限于Viewcontroller
@property (nonatomic, weak, nullable) id<BUNativeAdsManagerDelegate> delegate;

- (instancetype)initWithSlot:(BUAdSlot * _Nullable) slot;

/**
 请求广告素材数量，建议不超过3个，
 一次最多不超过10个
 @param count 最多广告返回的广告素材的数量
 */
- (void)loadAdDataWithCount:(NSInteger)count;

@end

@protocol BUNativeAdsManagerDelegate <NSObject>

@optional

- (void)nativeAdsManagerSuccessToLoad:(BUNativeAdsManager *)adsManager nativeAds:(NSArray<BUNativeAd *> *_Nullable)nativeAdDataArray;

- (void)nativeAdsManager:(BUNativeAdsManager *)adsManager didFailWithError:(NSError *_Nullable)error;

@end

NS_ASSUME_NONNULL_END
