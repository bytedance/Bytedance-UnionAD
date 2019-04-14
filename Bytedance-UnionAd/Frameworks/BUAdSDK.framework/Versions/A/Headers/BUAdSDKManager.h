//
//  BUAdSDKManager.h
//  BUAdSDK
//
//  Copyright © 2017 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUAdSDKDefines.h"

@interface BUAdSDKManager : NSObject

@property (nonatomic, copy, readonly, class) NSString *SDKVersion;

/**
 Register the App key that’s already been applied before requesting an ad from TikTok Audience Network.
 @param appID : the unique identifier of the App
 */
+ (void)setAppID:(NSString *)appID;

/**
 Configure development mode.
 @param level : default BUAdSDKLogLevelNone
 */
+ (void)setLoglevel:(BUAdSDKLogLevel)level;

/// Set the gender of the user.
+ (void)setUserGender:(BUUserGender)userGender;

/// Set the age of the user.
+ (void)setUserAge:(NSUInteger)userAge;

/// Set the user's keywords, such as interests and hobbies, etc.
+ (void)setUserKeywords:(NSString *)keywords;

/// set additional user information.
+ (void)setUserExtData:(NSString *)data;

/// Set whether the app is a paid app, the default is a non-paid app
+ (void)setIsPaidApp:(BOOL)isPaidApp;

+ (NSString *)appID;
+ (BOOL)isPaidApp;

@end

