//
//  BUDActionCellDefine.h
//  BUAdSDKDemo
//
//  Created by carl on 2017/7/29.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BUDActionModel;
@class BUDPlainTitleActionModel;

typedef void(^ActionCommandBlock)(void);

@protocol BUDCommandProtocol <NSObject>
- (void)execute;
@end

@protocol BUDActionCellConfig <NSObject>

- (void)configWithModel:(BUDActionModel *)model;

@end

@interface BUDActionModel : NSObject
@property (nonatomic, copy) ActionCommandBlock action;
@end

