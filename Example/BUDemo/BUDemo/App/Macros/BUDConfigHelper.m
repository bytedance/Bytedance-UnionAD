//
//  BUDConfigHelper.m
//  BUDemo
//
//  Created by gdp on 2017/12/28.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import "BUDConfigHelper.h"

@implementation BUDConfigHelper

+ (instancetype)sharedInstance {
    static BUDConfigHelper *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[BUDConfigHelper alloc] init];
    });
    return sharedInstance;
}

- (void)readingPreference {
    //获取Settings.bundle路径
    NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    if(!settingsBundle)
    {
        NSLog(@"找不到Settings.bundle文件");
        return;
    }
    //读取Settings.bundle里面的配置信息
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
    NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];
    NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
    for(NSDictionary *prefSpecification in preferences)
    {
        NSString *key = [prefSpecification objectForKey:@"Key"];
        if(key)
        {
            [defaultsToRegister setObject:[prefSpecification objectForKey:@"DefaultValue"] forKey:key];
        }
    }
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsToRegister];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
