//
//  NSString+LocalizedString.h
//  BUDemo
//
//  Created by 李盛 on 2019/1/14.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const Testads;
extern NSString * const AdsTitle;
extern NSString * const Width;
extern NSString * const Height;
extern NSString * const StartLocation;
extern NSString * const PermissionDenied;
extern NSString * const Coordinate;
extern NSString * const LocationFailure;
extern NSString * const Unknown;
extern NSString * const DrawTitle;
extern NSString * const DrawDescription;
extern NSString * const TestDescription;
extern NSString * const Download;
extern NSString * const LoadCollectionView;
extern NSString * const LoadView;
extern NSString * const CustomBtn;
extern NSString * const NativeInterstitial;
extern NSString * const ShowBanner;
extern NSString * const ShowInterstitial;
extern NSString * const ShowScrollBanner;
extern NSString * const Splash;
extern NSString * const SplashContainer;
extern NSString * const CustomCloseBtn;
extern NSString * const Skip;
extern NSString * const ShowFullScreenVideo;
extern NSString * const ShowRewardVideo;
extern NSString * const LocationOn;
extern NSString * const GetIDFA;
extern NSString * const ClickDownload;
extern NSString * const Call;
extern NSString * const ExternalLink;
extern NSString * const InternalLink;
extern NSString * const NoClick;
extern NSString * const CustomClick;
extern NSString * const Detail;
extern NSString * const DownloadLinks;
extern NSString * const URLLinks;
extern NSString * const IsLandScape;
extern NSString * const IsCarousel;
extern NSString * const Vertical;
extern NSString * const Horizontal;
extern NSString * const TapButton;
extern NSString * const AdLoading;
extern NSString * const AdLoaded;
extern NSString * const AdloadedFail;
extern NSString * const LoadedAd;
extern NSString * const ShowAd;
extern NSString * const ScanQRCode;
extern NSString * const IsEtOpen;
extern NSString * const kFeedAd ;
extern NSString * const kFeedAdNative ;
extern NSString * const kFeedAdExpress ;
extern NSString * const kFeedAdExpressVideo ;
extern NSString * const kFeedAdExpressIcon ;
extern NSString * const kDrawAd ;
extern NSString * const kDrawAdNative ;
extern NSString * const kDrawAdExpress ;
extern NSString * const kFullscreenAd ;
extern NSString * const kFullscreenAdNative ;
extern NSString * const kFullscreenAdExpress ;
extern NSString * const kFullscreenAdInterstital  ;
extern NSString * const kSplashAd ;
extern NSString * const kSplashAdNative ;
extern NSString * const kSplashAdExpress ;
extern NSString * const kBannerAd ;
extern NSString * const kBannerAdNative ;
extern NSString * const kBannerAdExpress ;
extern NSString * const kBannerAdExpressList ;
extern NSString * const kRewardedAd ;
extern NSString * const kRewardedAdNative ;
extern NSString * const kRewardedAdExpress ;
extern NSString * const kStreamAd ;
extern NSString * const kStreamAdNative ;
extern NSString * const kStreamAdCustom ;
extern NSString * const kStreamAdSDK ;
extern NSString * const kWaterfallAd;
extern NSString * const kNewInterstitialfull;
extern NSString * const kNewInterstitialhalf;
extern NSString * const kUgenoLUPage;
extern NSString * const kUgenoLUPage2;
extern NSString * const kUgenoLUPage3;
extern NSString * const kUgenoStreet1;
extern NSString * const kUgenoStreet2;
extern NSString * const kUgenoStreet3;
extern NSString * const kECMallView;
extern NSString * const kMSplashAd;
extern NSString * const kMBannerAd;
extern NSString * const kMRewardVideoAd;
extern NSString * const kMFeedAd;
extern NSString * const kMDrawAd;
extern NSString * const kGMInterstitialProAd;

@interface NSString (LocalizedString)

+ (NSString *)localizedStringForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
