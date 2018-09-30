//
//  BUAFeedStyleHelper.h
//  BUAemo
//
//  Created by carl on 2017/12/29.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BUAFeedStyleHelper : NSObject
+ (NSAttributedString *)titleAttributeText:(NSString *)text;
+ (NSAttributedString *)subtitleAttributeText:(NSString *)text;
+ (NSAttributedString *)infoAttributeText:(NSString *)text;
@end
