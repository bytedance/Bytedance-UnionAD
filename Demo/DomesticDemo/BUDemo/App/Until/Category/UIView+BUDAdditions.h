//
//  UIView+BUAdditions.h
//  BUAdSDK
//
//  Created by bytedance_yuanhuan on 2018/3/15.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (BUD_FrameAdditions)
@property (nonatomic) float bu_x;
@property (nonatomic) float bu_y;
@property (nonatomic) float bu_width;
@property (nonatomic) float bu_height;
@property (nonatomic, getter = bu_y,setter = setBu_y:) float bu_top;    // 增加bu前缀，防止与外部开发者的分类属性名冲突：https://jira.bytedance.com/browse/UNION-4447 fixed in 3300 by chaors
@property (nonatomic, getter = bu_x,setter = setBu_x:) float bu_left;
@property (nonatomic) float bud_bottom;
@property (nonatomic) float bu_right;
@property (nonatomic) CGSize bud_size;
@property (nonatomic) CGPoint bu_origin;
@property (nonatomic) CGFloat bu_centerX;
@property (nonatomic) CGFloat bu_centerY;

@end


NS_ASSUME_NONNULL_END
