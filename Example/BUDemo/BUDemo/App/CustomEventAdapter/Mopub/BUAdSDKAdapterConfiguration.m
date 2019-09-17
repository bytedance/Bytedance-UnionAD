//
//  BUAdSDKAdapterConfiguration.m
//  BUADDemo
//
//  Created by Siwant on 2019/8/9.
//  Copyright © 2019 Bytedance. All rights reserved.
//

#import "BUAdSDKAdapterConfiguration.h"
#import <BUAdSDK/BUAdSDKManager.h>
#import "BUDAdManager.h"

@implementation BUAdSDKAdapterConfiguration
- (NSString *)adapterVersion {
    return [BUAdSDKManager SDKVersion]?:@"";
}

- (NSString *)biddingToken {
    return nil;
}

- (NSString *)moPubNetworkName {
    return @"BUAdSDK";
}

- (NSString *)networkSdkVersion {
    return [BUAdSDKManager SDKVersion]?:@"";
}

- (void)initializeNetworkWithConfiguration:(NSDictionary<NSString *, id> *)configuration complete:(void(^)(NSError *))complete {
    NSString *appkeyString = configuration[@"appKey"];
    if (appkeyString == nil || [appkeyString isKindOfClass:[NSString class]] == NO) {
        NSError *theError = [NSError errorWithDomain:@"com.bytedance.AdapterConfiguration" code:1 userInfo:@{NSLocalizedDescriptionKey:@"appKey may be not right, please set networkConfig refer to method '-configCustomEvent' in 'AppDelegate' class"}];
        if (complete != nil) {
            complete(theError);
        }
    } else {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [BUAdSDKManager setAppID:[BUDAdManager appKey]];
                [BUAdSDKManager setIsPaidApp:NO];
                [BUAdSDKManager setLoglevel:BUAdSDKLogLevelDebug];
                if (complete != nil) {
                    complete(nil);
                }
            });
        });
    }
}

#pragma mark - Class method
+ (void)updateInitializationParameters:(NSDictionary *)parameters
{
    if (parameters != nil) {
        [BUAdSDKAdapterConfiguration setCachedInitializationParameters:parameters];
    }
}
@end
