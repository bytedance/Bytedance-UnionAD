//
//  BUDeviceHelper.h
//  BUSDKProject
//
//  Created by ranny_90 on 2017/5/20.
//  Copyright © 2017年 ranny_90. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUDeviceHelper : NSObject

/// 判断设备是否越狱
+ (BOOL)isJailBroken;

/// 获取idfa
+ (nullable NSString *)idfaString;

/// 获取idfv
+ (nullable NSString *)idfvString;

/// 获取uuid
+ (NSString *)uuid;

/// 获取系统版本号
+ (float)OSVersionNumber;

 /// 获取当前语言种类
+ (nullable NSString *)currentLanguage;

@end


@interface BUDeviceHelper (Hardware)

/// 返回设备平台信息
+ (NSString *)platform;

/// 返回设备type：iphone／ipad／ipod／apple tv等
+ (NSString *)platformTypeString;

/// 具体到型号，如iPhone1,1
+ (NSString *)platformString;

/// 返回硬盘空闲空间
+ (NSNumber *)freeDiskSpace;

/// 设备的总内存 单位MB
+ (NSInteger)totolDeviceMemory;

/// APP已使用的内存 单位MB
+ (NSInteger)usedAPPMemory;

// 是否是低端机型
// 1. 非iPhone机型不是低端机型
// 2. iPhone5s及以下是低端机型
+ (BOOL)lowEndMode;
@end


@interface BUDeviceHelper (ProcessesAdditions)

/// 获取当前设备的进程，仅适用于（iOS9以下）
+ (NSArray *)runningProcesses;

@end

NS_ASSUME_NONNULL_END
