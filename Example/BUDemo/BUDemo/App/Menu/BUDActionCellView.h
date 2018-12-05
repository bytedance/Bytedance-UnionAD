//
//  BUDActionCellView.h
//  BUAdSDKDemo
//
//  Created by carl on 2017/7/29.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BUDActionCellDefine.h"

typedef NS_ENUM(NSInteger, BUDCellType) {
    BUDCellType_native            = 0,       // 原生广告
    BUDCellType_normal            = 1,       // 正常广告
    BUDCellType_video             = 2,       // 视频广告
    BUDCellType_setting           = 3,       // 设置
    BUDCellType_CustomEvent       = 4        // CustomEvent
};

@interface BUDPlainTitleActionModel : BUDActionModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BUDCellType cellType;
@end

@interface BUDActionModel (BUDModelFactory)
+ (instancetype)plainTitleActionModel:(NSString *)title type:(BUDCellType)type action:(ActionCommandBlock)action;
@end

@interface BUDActionCellView : UITableViewCell <BUDActionCellConfig, BUDCommandProtocol>

@end
