//
//  BUAActionCellView.m
//  WMAdSDKDemo
//
//  Created by carl on 2017/7/29.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import "BUAActionCellView.h"

@class BUAPlainTitleActionModel;

@implementation BUAPlainTitleActionModel

@end

@implementation BUAActionModel (BUAModelFactory)

+ (instancetype)plainTitleActionModel:(NSString *)title action:(ActionCommandBlock)action {
    BUAPlainTitleActionModel *model = [BUAPlainTitleActionModel new];
    model.title = title;
    model.action = [action copy];
    return model;
}

@end

@interface BUAActionCellView ()
@property (nonatomic, strong) BUAPlainTitleActionModel *model;
@end

@implementation BUAActionCellView

- (void)configWithModel:(BUAPlainTitleActionModel *)model {
    if ([model isKindOfClass:[BUAPlainTitleActionModel class]]) {
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
