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

@interface BUDPlainTitleActionModel : BUDActionModel
@property (nonatomic, copy) NSString *title;
@end

@interface BUDActionModel (BUDModelFactory)
+ (instancetype)plainTitleActionModel:(NSString *)title action:(ActionCommandBlock)action;
@end

@interface BUDActionCellView : UITableViewCell <BUDActionCellConfig, BUDCommandProtocol>

@end
