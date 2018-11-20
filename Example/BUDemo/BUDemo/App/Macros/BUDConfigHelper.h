//
//  BUDConfigHelper.h
//  BUDemo
//
//  Created by gdp on 2017/12/28.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BUDConfigHelper : NSObject

+ (instancetype)sharedInstance;

- (void)readingPreference;

@end
