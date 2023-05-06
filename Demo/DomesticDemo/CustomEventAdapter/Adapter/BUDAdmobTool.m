//
//  BUDAdmobInfo.m
//  BUDemo
//
//  Created by Eason on 2021/2/2.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "BUDAdmobTool.h"
#import <BUAdSDK/BUAdSDK.h>

NSString * const extDataString = @"[{\"name\":\"mediation\",\"value\":\"admob\"},{\"name\":\"adapter_version\",\"value\":\"1.4.0\"}]";

@implementation BUDAdmobTool
+ (void)setExtData {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /// tag
        [BUAdSDKManager setUserExtData:extDataString];
    });
}
@end
