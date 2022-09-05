//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

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

