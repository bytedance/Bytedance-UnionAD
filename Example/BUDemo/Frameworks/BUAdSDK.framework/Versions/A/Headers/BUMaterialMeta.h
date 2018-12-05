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
    BUInteractionTypeNO_INTERACTION = 1,        // 纯展示广告
    BUInteractionTypeURL = 2,                   // 使用浏览器打开网页
    BUInteractionTypePage = 3,                  // 应用内打开网页
    BUInteractionTypeDownload = 4,              // 下载应用
    BUInteractionTypePhone = 5,                 // 拨打电话
    BUInteractionTypeMessage = 6,               // 发送短信
    BUInteractionTypeEmail = 7,                 // 发邮件
    BUInteractionTypeVideoAdDetail = 8          // 视频广告详情页
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

/// 不喜欢广告原因。“不感兴趣”本地拼接，其他服务端下发
@property (nonatomic, copy) NSArray<BUDislikeWords *> *filterWords;

/// feed广告的展示类型，banner广告忽略
@property (nonatomic, assign) BUFeedADMode imageMode;

/// 评分（星级），取值范围1-5
@property (nonatomic, assign) NSInteger score;

/// 评论人数
@property (nonatomic, assign) NSInteger commentNum;

/// 广告安装包大小,单位byte
@property (nonatomic, assign) NSInteger appSize;

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError * __autoreleasing *)error;

@end

