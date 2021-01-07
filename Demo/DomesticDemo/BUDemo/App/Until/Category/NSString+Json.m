//
//  NSString+Json.m
//  BUDemo
//
//  Created by iCuiCui on 2018/10/28.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "NSString+Json.h"

@implementation NSString (Json)
- (id)objectFromJSONString {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}
@end
