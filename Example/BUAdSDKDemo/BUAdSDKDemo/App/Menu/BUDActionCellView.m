//
//  BUDActionCellView.m
//  BUAdSDKDemo
//
//  Created by carl on 2017/7/29.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import "BUDActionCellView.h"

@class BUDPlainTitleActionModel;

@implementation BUDPlainTitleActionModel

@end

@implementation BUDActionModel (BUDModelFactory)

+ (instancetype)plainTitleActionModel:(NSString *)title action:(ActionCommandBlock)action {
    BUDPlainTitleActionModel *model = [BUDPlainTitleActionModel new];
    model.title = title;
    model.action = [action copy];
    return model;
}

@end

@interface BUDActionCellView ()
@property (nonatomic, strong) BUDPlainTitleActionModel *model;
@end

@implementation BUDActionCellView

- (void)configWithModel:(BUDPlainTitleActionModel *)model {
    if ([model isKindOfClass:[BUDPlainTitleActionModel class]]) {
        self.model = model;
        self.textLabel.text = self.model.title;
    }
}

- (void)execute {
    if (self.model.action) {
        self.model.action();
    }
}

@end
