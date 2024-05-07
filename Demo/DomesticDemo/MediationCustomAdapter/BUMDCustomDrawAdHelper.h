//
//  BUMDCustomDrawAdHelper.h
//  BUMDemo
//
//  Created by ByteDance on 2022/5/6.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BUAdSDK/BUAdSDK.h>

@class BUMDCustomDrawData;

NS_ASSUME_NONNULL_BEGIN

@interface BUMDCustomDrawAdHelper : NSObject<BUMMediatedNativeAdData, BUMMediatedNativeAdViewCreator>

- (instancetype)initWithAdData:(BUMDCustomDrawData *)data;

@end

NS_ASSUME_NONNULL_END
