//
//  WMNativeAdsManager.h
//  WMAdSDK
//
//  Created by chenren on 24/05/2017.
//  Copyright © 2017 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WMAdSlot.h"
#import "WMMaterialMeta.h"
#import "WMNativeAd.h"

@protocol WMNativeAdsManagerDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface WMNativeAdsManager : NSObject

@property (nonatomic, strong, nullable) WMAdSlot *adslot;
@property (nonatomic, strong, nullable) NSArray<WMMaterialMeta *> *data;
/// 广告位加载展示响应的代理回调，可以设置为遵循<WMNativeAdDelegate>的任何类型，不限于Viewcontroller
@property (nonatomic, weak, nullable) id<WMNativeAdsManagerDelegate> delegate;

- (instancetype)initWithSlot:(WMAdSlot * _Nullable) slot;

- (void)registerTableView:(UITableView *)tableView;

/**
 请求广告素材数量,最多三个
 */
- (void)loadAdData;

/**
 请求广告素材数量， 建议不超过 3个左右
 最多不超过10个一次
 @param count 最多广告返回的广告素材的数量
 */
- (void)loadAdDataWithCount:(NSInteger)count;

@end

@protocol WMNativeAdsManagerDelegate <NSObject>

@optional

- (void)nativeAdsManagerSuccessToLoad:(WMNativeAdsManager *)adsManager materialMeta:(NSArray<WMMaterialMeta *> *_Nullable)nativeAdDataArray;

- (void)nativeAdsManager:(WMNativeAdsManager *)adsManager didFailWithError:(NSError *_Nullable)error;

@end

NS_ASSUME_NONNULL_END
