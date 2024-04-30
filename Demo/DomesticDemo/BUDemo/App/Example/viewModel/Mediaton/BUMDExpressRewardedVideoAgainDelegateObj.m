//
//  BUMDExpressRewardedVideoAgainDelegateObj.m
//  BUDemo
//
//  Created by heyinyin on 2022/10/26.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import "BUMDExpressRewardedVideoAgainDelegateObj.h"
#import "BUDMacros.h"

@implementation BUMDExpressRewardedVideoAgainDelegateObj
- (void)nativeExpressRewardedVideoAdDidLoad:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%st",__func__);
    BUD_Log(@"mediaExt-%@",rewardedVideoAd.mediaExt);
}

- (void)nativeExpressRewardedVideoAd:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    BUD_Log(@"%s",__func__);
    NSLog(@"error code : %ld , error message : %@",(long)error.code,error.description);
}

- (void)nativeExpressRewardedVideoAdCallback:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd withType:(BUNativeExpressRewardedVideoAdType)nativeExpressVideoType{
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdDidDownLoadVideo:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdViewRenderSuccess:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdViewRenderFail:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd error:(NSError *_Nullable)error {
    BUD_Log(@"%s",__func__);
    NSLog(@"error code : %ld , error message : %@",(long)error.code,error.description);
}

- (void)nativeExpressRewardedVideoAdWillVisible:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdDidVisible:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdWillClose:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdDidClose:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdDidClick:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdDidClickSkip:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdDidPlayFinish:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    BUD_Log(@"%s",__func__);
    NSLog(@"error code : %ld , error message : %@",(long)error.code,error.description);
}

- (void)nativeExpressRewardedVideoAdServerRewardDidSucceed:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdServerRewardDidFail:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd error:(NSError * _Nullable)error {
    BUD_Log(@"%s",__func__);
    NSLog(@"error code : %ld , error message : %@",(long)error.code,error.description);
}

- (void)nativeExpressRewardedVideoAdDidCloseOtherController:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd interactionType:(BUInteractionType)interactionType {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdDidShowFailed:(BUNativeExpressRewardedVideoAd *_Nonnull)rewardedVideoAd error:(NSError *_Nonnull)error {
    BUD_Log(@"%s",__func__);
}

@end

