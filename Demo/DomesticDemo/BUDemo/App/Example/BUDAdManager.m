//
//  BUDAdManager.m
//  BUDemo
//
//  Created by carlliu on 2017/7/27.
//  Copyright © 2017年 chenren. All rights reserved.
//

#import "BUDAdManager.h"


/**
 https://wiki.bytedance.net/pages/viewpage.action?pageId=146011735
 */
@implementation BUDAdManager

+ (NSString *)appKey {
    // xzj_test 更换其他的appId
#if DEBUG
//    return @"11111";
#endif
    return @"5000546";
}

@end
