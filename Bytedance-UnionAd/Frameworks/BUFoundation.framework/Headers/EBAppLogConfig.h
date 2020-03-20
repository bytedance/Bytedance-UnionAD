//
//  EBAppLogConfig.h
//  EmbedAppLog
//
//  Created by 陈奕 on 2019/7/14.
//

#import <Foundation/Foundation.h>

/*! @abstract 日志输出
 @param log 输出的日志
 @discussion 请使用自己的日志SDK输出日志
 */
typedef void(^EBAppLogLogger)(NSString * _Nullable log);

/*! @abstract ABTest配置拉取回调
 @param ABTestEnabled ABTest是否开启
 @param allConfigs 后台返回的全部配置
 @discussion ABTestEnabled如果未开启，则，即使有config，SDK也会返回默认值；如果无网络或者其他原因注册失败，不会回调
 */
typedef void(^EBAppLogABTestFinishBlock)(BOOL ABTestEnabled, NSDictionary * _Nullable  allConfigs);

/*! @abstract 设备注册回调
 @param deviceID did
 @param installID iid
 @param ssID ssid
 @discussion 可能为空，如果无网络或者其他原因注册失败，不会回调
 */
typedef void(^EBAppLogRegisterFinishBlock)(NSString * _Nullable deviceID, NSString * _Nullable installID, NSString * _Nullable ssID);

/*! @abstract 自定义上报信息
 @discussion 每次上报都会回调，设置一次即可，格式要求同日志要求，需要可序列化；如果无法序列化，会被丢弃
 */
typedef NSDictionary<NSString*, id> *_Nonnull (^EBAppLogCustomHeaderBlock)(void);

/*! @abstract 日志上报地区属性
 @discussion 上报地区请求擅自选择，需要与申请服务的地区一致，或者咨询接口人确认
 */
typedef NS_ENUM(NSInteger, EBAppLogServiceVendor) {
    EBAppLogServiceVendorCN = 0x020, // 国内 中国
    EBAppLogServiceVendorSG,         // 新加坡
    EBAppLogServiceVendorVA,         // 美东
};

NS_ASSUME_NONNULL_BEGIN

/*!
 EBAppLog日志上报配置
 */
@interface EBAppLogConfig : NSObject

/*! @abstract channel要求非空，必须设置， Release版本只有 @"App Store"， debug版本可以任意设置. */
@property (nonatomic, copy) NSString *channel;

/*! @abstract 申请appID时候填写的英文名称，非空，必须设置 */
@property (nonatomic, copy) NSString *appName;

/*! @abstract AppID，非空，必须设置 */
@property (nonatomic, copy) NSString *appID;

/*! @abstract 默认国内,初始化时一定要传正确的值
 @discussion 发生变化时候请调用 `+[EBAppLog setServiceVendor:]`更新值
 @discussion 会影响注册和日志上报。所以如果发生变化后，下次启动初始化请传入正确的值
 */
@property (nonatomic, assign) EBAppLogServiceVendor serviceVendor;

/*! @abstract 是否自动激活。默认YES，一般情况请不要修改 */
@property (nonatomic, assign) BOOL autoActiveUser;

/*! @abstract 采集事件的时候输出日志，在控制台中可以查看
 @discussion 需要同时设置logger，因为NSLog低效，且在iOS 13中有问题。release版本请设置为NO
 */
@property (nonatomic, assign) BOOL showDebugLog;

/*! @abstract 采集事件的时候输出日志，在控制台中可以查看
 @discussion logger为nil，则不会输出日志
 */
@property (nonatomic, copy, nullable) EBAppLogLogger logger;

/*! @abstract 日志上报是否加密。用于debug情况可以抓包调试 */
@property (nonatomic, assign) BOOL logNeedEncrypt;

/*! @abstract 语言，默认会读取当前系统语言。
 @discussion 如果设置过，会保存值，直到下次改变或者清空
 @discussion 如果没有值，默认会读取当前系统值
 @discussion 发生变化时候请调用 `+[EBAppLog setAppLauguage:]`更新值
 */

/*! @abstract 地区，默认会读取当前系统region。
 @discussion 如果设置过，会保存值，直到下次改变或者清空
 @discussion 如果没有值，默认会读取当前系统值
 @discussion 发生变化时候请调用 `+[EBAppLog setAppRegion:]`更新值
 */

/*! @abstract 用户ID。如果初始化的时候有值，可以初始化的时候设置。无，则不需要设置。
 @discussion 发生变化时候，请调用 `+[EBAppLog setCurrentUserUniqueID:]`更新值
 */

/*! @abstractABTest相关值
 @discussion 发生变化时候，请调用 `+[EBAppLog setServerVersions:]`更新值
 */

/*! @abstract ABTest配置拉取回调
 @discussion 请改用 +[EBAppLog setRegisterFinishBlock:]
 */

/*! @abstract 注册回调.
 @discussion 请改用 +[EBAppLog setRegisterFinishBlock:]
 */

/*! @abstract 自定义上报信息.
 @discussion 请改用 +[EBAppLog setCustomHeaderBlock:]
 */

@end

NS_ASSUME_NONNULL_END
