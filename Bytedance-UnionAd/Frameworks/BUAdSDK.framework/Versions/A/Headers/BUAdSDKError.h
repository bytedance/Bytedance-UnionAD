//
//  BUAdSDKError.h
//  BUAdSDK
//
//  Created by carl on 2017/7/29.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSErrorDomain BUErrorDomain ;

typedef NS_ENUM(NSInteger, BUErrorCode) {
    
    BUErrorCodeOpenAPPStoreFail = -4, // 打开appstore失败
    BUErrorCodeNOAdError        = -3, // 解析的数据没有广告
    BUErrorCodeNetError         = -2, // 网络请求失败
    BUErrorCodeParseError       = -1, // 解析失败
    
    BUErrorCodeParamError       = 10001,  // 参数错误
    BUErrorCodeTimeout          = 10002,

    BUErrorCodeSuccess          = 20000,
    BUErrorCodeNOAD             = 20001,  // 没有广告
    
    BUErrorCodeContentType      = 40000,  // http conent_type错误
    BUErrorCodeRequestPBError   = 40001,  // http request pb错误
    BUErrorCodeAppEmpty         = 40002,  // 请求app不能为空
    BUErrorCodeWapEMpty         = 40003,  // 请求wap不能为空
    BUErrorCodeAdSlotEmpty      = 40004,  // 缺少广告位描述
    BUErrorCodeAdSlotSizeEmpty  = 40005,  // 广告位尺寸 不合法
    BUErrorCodeAdSlotIDError    = 40006,  // 广告位 ID 不合法
    BUErrorCodeAdCountError     = 40007,  // 请求广告数量 错误
    BUErrorCodeSysError         = 50001   // 广告服务器错误
};
