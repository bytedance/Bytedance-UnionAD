//
//  BUAdSDKDefines.h
//  BUAdSDK
//
//  Created by carl on 2017/7/29.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#ifndef BUAdSDK_DEFINES_h
#define BUAdSDK_DEFINES_h

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BUUserGender) {
    BUUserGenderUnknown,
    BUUserGenderMan,
    BUUserGenderWoman,
};

typedef NS_ENUM(NSInteger, BUAdSDKLogLevel) {
    BUAdSDKLogLevelNone,
    BUAdSDKLogLevelError,
    BUAdSDKLogLevelDebug
};

@protocol BUToDictionary <NSObject>
- (NSDictionary *)dictionaryValue;
@end

#endif
