//
//  WMMaterialMeta.h
//  WMAdSDK
//
//  Created by chenren on 10/05/2017.
//  Copyright © 2017 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WMDislikeWords.h"
#import "WMImage.h"

typedef NS_ENUM(NSInteger, WMInteractionType) {
    WMInteractionTypeCustorm = 0,
    WMInteractionTypeNO_INTERACTION = 1,    // 纯展示广告
    WMInteractionTypeURL = 2,               // 使用浏览器打开网页
    WMInteractionTypePage,                  // 应用内打开网页
    WMInteractionTypeDownload,              // 下载应用
    WMInteractionTypePhone ,                // 拨打电话
    WMInteractionTypeMessage,               // 发送短信
    WMInteractionTypeEmail,                 // 发邮件
    WMInteractionTypeVideoAdDetail          // 视频广告详情页
};

typedef NS_ENUM(NSInteger, WMFeedADMode) {
    WMFeedADModeSmallImage = 2,
    WMFeedADModeLargeImage = 3,
    WMFeedADModeGroupImage = 4,
    WMFeedVideoAdModeImage = 5, // 视频广告 || 激励视频横屏
    WMFeedVideoAdModePortrait = 15 // 激励视频竖屏
};

@interface WMMaterialMeta : NSObject <NSCoding>

/// 广告支持的交互类型
@property (nonatomic, assign) WMInteractionType interactionType;

/// 素材图片
@property (nonatomic, strong) NSArray<WMImage *> *imageAry;

/// 图标图片
@property (nonatomic, strong) WMImage *icon;

/// 广告标题
@property (nonatomic, copy) NSString *AdTitle;

/// 广告描述
@property (nonatomic, copy) NSString *AdDescription;

/// 广告来源
@property (nonatomic, copy) NSString *source;

/// 创意按钮显示文字
@property (nonatomic, copy) NSString *buttonText;

/// 客户不喜欢广告，关闭时， 提示不喜欢原因
@property (nonatomic, copy) NSArray<WMDislikeWords *> *filterWords;

/// feed广告的展示类型，banner广告忽略
@property (nonatomic, assign) WMFeedADMode imageMode;

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError * __autoreleasing *)error;

@end

