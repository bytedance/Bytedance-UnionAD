//
//  NSBundle+BUDemo.m
//  BUDemoSource
//
//  Created by Rush.D.Xzj on 2024/5/27.
//

#import "NSBundle+BUDemo.h"

@implementation NSBundle (BUDemo)

+ (NSString *)csjDemoResource_pathForResource:(nullable NSString *)name ofType:(nullable NSString *)ext {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CSJDemoResource" ofType:@"bundle"];
    NSString *config = [[NSBundle bundleWithPath:bundlePath] pathForResource:name ofType:ext];
    return config;
}


@end
