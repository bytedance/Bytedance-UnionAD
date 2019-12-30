//
//  BUDConfigModel.h
//  BUDemo
//
//  Created by 李盛 on 2019/10/21.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUDConfigModel : NSObject

/// 自动播放开关
@property (nonatomic, assign) BOOL enableAutoPlay;

+ (BUDConfigModel *)sharedConfigModel;

@end

NS_ASSUME_NONNULL_END
