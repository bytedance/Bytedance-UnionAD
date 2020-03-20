//
//  BUJSInjectorRule.h
//  BURexxar
//
//  Created by muhuai on 2017/6/17.
//  Copyright © 2017年 muhuai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface BUJSInjectorRule : NSObject

@property (nonatomic, copy) NSString *script;
@property (nonatomic, copy) NSString *regex;
@property (nonatomic, copy) NSString *key;

@property (nonatomic, strong, readonly) NSRegularExpression *regExpression;

+ (instancetype)ruleWithScript:(NSString *)script withRegex:(NSString *)regex key:(NSString *)key;

@end
NS_ASSUME_NONNULL_END
