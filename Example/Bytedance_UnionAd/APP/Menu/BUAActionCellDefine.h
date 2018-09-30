//
//  BUAActionCellDefine.h
//  WMAdSDKDemo
//
//  Created by carl on 2017/7/29.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BUAActionModel;
@class BUAPlainTitleActionModel;

typedef void(^ActionCommandBlock)(void);

@protocol BUACommandProtocol <NSObject>
- (void)execute;
@end

@protocol BUAActionCellConfig <NSObject>

- (void)configWithModel:(BUAActionModel *)model;

@end

@interface BUAActionModel : NSObject
@property (nonatomic, copy) ActionCommandBlock action;
@end

