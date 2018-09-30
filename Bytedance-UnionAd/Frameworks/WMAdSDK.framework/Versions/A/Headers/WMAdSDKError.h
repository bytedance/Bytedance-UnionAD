//
//  WMAdSDKError.h
//  WMAdSDK
//
//  Created by carl on 2017/7/29.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSErrorDomain WMErrorDomain ;

typedef NS_ENUM(NSInteger, WMErrorCode) {
    WMErrorCodeNOAdError        = -3, // 解析的数据没有广告
    WMErrorCodeNetError         = -2, // 网络请求失败
    WMErrorCodeParseError       = -1, // 解析失败
    
    WMErrorCodeParamError       = 10001,  // 参数错误
    WMErrorCodeTimeout          = 10002,

    WMErrorCodeSuccess          = 20000,
    WMErrorCodeNOAD             = 20001,  // 没有广告
    
    WMErrorCodeContentType      = 40000,  //http conent_type错误
    WMErrorCodeRequestPBError   = 40001,  // http request pb错误
    WMErrorCodeAppEmpty         = 40002,  //请求app不能为空
    WMErrorCodeWapEMpty         = 40003,  //请求wap不能为空
    WMErrorCodeAdSlotEmpty      = 40004,  // 缺少广告位描述
    WMErrorCodeAdSlotSizeEmpty  = 40005,  // 广告位尺寸 不合法
    WMErrorCodeAdSlotIDError    = 40006,  // 广告位 ID 不合法
    WMErrorCodeAdCountError     = 40007,  // 请求广告数量 错误
    WMErrorCodeSysError         = 50001   // 广告服务器错误
};
