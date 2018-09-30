//
//  WMSize.h
//  WMAdSDK
//
//  Created by chenren on 10/05/2017.
//  Copyright © 2017 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 按照这个尺寸获取广告能够获取到最佳效果的视图，单位为像素，
 具体到视图展示时， 建议采用相同的比例缩放
*/
typedef NS_ENUM(NSInteger, WMProposalSize) {
    WMProposalSize_Banner600_90,
    WMProposalSize_Banner600_100,
    WMProposalSize_Banner600_150,
    WMProposalSize_Banner600_260,
    WMProposalSize_Banner600_286,
    WMProposalSize_Banner600_300,
    WMProposalSize_Banner600_388,
    WMProposalSize_Banner600_400,
    WMProposalSize_Banner600_500,
    WMProposalSize_Feed228_150,
    WMProposalSize_Feed690_388,
    WMProposalSize_Interstitial600_400,
    WMProposalSize_Interstitial600_600,
    WMProposalSize_Interstitial600_900,
};

@interface WMSize : NSObject

// 宽度
@property (nonatomic, assign) NSInteger width;

// 高度
@property (nonatomic, assign) NSInteger height;

- (NSDictionary *)dictionaryValue;

@end

@interface WMSize (WM_SizeFactory)
+ (instancetype)sizeBy:(WMProposalSize)proposalSize;
@end
