//
//  BUInfoHelper.h
//  BUSDKProject
//
//  Created by ranny_90 on 2017/5/20.
//  Copyright © 2017年 ranny_90. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUDefaultImageInfo : NSObject

@property (nonatomic, assign) NSInteger w;
@property (nonatomic, assign) NSInteger h;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, copy) NSString *colorSpace;
@property (nonatomic, copy) NSString *textureFormat;
@property (nonatomic, copy) NSString *filterName;
@property (nonatomic, copy) NSString *extDesc;
@property (nonatomic, copy) NSString *extType;

@end

@interface BUInfoHelper : NSObject

/**
 *  获取info.plist中的CFBundleDisplayName
 *
 *  @return 如果没有，返回CFBundleName
 */
+ (nullable NSString *)appDisplayName;

/**
 *  获取info.plist发布版本号
 *
 *  @return 可能为nil
 */
+ (nullable NSString *)versionName;

/**
 *  @return 获取plist中的CFBundleIdentifier
 */
+ (nullable NSString *)bundleIdentifier;

/**
 *  @return 获取aid
 */
+ (nullable NSString *)ssAppID;

/// 获取默认图片信息
+ (BUDefaultImageInfo *)defaultImageInfo;

@end

NS_ASSUME_NONNULL_END
