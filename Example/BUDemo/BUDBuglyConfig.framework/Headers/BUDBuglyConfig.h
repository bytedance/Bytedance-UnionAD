//
//  BUDBuglyConfig.h
//  BUDBuglyConfig
//
//  Created by bytedance on 2020/9/9.
//

#import <Foundation/Foundation.h>

@interface BUDBuglyConfig : NSObject

+ (void)startWithBugly:(Class)bugly andConfig:(id)config;

@end
