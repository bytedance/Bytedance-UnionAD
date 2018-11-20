//
//  BUAdSlot.h
//  BUAdSDK
//
//  Created by chenren on 10/05/2017.
//  Copyright © 2017 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUSize.h"

typedef NS_ENUM(NSInteger, BUAdSlotAdType) {
    BUAdSlotAdTypeUnknown       = 0,
    BUAdSlotAdTypeBanner        = 1,       // 横幅广告
    BUAdSlotAdTypeInterstitial  = 2,       // 插屏广告
    BUAdSlotAdTypeSplash        = 3,       // 全屏广告
    BUAdSlotAdTypeSplash_Cache  = 4,       // 缓存开屏
    BUAdSlotAdTypeFeed          = 5,       // feed广告  
    BUAdSlotAdTypePaster        = 6,       // 后贴片
    BUAdSlotAdTypeRewardVideo   = 7,       // 激励视频
    BUAdSlotAdTypeFullscreenVideo = 8,     // 全屏视频
    BUAdSlotAdTypeDrawVideo     = 9,       // 竖版（沉浸式）视频
};

typedef NS_ENUM(NSInteger, BUAdSlotPosition) {
    BUAdSlotPositionTop = 1, // 顶部
    BUAdSlotPositionBottom = 2, // 底部
    BUAdSlotPositionFeed = 3, // 信息流内
    BUAdSlotPositionMiddle = 4, // 中部(插屏广告专用)
    BUAdSlotPositionFullscreen = 5, // 全屏
};

@interface BUAdSlot : NSObject

/// 代码位ID required
@property (nonatomic, copy) NSString *ID;

/// 广告类型 required
@property (nonatomic, assign) BUAdSlotAdType AdType;

/// 广告展现位置 required
@property (nonatomic, assign) BUAdSlotPosition position;

/// 接受一组图片尺寸，数组请传入BUSize对象
@property (nonatomic, strong) NSMutableArray<BUSize *> *imgSizeArray;

/// 图片尺寸 required
@property (nonatomic, strong) BUSize *imgSize;

/// 图标尺寸
@property (nonatomic, strong) BUSize *iconSize;

/// 标题的最大长度
@property (nonatomic, assign) NSInteger titleLengthLimit;

/// 描述的最大长度
@property (nonatomic, assign) NSInteger descLengthLimit;

/// 是否支持deeplink
@property (nonatomic, assign) BOOL isSupportDeepLink;

/// 1.9.5 原生banner广告、原生插屏广告设置为1，其他广告类型为0，默认是0
@property (nonatomic, assign) BOOL isOriginAd;

- (NSDictionary *)dictionaryValue;

@end

