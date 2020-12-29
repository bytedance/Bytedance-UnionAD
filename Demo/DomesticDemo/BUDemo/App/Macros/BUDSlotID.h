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
#define native_feed_image_ID              @"945019352" //This id 
#define native_draw_ID                    @"900546588"
#define native_banner_ID                  @"900546687"
#define native_interstitial_ID            @"900546829"
#define native_imagePortrait_ID           @"900546264"
#define native_feed_custom_player_ID      @"900546910"
#define native_paster_player_ID           @"945593048"

/// 带_both代表海外国内通用的rit
#define express_feed_ID                   @"945113159"
//#define express_feed_video_ID             @"900546510"
#define express_feed_video_ID             @"945294189"
#define express_draw_ID                   @"900546881"
#define express_banner_ID                 @"900546269"
#define express_banner_ID_60090           @"900546269"
#define express_banner_ID_640100          @"900546833"
#define express_banner_ID_600150          @"900546198"
#define express_banner_ID_690388          @"945509774" ///3400 change
#define express_banner_ID_600260          @"900546387"
#define express_banner_ID_600300          @"945509789" ///3400 change
#define express_banner_ID_600400_both     @"945509785" ///3400 change
#define express_banner_ID_600500_both     @"945509778" ///3400 change
#define express_interstitial_ID           @"900546270"
#define express_interstitial_ID_1_1_both  @"945509762" ///3400 change
#define express_interstitial_ID_2_3_both  @"945509769" ///3400 change
#define express_interstitial_ID_3_2_both  @"945509825" ///3400 change
#define express_splash_ID                 @"800546851"
#define express_full_ID_both              @"945113164"
#define express_full_landscape_ID_both    @"945113165"
#define express_reward_ID_both            @"945113162"
#define express_reward_landscape_ID_both  @"945113163"


// custom Event
#define mopub_AD_APPID                     @"e1cbce0838a142ec9bc2ee48123fd470"
#define mopub_reward_UnitID                @"e1cbce0838a142ec9bc2ee48123fd470"
#define mopub_fullscreen_UnitID            @"7e214581af8a4883a0bcf1e626c76c70"
#define mopub_intersttitial_UnitID         @"958434f2c3cc4f54b8cd73684b44baf8"
#define mopub_banner_UnitID                @"ca9c91eb59694afa9caef204ac622136"
#define mopub_expressReward_UnitID         @"e0e003e94cfd4442a01265262a2dd5bf"
#define mopub_expressFullscreen_UnitID     @"58f7244f244148918088f09838d243d3"
#define mopub_expressIntersttitial_UnitID  @"438548d72c0c4d2ea9c801a4b193c962"
#define mopub_expressBanner_UnitID         @"d4bfb78262b349f8bb8302a508d94284"
#define mopub_nativeAd_UnitID              @"8a864df99f144136b942bc6656692e58"  // This is adUnitId we register in mopub for loading Bytedance Union Ad
#define mopub_nativeAd_UnitID_test         @"76a3fefaced247959582d2d2df6f4757"  // This is mopub offical test adUnitId for native Ad
#define mopub_nativeVideoAd_UnitID_test    @"b2b67c2a8c0944eda272ed8e4ddf7ed4"  // This is mopub offical test adUnitId for native video Ad
#define mopub_official_intersttitial_UnitID  @"20c57bb4c1974a60bfbbb4ad724a33b4"
#define mopub_official_native_UnitID         @"36b1cc9fc81e4ee696a301159be2bcd3"
#define mopub_official_banner_UnitID         @"edc1f2d5f0554c7389bfdb272c798adb"
#define mopub_official_reward_UnitID         @"07fbb1924348482b8b3fc02ec115faf5"

#if googleUnit //使用google官方默认的unitId(use admob's default unitID)
//#define admob_reward_UnitID               @"ca-app-pub-3940256099942544/1712485313"
//#define admob_expressReward_UnitID        @"ca-app-pub-3940256099942544/1712485313"
//#define admob_expressFullscreen_UnitID    @"ca-app-pub-3940256099942544/4411468910"
//#define admob_expressBanner_UnitID        @"ca-app-pub-3940256099942544/2934735716"
//#define admob_expressInterstitial_UnitID  @"ca-app-pub-3940256099942544/4411468910"
//#define admob_native_UnitID               @"ca-app-pub-3940256099942544/3986624511"
//#define admob_normalFullscreen_UnitID     @"ca-app-pub-3940256099942544/4411468910"

#else
//#define admob_reward_UnitID               @"ca-app-pub-2547387438729744/9313502870"
//#define admob_native_UnitID               @"ca-app-pub-2547387438729744/4062704877"
//#define admob_normalFullscreen_UnitID     @"ca-app-pub-2547387438729744/6878911221"
//#define admob_expressReward_UnitID        @"ca-app-pub-9206388280072239/3833766591"
//#define admob_expressFullscreen_UnitID    @"ca-app-pub-9206388280072239/7953469846"
//#define admob_Banner_UnitID_640_100       @"ca-app-pub-2547387438729744/3823584037"
//#define admob_Banner_UnitID_600_500       @"ca-app-pub-2547387438729744/3823584037"
//#define admob_expressInterstitial_UnitID  @"ca-app-pub-9206388280072239/8309048289"
#endif

#endif /* BUDSlotID_h */

/*
 admob广告位与adapter对应表：
 广告类型                        adaper类                                        展示的VC
 NormalRewardVideo :           BUDAdmob_RewardCustomEventAdapter             BUDAdmob_RewardVideoCusEventVC
 NormalFullscreenVideo         BUDAdmob_NormalFullScreenCustomEventAdapter       BUDAdmob_FullScreenCusEventVC
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
