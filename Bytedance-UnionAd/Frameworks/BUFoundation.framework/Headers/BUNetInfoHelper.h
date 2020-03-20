//
//  BUNetInfoHelper.h
//  BUAdSDK
//
//  Created by 曹清然 on 2017/5/27.
//  Copyright © 2017年 chenren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BUReachability.h"

NS_ASSUME_NONNULL_BEGIN

@interface BUNetInfoHelper : NSObject

+ (nullable NSString *)userAgentString;

/// 网络连接状态的字符串描述
+ (NSString *)GetNetWorkType;

+ (BUNetWorkTypeCode)GetNetWorkTypeCode;

/// 获取carrierName
+ (nullable NSString *)carrierName;

/// 获取mobileCountryCode
+ (nullable NSString *)carrierMCC;

/// 获取mobileNetworkCode
+ (nullable NSString *)carrierMNC;

/// 获取IP地址
+ (nullable NSDictionary *)getIPAddresses;

/**
 *  @param preferIPv4 是否ipv4格式
 *  @return ip地址
 */
+ (NSString *)getIPAddress:(BOOL)preferIPv4;

/// host
+ (nullable NSString*)addressOfHost:(nullable NSString *)host;

/// 获取MAC地址
+ (nullable NSString*)MACAddress;

@end

NS_ASSUME_NONNULL_END
