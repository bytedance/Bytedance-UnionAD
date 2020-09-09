//
//  BUDMopub_NativeAdRender.h
//  BUDemo
//
//  Created by bytedance on 2020/1/14.
//  Copyright © 2020 bytedance. All rights reserved.
//

#if __has_include(<MoPub/MoPub.h>)
#import <MoPub/MoPub.h>
#elif __has_include(<MoPubSDKFramework/MoPub.h>)
#import <MoPubSDKFramework/MoPub.h>
#else
#import "MPNativeAdRenderer.h"
#import "MPNativeAdRendererSettings.h"
#endif

@class MPNativeAdRendererConfiguration;
@class MPStaticNativeAdRendererSettings;


@interface BUDMopub_NativeAdRender : NSObject <MPNativeAdRenderer>

@property (nonatomic, readonly) MPNativeViewSizeHandler viewSizeHandler;

+ (MPNativeAdRendererConfiguration *)rendererConfigurationWithRendererSettings:(id<MPNativeAdRendererSettings>)rendererSettings;


@end


