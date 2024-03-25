//
//  BUMDCustomNativeAdHelper.h
//  BUMDemo
//
//  Created by bytedance on 2021/10/21.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BUAdSDK/BUAdSDK.h>

@class BUMDCustomNativeData;

NS_ASSUME_NONNULL_BEGIN

@interface BUMDCustomNativeAdHelper : NSObject <BUMMediatedNativeAdData, BUMMediatedNativeAdViewCreator>

- (instancetype)initWithAdData:(BUMDCustomNativeData *)data;

@end

NS_ASSUME_NONNULL_END
