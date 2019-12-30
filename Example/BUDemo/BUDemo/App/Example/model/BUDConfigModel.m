//
//  BUDConfigModel.m
//  BUDemo
//
//  Created by 李盛 on 2019/10/21.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDConfigModel.h"

@implementation BUDConfigModel

+ (BUDConfigModel *)sharedConfigModel {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@end
