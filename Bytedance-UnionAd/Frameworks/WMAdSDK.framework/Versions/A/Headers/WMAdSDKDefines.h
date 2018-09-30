//
//  WMAdSDKDefines.h
//  WMAdSDK
//
//  Created by carl on 2017/7/29.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#ifndef WMAdSDK_DEFINES_h
#define WMAdSDK_DEFINES_h

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WMUserGender) {
    WMUserGenderUnknown,
    WMUserGenderMan,
    WMUserGenderWoman,
};

typedef NS_ENUM(NSInteger, WMAdSDKLogLevel) {
    WMAdSDKLogLevelNone,
    WMAdSDKLogLevelError,
    WMAdSDKLogLevelDebug
};

#define kWMTouchTrackerAssociatedKey @"kWMTouchTrackerAssociatedKey"

@protocol WMToDictionary <NSObject>
- (NSDictionary *)dictionaryValue;
@end

#endif
