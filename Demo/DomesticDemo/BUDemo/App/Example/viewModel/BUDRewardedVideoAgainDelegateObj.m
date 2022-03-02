//
//  BUDRewardedVideoAgainDelegateObj.m
//  BUDemo
//
//  Created by wangyanlin on 2021/6/8.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "BUDRewardedVideoAgainDelegateObj.h"
#import "BUDMacros.h"

@implementation BUDRewardedVideoAgainDelegateObj
#pragma mark - BURewardedVideoAdDelegate
- (void)rewardedVideoAdDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"BUDRewardedVideoAgainDelegateObj %st",__func__);
    BUD_Log(@"mediaExt-%@",rewardedVideoAd.mediaExt);
}

- (void)rewardedVideoAdVideoDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"BUDRewardedVideoAgainDelegateObj %s",__func__);
}

- (void)rewardedVideoAd:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    BUD_Log(@"BUDRewardedVideoAgainDelegateObj %s",__func__);
    NSLog(@"error code : %ld , error message : %@",(long)error.code,error.description);
}

- (void)rewardedVideoAdWillVisible:(BURewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"BUDRewardedVideoAgainDelegateObj %s",__func__);
}

- (void)rewardedVideoAdDidVisible:(BURewardedVideoAd *)rewardedVideoAd{
    BUD_Log(@"BUDRewardedVideoAgainDelegateObj %s",__func__);
}

- (void)rewardedVideoAdWillClose:(BURewardedVideoAd *)rewardedVideoAd{
    BUD_Log(@"BUDRewardedVideoAgainDelegateObj %s",__func__);
}

- (void)rewardedVideoAdDidClose:(BURewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"BUDRewardedVideoAgainDelegateObj %s",__func__);
}

- (void)rewardedVideoAdDidClick:(BURewardedVideoAd *)rewardedVideoAd {
    BUD_Log(@"BUDRewardedVideoAgainDelegateObj %s",__func__);
}

- (void)rewardedVideoAdDidPlayFinish:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    BUD_Log(@"BUDRewardedVideoAgainDelegateObj %s",__func__);
}

- (void)rewardedVideoAdServerRewardDidFail:(BURewardedVideoAd *)rewardedVideoAd error:(nonnull NSError *)error {
    BUD_Log(@"BUDRewardedVideoAgainDelegateObj %s error = %@",__func__,error);
}

- (void)rewardedVideoAdDidClickSkip:(BURewardedVideoAd *)rewardedVideoAd{
    BUD_Log(@"BUDRewardedVideoAgainDelegateObj %s",__func__);

}

- (void)rewardedVideoAdServerRewardDidSucceed:(BURewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify{
    BUD_Log(@"BUDRewardedVideoAgainDelegateObj %s",__func__);
    BUD_Log(@"%@",[NSString stringWithFormat:@"verify:%@ rewardName:%@ rewardMount:%ld",verify?@"true":@"false",rewardedVideoAd.rewardedVideoModel.rewardName,(long)rewardedVideoAd.rewardedVideoModel.rewardAmount]);
}
- (void)rewardedVideoAdCallback:(BURewardedVideoAd *)rewardedVideoAd withType:(BURewardedVideoAdType)rewardedVideoAdType{
    BUD_Log(@"BUDRewardedVideoAgainDelegateObj %s",__func__);
}

@end
