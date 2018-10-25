//
//  BUSize.h
//  BUAdSDK
//
//  Created by chenren on 10/05/2017.
//  Copyright © 2017 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 按照这个尺寸获取广告能够获取到最佳效果的视图，单位为像素，
 具体到视图展示时， 建议采用相同的比例缩放
*/
typedef NS_ENUM(NSInteger, BUProposalSize) {
    BUProposalSize_Banner600_90,
    BUProposalSize_Banner600_100,
    BUProposalSize_Banner600_150,
    BUProposalSize_Banner600_260,
    BUProposalSize_Banner600_286,
    BUProposalSize_Banner600_300,
    BUProposalSize_Banner600_388,
    BUProposalSize_Banner600_400,
    BUProposalSize_Banner600_500,
    BUProposalSize_Feed228_150,
    BUProposalSize_Feed690_388,
    BUProposalSize_Interstitial600_400,
    BUProposalSize_Interstitial600_600,
    BUProposalSize_Interstitial600_900,
    BUProposalSize_DrawFullScreen
};

@interface BUSize : NSObject

// 宽度 像素pixel
@property (nonatomic, assign) NSInteger width;

// 高度 像素pixel
@property (nonatomic, assign) NSInteger height;

- (NSDictionary *)dictionaryValue;

@end

@interface BUSize (BU_SizeFactory)
+ (instancetype)sizeBy:(BUProposalSize)proposalSize;
@end
