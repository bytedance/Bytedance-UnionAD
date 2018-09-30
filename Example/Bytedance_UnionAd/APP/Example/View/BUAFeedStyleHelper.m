//
//  BUAFeedStyleHelper.m
//  BUAemo
//
//  Created by carl on 2017/12/29.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import "BUAFeedStyleHelper.h"
#import <UIKit/UIKit.h>

@implementation BUAFeedStyleHelper

+ (NSAttributedString *)titleAttributeText:(NSString *)text {
    if (text == nil) {
        return nil;
    }
    NSMutableDictionary *attribute = @{}.mutableCopy;
    attribute[NSFontAttributeName] = [UIFont systemFontOfSize:17.f];
    return [[NSAttributedString alloc] initWithString:text attributes:attribute];
}

+ (NSAttributedString *)subtitleAttributeText:(NSString *)text {
    if (text == nil) {
        return nil;
    }
    NSMutableDictionary *attribute = @{}.mutableCopy;
    attribute[NSFontAttributeName] = [UIFont systemFontOfSize:12.f];
    attribute[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    return [[NSAttributedString alloc] initWithString:text attributes:attribute];
}

+ (NSAttributedString *)infoAttributeText:(NSString *)text {
    if (text == nil) {
        return nil;
    }
    NSMutableDictionary *attribute = @{}.mutableCopy;
    attribute[NSFontAttributeName] = [UIFont systemFontOfSize:12.f];
    attribute[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    return [[NSAttributedString alloc] initWithString:text attributes:attribute];
}

@end
