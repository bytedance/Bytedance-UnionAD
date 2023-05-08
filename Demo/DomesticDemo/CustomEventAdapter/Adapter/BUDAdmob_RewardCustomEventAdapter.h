//
//  BUDAdmob_RewardCustomEventAdapter.h
//  AdmobAdapterDemo
//
//  Created by Gu Chan on 2020/07/03.
//  Copyright © 2020 GuChan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

//rewardedvideo ad adapter
@interface BUDAdmob_RewardCustomEventAdapter : NSObject<GADMediationAdapter>

- (NSString *)processParams:(NSString *)param;

@end
