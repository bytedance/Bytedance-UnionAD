//
//  BUAdSDKManager.h
//  BUAdSDK
//
//  Created by chenren on 17/05/2017.
//  Copyright © 2017 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUAdSDKDefines.h"

@interface BUAdSDKManager : NSObject

@property (nonatomic, copy, readonly, class) NSString *SDKVersion;

/**
  在请求广告联盟请求广告前，注册已经申请的App key
 @param appID 标识App的唯一标识
 */
+ (void)setAppID:(NSString *)appID;

/**
 配置开发模式
 @param level 默认 BUAdSDKLogLevelNone
 */
+ (void)setLoglevel:(BUAdSDKLogLevel)level;

/// 设置用户的性别
+ (void)setUserGender:(BUUserGender)userGender;

/// 设置用户的年龄
+ (void)setUserAge:(NSUInteger)userAge;

/// 设置用户的关键字，比如兴趣和爱好等等
+ (void)setUserKeywords:(NSString *)keywords;

/// 设置用户的额外信息
+ (void)setUserExtData:(NSString *)data;

/// 设置本app是否是付费app，默认为非付费app
+ (void)setIsPaidApp:(BOOL)isPaidApp;

+ (NSString *)appID;
+ (BOOL)isPaidApp;

@end

