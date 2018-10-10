//
//  BUMaterialMeta.h
//  BUAdSDK
//
//  Created by chenren on 10/05/2017.
//  Copyright © 2017 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUDislikeWords.h"
#import "BUImage.h"

typedef NS_ENUM(NSInteger, BUInteractionType) {
    BUInteractionTypeCustorm = 0,
    BUInteractionTypeNO_INTERACTION = 1,    // 纯展示广告
    BUInteractionTypeURL = 2,               // 使用浏览器打开网页
    BUInteractionTypePage,                  // 应用内打开网页
    BUInteractionTypeDownload,              // 下载应用
    BUInteractionTypePhone ,                // 拨打电话
    BUInteractionTypeMessage,               // 发送短信
    BUInteractionTypeEmail,                 // 发邮件
    BUInteractionTypeVideoAdDetail          // 视频广告详情页
};

typedef NS_ENUM(NSInteger, BUFeedADMode) {
    BUFeedADModeSmallImage = 2,
    BUFeedADModeLargeImage = 3,
    BUFeedADModeGroupImage = 4,
    BUFeedVideoAdModeImage = 5, // 视频广告 || 激励视频横屏
    BUFeedVideoAdModePortrait = 15 // 激励视频竖屏
};

@interface BUMaterialMeta : NSObject <NSCoding>

/// 广告支持的交互类型
@property (nonatomic, assign) BUInteractionType interactionType;

/// 素材图片
@property (nonatomic, strong) NSArray<BUImage *> *imageAry;

/// 图标图片
@property (nonatomic, strong) BUImage *icon;

/// 广告标题
@property (nonatomic, copy) NSString *AdTitle;

/// 广告描述
@property (nonatomic, copy) NSString *AdDescription;

/// 广告来源
@property (nonatomic, copy) NSString *source;

/// 创意按钮显示文字
@property (nonatomic, copy) NSString *buttonText;

/// 客户不喜欢广告，关闭时， 提示不喜欢原因
@property (nonatomic, copy) NSArray<BUDislikeWords *> *filterWords;

/// feed广告的展示类型，banner广告忽略
@property (nonatomic, assign) BUFeedADMode imageMode;

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError * __autoreleasing *)error;

@end

