//Jenkins防系统库编译出错自动添加 
#import <UIKit/UIKit.h> 
//Jenkins防系统库编译出错自动添加 
//
//  HMDBUToBCrashTrackerRestrict.h
//  HeimdallrToB
//
//  Created by sunrunwang on 2019/6/18.
//

#import <Foundation/Foundation.h>
#import "HMDBUToBAddressRange.h"

NS_ASSUME_NONNULL_BEGIN

@interface HMDBUToBCrashTrackerRestrict : NSObject

/**
 这个函数目前只支持调用一次 接下来的调用没有作用
 */
+ (void)registerAddressRanges:(NSArray<HMDBUToBAddressRange *> *)addressRanges;

@end

NS_ASSUME_NONNULL_END
