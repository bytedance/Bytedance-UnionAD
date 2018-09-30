//
//  WMAdSDKManager.h
//  WMAdSDK
//
//  Created by chenren on 17/05/2017.
//  Copyright © 2017 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WMAdSDKDefines.h"

@interface WMAdSDKManager : NSObject

@property (nonatomic, copy, readonly, class) NSString *SDKVersion;

/**
  在请求广告联盟请求广告前，注册已经申请的App key
 @param appID 标识App的唯一标识
 */
+ (void)setAppID:(NSString *)appID;

/**
 配置开发模式
 @param level 默认 WMAdSDKLogLevelNone
 */
+ (void)setLoglevel:(WMAdSDKLogLevel)level;
+ (void)setUserGender:(WMUserGender)userGender;
+ (void)setUserAge:(NSInteger)userAge;
+ (void)setUserKeywords:(NSString *)keywords;
+ (void)setUserExtData:(NSString *)data;
+ (void)setIsPaidApp:(BOOL)isPaidApp;

+ (NSString *)appID;
+ (BOOL)isPaidApp;

@end

