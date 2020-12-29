//
//  BUDFeedStyleHelper.m
//  BUDemo
//
//  Created by carl on 2017/12/29.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import "BUDFeedStyleHelper.h"
#import <UIKit/UIKit.h>

@implementation BUDFeedStyleHelper

+ (NSAttributedString *)titleAttributeText:(NSString *)text {
    if (text == nil) {
        return nil;
    }
    NSMutableDictionary *attribute = @{}.mutableCopy;
    NSMutableParagraphStyle * titleStrStyle = [[NSMutableParagraphStyle alloc] init];
    titleStrStyle.lineSpacing = 5;
    titleStrStyle.alignment = NSTextAlignmentJustified;
    attribute[NSFontAttributeName] = [UIFont systemFontOfSize:17.f];
    attribute[NSParagraphStyleAttributeName] = titleStrStyle;
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
