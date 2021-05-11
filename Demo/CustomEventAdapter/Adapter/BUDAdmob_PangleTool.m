//
//  BUDAdmob_PangleInfo.m
//  BUDemo
//
//  Created by Eason on 2021/2/2.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "BUDAdmob_PangleTool.h"
#import <BUAdSDK/BUAdSDK.h>

NSString * const pangleExtDataString = @"[{\"name\":\"mediation\",\"value\":\"admob\"},{\"name\":\"adapter_version\",\"value\":\"1.3.0\"}]";

@implementation BUDAdmob_PangleTool
+ (void)setPangleExtData {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /// tag
        [BUAdSDKManager setUserExtData:pangleExtDataString];
    });
}
@end
