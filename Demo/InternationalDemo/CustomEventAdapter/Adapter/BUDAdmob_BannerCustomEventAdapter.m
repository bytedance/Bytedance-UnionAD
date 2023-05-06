//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#import "BUDAdmob_BannerCustomEventAdapter.h"
#import <GoogleMobileAds/GADCustomEventBanner.h>
#import "BUDAdmobTool.h"
#import <PAGAdSDK/PAGBannerAd.h>
#import <PAGAdSDK/PAGBannerAdDelegate.h>

@interface BUDAdmob_BannerCustomEventAdapter ()<GADMediationBannerAd, PAGBannerAdDelegate>

//@property (strong, nonatomic) BUNativeExpressBannerView *nativeExpressBannerView;

@property (nonatomic, strong) PAGBannerAd *bannerAd;
@property (nonatomic, strong) UIView *bannerView;
@property (nonatomic, weak, nullable) id<GADMediationBannerAdEventDelegate> delegate;

@end

@implementation BUDAdmob_BannerCustomEventAdapter

NSString *const BANNER_PLACEMENT_ID = @"placementID";

- (void)loadBannerForAdConfiguration:(GADMediationBannerAdConfiguration *)adConfiguration completionHandler:(GADMediationBannerLoadCompletionHandler)completionHandler {
    NSDictionary<NSString *, id> *credentials = adConfiguration.credentials.settings;
    NSString *placementID = credentials[@"parameter"];
    if (placementID != nil){
        GADAdSize adSize = adConfiguration.adSize;
        NSLog(@"placementID=%@",placementID);
        NSLog(@"request ad size width = %f",adSize.size.width);
        NSLog(@"request ad size height = %f",adSize.size.height);
        
        /// tag
        [BUDAdmobTool setExtData];
    
        CGFloat bottom = 0.0;
        PAGBannerAdSize size = (PAGBannerAdSize){(CGSize){adSize.size.width, adSize.size.height}};
        
        __weak typeof(self) weakSelf = self;
        [PAGBannerAd loadAdWithSlotID:placementID request:[PAGBannerRequest requestWithBannerSize:size] completionHandler:^(PAGBannerAd * _Nullable bannerAd, NSError * _Nullable error) {
            if (error) {
                NSLog(@"banner ad load fail : %@",error);
                return;
            }
            weakSelf.bannerAd = bannerAd;
            weakSelf.bannerAd.delegate = weakSelf;
            weakSelf.bannerView = weakSelf.bannerAd.bannerView;
            weakSelf.bannerView.frame = CGRectMake((weakSelf.view.frame.size.width-size.size.width)/2.0, weakSelf.view.frame.size.height-size.size.height-bottom, size.size.width, size.size.height);
            
            weakSelf.delegate = completionHandler(weakSelf, nil);
        }];
        
    } else {
        NSLog(@"no placement ID for requesting.");
        [self.delegate didFailToPresentWithError:[NSError errorWithDomain:@"error placementID" code:-1 userInfo:nil]];
        [self _logWithSEL:_cmd msg:@"called didFailToPresentWithError:code:userInfo:"];
    }
}

- (UIView *)view {
    return self.bannerAd.bannerView;
}

# pragma mark - PAGBannerAdDelegate

- (void)adDidShow:(id<PAGAdProtocol>)ad {
    [self.delegate willPresentFullScreenView];
    [self.delegate reportImpression];
    [self _logWithSEL:_cmd msg:@"called willPresentFullScreenView: and reportImpression:"];
}

- (void)adDidClick:(id<PAGAdProtocol>)ad {
    [self.delegate reportClick];
    [self _logWithSEL:_cmd msg:@"called reportClick:"];
}

- (void)adDidDismiss:(id<PAGAdProtocol>)ad {
    [self.delegate willDismissFullScreenView];
    [self.delegate didDismissFullScreenView];
    [self _logWithSEL:_cmd msg:@"called willDismissFullScreenView: and didDismissFullScreenView:"];
}

#pragma mark - private method
- (void)_logWithSEL:(SEL)sel msg:(NSString *)msg {
    NSLog(@"BUDAdmob_BannerCustomEventAdapter | %@ | %@", NSStringFromSelector(sel), msg);
}

@end
