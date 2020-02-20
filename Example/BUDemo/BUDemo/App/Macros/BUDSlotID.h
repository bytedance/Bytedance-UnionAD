//
//  BUDSlotID.h
//  BUDemo
//
//  Created by Bytedance on 2019/11/27.
//  Copyright © 2019 bytedance. All rights reserved.
//

#ifndef BUDSlotID_h
#define BUDSlotID_h

// SDK
#define normal_banner_ID                  @"900546859"
#define normal_interstitial_ID            @"900546957"
#define normal_reward_ID                  @"900546826"
#define normal_reward_landscape_ID        @"900546319"
#define normal_fullscreen_ID              @"900546299"
#define normal_fullscreen_landscape_ID    @"900546154"
#define normal_splash_ID                  @"800546808"

#define native_feed_ID                    @"900546910"
#define native_draw_ID                    @"900546588"
#define native_banner_ID                  @"900546687"
#define native_interstitial_ID            @"900546829"
#define native_imagePortrait_ID           @"900546264"

#define express_feed_ID                   @"900546131"
#define express_feed_video_ID             @"900546510"
#define express_draw_ID                   @"900546881"
#define express_banner_ID                 @"900546269"
#define express_banner_ID_60090           @"900546269"
#define express_banner_ID_640100          @"900546833"
#define express_banner_ID_600150          @"900546198"
#define express_banner_ID_690388          @"900546673"
#define express_banner_ID_600260          @"900546387"
#define express_banner_ID_600300          @"900546526"
#define express_banner_ID_600400          @"900546672"
#define express_banner_ID_600500          @"900546768"
#define express_interstitial_ID           @"900546270"
#define express_interstitial_ID_1_1       @"900546747"
#define express_interstitial_ID_2_3       @"900546270"
#define express_interstitial_ID_3_2       @"900546676"
#define express_splash_ID                 @"800546851"
#define express_fullscreen_ID             @"900546551"
#define express_fullscreen_landscape_ID   @"900546831"
#define express_reward_ID                 @"900546566"
#define express_reward_landscape_ID       @"900546606"


// custom Event
#define mopub_AD_APPID                     @"e1cbce0838a142ec9bc2ee48123fd470"
#define mopub_reward_UnitID                @"e1cbce0838a142ec9bc2ee48123fd470"
#define mopub_fullscreen_UnitID            @"d3ecccb5151f4c5aaa93d125004c5d5f"
#define mopub_intersttitial_UnitID         @"958434f2c3cc4f54b8cd73684b44baf8"
#define mopub_banner_UnitID                @"ca9c91eb59694afa9caef204ac622136"
#define mopub_expressReward_UnitID         @"e0e003e94cfd4442a01265262a2dd5bf"
#define mopub_expressFullscreen_UnitID     @"58f7244f244148918088f09838d243d3"
#define mopub_expressIntersttitial_UnitID  @"438548d72c0c4d2ea9c801a4b193c962"
#define mopub_expressBanner_UnitID         @"d4bfb78262b349f8bb8302a508d94284"

#if googleUnit //使用google官方默认的unitId(use admob's default unitID)
#define admob_reward_UnitID               @"ca-app-pub-3940256099942544/1712485313"
#define admob_expressReward_UnitID        @"ca-app-pub-3940256099942544/1712485313"
#define admob_expressFullscreen_UnitID    @"ca-app-pub-3940256099942544/4411468910"
#define admob_expressBanner_UnitID        @"ca-app-pub-3940256099942544/2934735716"
#define admob_expressInterstitial_UnitID  @"ca-app-pub-3940256099942544/4411468910"
#else
#define admob_reward_UnitID               @"ca-app-pub-9206388280072239/3592550520"
#define admob_expressReward_UnitID        @"ca-app-pub-9206388280072239/3833766591"
#define admob_expressFullscreen_UnitID    @"ca-app-pub-9206388280072239/7953469846"
#define admob_expressBanner_UnitID        @"ca-app-pub-9206388280072239/8476569246"
#define admob_expressInterstitial_UnitID  @"ca-app-pub-9206388280072239/8309048289"
#endif

#endif /* BUDSlotID_h */

/*
 admob广告位与adapter对应表：
 广告类型                        adaper类                                        展示的VC
 NormalRewardVideo :           BUDAdmob_RewardCustomEventAdapter             BUDAdmob_RewardVideoCusEventVC
 ExpressRewardVideo:           BUDAdmob_RewardExpressCustomEventAdapter      BUDAdmob_RewardExpressCusEventVC
 ExpressFullscreenVideo:       BUDAdmob_FullScreenCustomEventAdapter         BUDAdmob_FullScreenExpressCusEventVC
 ExpressBanner:                BUDAdmob_BannerCustomEventAdapter             BUDAdmob_BannerExpressCusEventVC
 ExpressInterstitial:          BUDAdmob_InterstitialCustomEventAdapter       BUDAdmob_InterstitialExpressCusEventVC
 
 mopub广告位与adapter对应表：
 广告类型                        adaper类                                        展示的VC
 NormalRewardVideo:            BUDMopub_RewardedVideoCustomEvent             BUDMopub_RewardVideoCusEventVC
 NormalFullscreenVideo:        BUDMopub_FullscreenVideoCustomEvent           BUDMopub_FullScreenVideoCusEventVC
 NormalBanner:                 BUDMopub_BannerCustomEvent                    BUDMopub_BannerCusEventVC
 NormalInterstitial:           BUDMopub_InterstitialCustomEvent              BUDMopub_InterstitialCusEventVC
 ExpressRewardVideo:           BUDMopub_ExpressRewardedVideoCustomEvent      BUDMopub_ExpressRewardVideoCusEventVC
 ExpressFullscreenVideo:       BUDMopub_ExpressFullscreenVideoCustomEvent    BUDMopub_ExpressFullScreenVideoCusEventVC
 ExpressBanner:                BUDMopub_ExpressBannerCustomEvent             BUDMopub_ExpressBannerCusEventVC
 ExpressInterstitial:          BUDMopub_ExpressInterstitialCustomEvent       BUDMopub_ExpressInterstitialCusEventVC
 **/
