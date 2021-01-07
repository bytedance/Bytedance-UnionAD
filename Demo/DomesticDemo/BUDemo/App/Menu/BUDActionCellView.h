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
    BUDCellType_native            = 0,       // native ad
    BUDCellType_normal            = 1,       // non native ad
    BUDCellType_video             = 2,       // video ad
    BUDCellType_setting           = 3,       // setting
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
