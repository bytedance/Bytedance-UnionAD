//
//  BUAdSDKError.h
//  BUAdSDK
//
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSErrorDomain BUErrorDomain ;

typedef NS_ENUM(NSInteger, BUErrorCode) {
    
    BUErrorCodeOpenAPPStoreFail = -4,       // failed to open appstore
    BUErrorCodeNOAdError        = -3,       // parsed data has no ads
    BUErrorCodeNetError         = -2,       // network request failed
    BUErrorCodeParseError       = -1,       // parsing failed
    
    BUErrorCodeNERenderResultError= 101,    // native Express ad, render result parse fail
    BUErrorCodeNETempError        = 102,    // native Express ad, template is invalid
    BUErrorCodeNETempPluginError  = 103,    // native Express ad, template plugin is invalid
    BUErrorCodeNEDataError        = 104,    // native Express ad, data is invalid
    BUErrorCodeNEParseError       = 105,    // native Express ad, parse fail
    BUErrorCodeNERenderError      = 106,    // native Express ad, render fail
    BUErrorCodeNERenderTimoutError= 107,    // native Express ad, render timeout
    
    BUErrorCodeParamError       = 10001,    // parameter error
    BUErrorCodeTimeout          = 10002,

    BUErrorCodeSuccess          = 20000,
    BUErrorCodeNOAD             = 20001,    // no ads
    
    BUErrorCodeContentType      = 40000,    // http conent_type error
    BUErrorCodeRequestPBError   = 40001,    // http request pb error
    BUErrorCodeAppEmpty         = 40002,    // request app can't be empty
    BUErrorCodeWapEMpty         = 40003,    // request wap can't be empty
    BUErrorCodeAdSlotEmpty      = 40004,    // missing ad slot description
    BUErrorCodeAdSlotSizeEmpty  = 40005,    // the ad slot size is invalid
    BUErrorCodeAdSlotIDError    = 40006,    // the ad slot ID is invalid
    BUErrorCodeAdCountError     = 40007,    // request the wrong number of ads
    BUErrorCodeAdPackageIncomplete = 40025, // the SDK package is incomplete. It is recommended to verify the integrity of SDK package or contact technical support.
    
    BUErrorCodeSysError         = 50001     // ad server error
};
