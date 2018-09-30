//
//  BUAActionCellView.h
//  WMAdSDKDemo
//
//  Created by carl on 2017/7/29.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BUAActionCellDefine.h"

@interface BUAPlainTitleActionModel : BUAActionModel
@property (nonatomic, copy) NSString *title;
@end

@interface BUAActionModel (BUAModelFactory)
+ (instancetype)plainTitleActionModel:(NSString *)title action:(ActionCommandBlock)action;
@end

@interface BUAActionCellView : UITableViewCell <BUAActionCellConfig, BUACommandProtocol>

@end
