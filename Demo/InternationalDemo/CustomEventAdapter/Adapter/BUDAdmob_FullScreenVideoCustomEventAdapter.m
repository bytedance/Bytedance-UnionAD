//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#import "BUDAdmob_FullScreenVideoCustomEventAdapter.h"
#import "BUDAdmobTool.h"
#import <PAGAdSDK/PAGLInterstitialAd.h>
#import <PAGAdSDK/PAGLInterstitialAdDelegate.h>

@interface BUDAdmob_FullScreenVideoCustomEventAdapter() <GADMediationInterstitialAd, PAGLInterstitialAdDelegate>
@property (nonatomic, strong) PAGLInterstitialAd *fullScreenVideo;
@property (nonatomic, weak, nullable) id<GADMediationInterstitialAdEventDelegate> delegate;
@end

@implementation BUDAdmob_FullScreenVideoCustomEventAdapter

NSString *const INTERSTITIAL_PLACEMENT_ID = @"placementID";

- (void)loadInterstitialForAdConfiguration:(GADMediationInterstitialAdConfiguration *)adConfiguration completionHandler:(GADMediationInterstitialLoadCompletionHandler)completionHandler {
    // Look for the "parameter" key to fetch the parameter you defined in the AdMob UI.
    NSDictionary<NSString *, id> *credentials = adConfiguration.credentials.settings;
    NSString *placementID = credentials[@"parameter"];
    NSLog(@"placementID=%@",placementID);
    if (placementID != nil){
        /// tag
        [BUDAdmobTool setExtData];
        __weak typeof(self) weakSelf = self;
        [PAGLInterstitialAd loadAdWithSlotID:placementID request:[PAGInterstitialRequest request] completionHandler:^(PAGLInterstitialAd * _Nullable interstitialAd, NSError * _Nullable error) {
            weakSelf.fullScreenVideo = interstitialAd;
            weakSelf.fullScreenVideo.delegate = weakSelf;
            weakSelf.delegate = completionHandler(weakSelf, nil);
        }];
    } else {
        NSLog(@"no placement ID for requesting.");
        [self.delegate didFailToPresentWithError:[NSError errorWithDomain:@"error placementID" code:-1 userInfo:nil]];
        [self _logWithSEL:_cmd msg:@"called didFailToPresentWithError:code:userInfo:"];
    }
}

#pragma mark - GADMediationInterstitialAd
- (void)presentFromViewController:(nonnull UIViewController *)viewController{
    if (self.fullScreenVideo) {
        [self.fullScreenVideo presentFromRootViewController:viewController];
    }
    else {
        NSError *error =
              [NSError errorWithDomain:@"GADMediationAdapterSampleAdNetwork"
                                  code:0
                              userInfo:@{NSLocalizedDescriptionKey : @"Unable to display ad."}];
        [self.delegate didFailToPresentWithError:error];
    }
}

#pragma mark - PAGLInterstitialAdDelegate

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

#pragma mark - private

- (void)_logWithSEL:(SEL)sel msg:(NSString *)msg {
    NSLog(@"BUDAdmob_FullScreenVideoCustomEventAdapter | %@ | %@", NSStringFromSelector(sel), msg);
}


@end
