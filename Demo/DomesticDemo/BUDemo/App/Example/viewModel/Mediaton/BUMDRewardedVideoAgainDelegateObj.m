//
//  BUMDRewardedVideoAgainDelegateObj.m
//  BUDemo
//
//  Created by ByteDance on 2022/10/19.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import "BUMDRewardedVideoAgainDelegateObj.h"
#import "BUDMacros.h"

@implementation BUMDRewardedVideoAgainDelegateObj

- (void)nativeExpressRewardedVideoAdDidLoad:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%st",__func__);
    BUD_Log(@"mediaExt-%@",rewardedVideoAd.mediaExt);
}

- (void)nativeExpressRewardedVideoAd:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    BUD_Log(@"%s",__func__);
    NSLog(@"error code : %ld , error message : %@",(long)error.code,error.description);
}

- (void)nativeExpressRewardedVideoAdDidDownLoadVideo:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdDidShowFailed:(BUNativeExpressRewardedVideoAd *_Nonnull)rewardedVideoAd error:(NSError *_Nonnull)error{
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdDidVisible:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdDidClose:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdDidClick:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd; {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdDidClickSkip:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdDidPlayFinish:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdServerRewardDidSucceed:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify {
    BUD_Log(@"%s",__func__);
    BUD_Log(@"verify-%@",verify?@"true":@"false");
    BUD_Log(@"rewardInfo.userId-%@",rewardedVideoAd.rewardedVideoModel.userId);
    BUD_Log(@"rewardInfo.rewardName-%@",rewardedVideoAd.rewardedVideoModel.rewardName);
    BUD_Log(@"rewardInfo.rewardAmount-%ld",(long)rewardedVideoAd.rewardedVideoModel.rewardAmount);
    BUD_Log(@"rewardInfo.rewardId-%@",rewardedVideoAd.rewardedVideoModel.mediation.rewardId);
    BUD_Log(@"rewardInfo.tradeId-%@",rewardedVideoAd.rewardedVideoModel.mediation.tradeId);
    BUD_Log(@"rewardInfo.adnName-%@",rewardedVideoAd.rewardedVideoModel.mediation.adnName);
    BUD_Log(@"rewardInfo verifyByGroMoreS2S-%@",rewardedVideoAd.rewardedVideoModel.mediation.verifyByGroMoreS2S?@"true":@"false");
}

- (void)nativeExpressRewardedVideoAdServerRewardDidFail:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd error:(NSError *_Nullable)error {
    NSInteger errorCode = error.code;
    NSString *errorMsg = error.userInfo[NSLocalizedDescriptionKey];
    BUD_Log(@"%s error = %@",__func__,error);
}

@end
