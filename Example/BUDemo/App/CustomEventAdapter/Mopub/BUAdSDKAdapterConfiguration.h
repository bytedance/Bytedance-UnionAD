//
//  BUAdSDKAdapterConfiguration.h
//  BUADDemo
//
//  Created by Siwant on 2019/8/9.
//  Copyright © 2019 Bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPBaseAdapterConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@interface BUAdSDKAdapterConfiguration :MPBaseAdapterConfiguration

@property (nonatomic, copy, readonly) NSString * adapterVersion;
@property (nonatomic, copy, readonly) NSString * biddingToken;
@property (nonatomic, copy, readonly) NSString * moPubNetworkName;
@property (nonatomic, copy, readonly) NSString * networkSdkVersion;

+ (void)updateInitializationParameters:(NSDictionary *)parameters;

- (void)initializeNetworkWithConfiguration:(NSDictionary<NSString *, id> * _Nullable)configuration complete:(void(^ _Nullable)(NSError * _Nullable))complete;
@end

NS_ASSUME_NONNULL_END
