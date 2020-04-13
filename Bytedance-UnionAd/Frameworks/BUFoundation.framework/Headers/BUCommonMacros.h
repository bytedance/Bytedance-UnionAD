//
//  BUCommonMacros.h
//  BUAdSDK
//
//  Created by 崔亚楠 on 2018/10/23.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * const BUSDKVersion;


/** String **/
#define BUEmptyString                                 (@"");
#define BUSafeString(__string)                        ((__string && [__string isKindOfClass:[NSString class]]) ? __string :@"")
#define BUSafeDictionary(__aDictionary)               ((__aDictionary && [__aDictionary isKindOfClass:[NSDictionary class]]) ? __aDictionary :@{})

/** VALID CHECKING**/
#define BUCheckValidString(__string)                (__string && [__string isKindOfClass:[NSString class]] && [__string length])
#define BUCheckValidNumber(__aNumber)               (__aNumber && [__aNumber isKindOfClass:[NSNumber class]])
#define BUCheckValidArray(__aArray)                 (__aArray && [__aArray isKindOfClass:[NSArray class]] && [__aArray count])
#define BUCheckValidDictionary(__aDictionary)       (__aDictionary && [__aDictionary isKindOfClass:[NSDictionary class]] && [__aDictionary count])

/** Color String**/
#define BUColorString(__string)    [UIColor bu_colorWithHexString:(__string)]

/*********************************************************************************************************/
//强弱引用转换，用于解决代码块（block）与强引用对象之间的循环引用问题
#ifndef bu_weakify
#if __has_feature(objc_arc)
#define bu_weakify(object) __weak __typeof__(object) weak##object = object;
#else
#define bu_weakify(object) __block __typeof__(object) block##object = object;
#endif
#endif
#ifndef bu_strongify
#if __has_feature(objc_arc)
#define bu_strongify(object) __typeof__(object) object = weak##object;
#else
#define bu_strongify(object) __typeof__(object) object = block##object;
#endif
#endif
/*********************************************************************************************************/

#ifndef BUisEmptyString
#define BUisEmptyString(str) (!str || ![str isKindOfClass:[NSString class]] || str.length == 0)
#endif

#ifndef BUIsEmptyArray
#define BUIsEmptyArray(array) (!array || ![array isKindOfClass:[NSArray class]] || array.count == 0)
#endif

#ifndef BUIsEmptyDictionary
#define BUIsEmptyDictionary(dict) (!dict || ![dict isKindOfClass:[NSDictionary class]] || ((NSDictionary *)dict).count == 0)
#endif


#ifndef BUMinX
#define BUMinX(view) CGRectGetMinX(view.frame)
#endif

#ifndef BUMinY
#define BUMinY(view) CGRectGetMinY(view.frame)
#endif

#ifndef BUMaxX
#define BUMaxX(view) CGRectGetMaxX(view.frame)
#endif

#ifndef BUMaxY
#define BUMaxY(view) CGRectGetMaxY(view.frame)
#endif

#ifndef BUWidth
#define BUWidth(view) view.frame.size.width
#endif

#ifndef BUHeight
#define BUHeight(view) view.frame.size.height
#endif

#ifndef BUScreenWidth
#define BUScreenWidth [[UIScreen mainScreen] bounds].size.width
#endif

#ifndef BUScreenHeight
#define BUScreenHeight [[UIScreen mainScreen] bounds].size.height
#endif

#ifndef BUMINScreenSide
#define BUMINScreenSide                    MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#endif

#ifndef BUMAXScreenSide
#define BUMAXScreenSide                   MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#endif

#define BUiPhoneX ((BUMAXScreenSide == 812.0) || (BUMAXScreenSide == 896))
#define kBUDefaultNavigationBarHeight  (BUiPhoneX?88:64)      // 导航条高度
#define kBUSafeTopMargin (BUiPhoneX?24:0)
#define kBUDefaultStautsBarHeight  (BUiPhoneX?44:20)      // 状态栏高度

#define BUOnePixel (1.0f/[[UIScreen mainScreen] scale])

///全局队列
#ifndef BUDispatchGetGlobalQueue
#define BUDispatchGetGlobalQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#endif

#ifndef BUDispatchGetHighQueue
#define BUDispatchGetHighQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
#endif

//单例
#define BU_SINGLETION(...)                                          \
+ (instancetype)sharedInstance NS_SWIFT_NAME(shared());

#define BU_DEF_SINGLETION(...)                                      \
+ (instancetype)sharedInstance                                      \
{                                                                   \
static dispatch_once_t once;                                        \
static id __singletion;                                             \
dispatch_once(&once,^{__singletion = [[self alloc] init];});        \
return __singletion;                                                \
}

FOUNDATION_EXPORT void bu_safe_dispatch_sync_main_queue(void (^block)(void));
FOUNDATION_EXPORT void bu_safe_dispatch_async_main_queue(void (^block)(void));

FOUNDATION_EXPORT id BU_JSONObjectByRemovingKeysWithNullValues(id JSONObject);


/** LOG **/
#define BU_Log_Foundation(frmt, ...)   BU_Log_Base(BUFoundationLog, frmt, ##__VA_ARGS__)

#define BU_Log_Base(BULogTypeString, frmt, ...)   BU_LOG_MAYBE(BULogTypeString, BU_LOG_ENABLED, frmt, ##__VA_ARGS__)

#define BU_LOG_MAYBE(BULogTypeString, flg, frmt, ...)                       \
do {                                                      \
if(flg) NSLog(@"【BytedanceUnion V%@】-【%@】%@", BUSDKVersion, BULogTypeString, [NSString stringWithFormat:frmt,##__VA_ARGS__]);                       \
} while(0)

FOUNDATION_EXPORT NSString * const BUFoundationLog;
FOUNDATION_EXPORT BOOL BU_LOG_ENABLED;
