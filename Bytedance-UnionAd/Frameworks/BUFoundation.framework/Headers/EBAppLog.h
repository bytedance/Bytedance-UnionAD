//
//  EBAppLog.h
//  RangersAppLog
//
//  Created by bob on 2019/7/5.
//

#import <Foundation/Foundation.h>
#import "EBAppLogConfig.h"
#import "EBAppLogDelegateProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/*!
 EBAppLog日志上报功能的类
 */
@interface EBAppLog : NSObject

/*! @abstract settings delegate */
@property (class, nonatomic, copy) id<EBAppLogDelegateProtocol> delegate;

/*! @abstract The SDK version. */
@property (class, nonatomic, copy, readonly) NSString *sdkVersion;

/*! @abstract The unique device ID that get from register server. */
@property (class, nonatomic, copy, readonly, nullable) NSString *deviceID;

/*! @abstract The unique install ID that get from register server.
 @discussion Embed版本值为nil
 */
@property (class, nonatomic, copy, readonly, nullable) NSString *installID;

/*! @abstract The unique ssID that get from register server.
 @discussion Embed版本值为nil
 */
@property (class, nonatomic, copy, readonly, nullable) NSString *ssID;

/*! @abstract 初始化注册
 @param config 初始化配置，AppID AppName Channel是必须的
 @discussion 初始化接口可以重复调用，但是AppID必须相同且只有一个。
 */
+ (void)startTrackWithConfig:(EBAppLogConfig *)config;

/*! @abstract 手动触发获取SDK上报配置值请求
 @discussion 手动触发请求
 */
+ (void)startFetchTrackerConfiguration;

/*! @abstract userAgent
 @discussion 每次启动SDK的时候设置一次，发生变化的时候设置即可。一般不会发生变化，只需要设置一次即可
 @param userAgent 日志上报HTTP/HTTPS 请求里面的 userAgent
 */
+ (void)setUserAgent:(nullable NSString *)userAgent;

/*! @abstract UserUniqueID发生变化时设置
 @discussion 有值，则设置为ID值；登出，可以设置为nil
 @discussion SDK会保存，因此只需要变化的时候设置
 @param uniqueID 用户id
 */
+ (void)setCurrentUserUniqueID:(nullable NSString *)uniqueID;

/*! @abstract 设置上报Host地区，有国内、新加坡、美东三个选项
 @discussion 发生变化可以更新，不需要一直重复设置
 @param serviceVendor 地区
 */
+ (void)setServiceVendor:(EBAppLogServiceVendor)serviceVendor;

/*! @abstract 地区
 @discussion 如果设置过，会保存值，直到下次改变或者清空
 @discussion 如果没有值，默认会读取 `[[NSLocale currentLocale] objectForKey:NSLocaleCountryCode]`
 @discussion 发生变化时候请调用 `+[EBAppLog setAppRegion:]`更新值
 */
+ (void)setAppRegion:(nullable NSString *)appRegion;

/*! @abstract 语言
 @discussion 如果设置过，会保存值，直到下次改变或者清空
 @discussion 如果没有值，默认会读取 `[[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode]`
 @discussion 发生变化时候请调用 `+[EBAppLog setAppLauguage:]`更新值
 */
+ (void)setAppLauguage:(nullable NSString *)appLauguage;

/*! @abstract 设置注册成功回调
 @param registerFinishBlock id发生变化可能重新触发请求，请求回调。
 @discussion registerFinishBlock 会覆盖之前的初始化或者上一次设置的回调，如果为nil会清空回调
 @discussion block在初始化之前设置一次即可，每次拉取成功都会回调，请勿一直重复设置
 */
+ (void)setRegisterFinishBlock:(nullable EBAppLogRegisterFinishBlock)registerFinishBlock;

/*! @abstract 添加自定义上报信息
 @param customHeaderBlock 自定义上报信息
 @discussion customHeaderBlock 一次App启动设置一次即可；App重启需要重新设置，因为SDK不会保存上次设置的值；会覆盖之前的初始化的或者上一次设置的，如果为nil会清空回调
 @discussion block在初始化之前设置一次即可，每次都会回调，不会把block返回参数保存，而导致获取不到变化的值，请勿一直重复设置
 */
+ (void)setCustomHeaderBlock:(nullable EBAppLogCustomHeaderBlock)customHeaderBlock;

/*! @abstract 日志上报
 @param event 事件名称，不能为nil或空字符串
 @param params 事件参数。可以为空或者nil，但是param如果非空，需要可序列化成json
 @discussion params 请参考文档中的日志格式要求
 @result 是否成功，如果失败，则表示此日志不会被上报。原因是无法序列化。
 */
+ (BOOL)eventV3:(NSString *)event params:(nullable NSDictionary *)params;

#pragma mark - private API
/*! @abstract 调用用户激活接口。一般情况下，请勿调用，除非知晓调用可能的问题。预留给内部CP接口使用
 */
+ (void)activeUser;

@end

NS_ASSUME_NONNULL_END
