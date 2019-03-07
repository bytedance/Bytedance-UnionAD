//
//  BUDislike.h
//  BUAdSDK
//
//  Created by iCuiCui on 2018/12/12.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BUNativeAd;
@class BUDislikeWords;
/**
 用户点击选择后请将原因上报给SDK，否则模型不准会导致广告投放效果差
 */
@interface BUDislike : NSObject
/**
 获取到的不感兴趣原因 filterWords.options存在说明可以点击进入二级页面
 */
@property (nonatomic, copy, readonly) NSArray<BUDislikeWords *> *filterWords;
/**
 用nativeAd初始化后即可获取filterWords
 */
- (instancetype)initWithNativeAd:(BUNativeAd *)nativeAd;

/**
 用户点击 dislike选项后上报的接口（仅限使用filterWords自己拼接不感兴趣原因时用）
 @param filterWord 不喜欢的原因
 @note 存在二级页面时一级不感兴趣的原因不需要上报
 @note 获取到的上报原因BUDislikeWords请不要更改、直接上报即可，否则会被过滤
 */
- (void)didSelectedFilterWordWithReason:(BUDislikeWords *)filterWord;
@end

