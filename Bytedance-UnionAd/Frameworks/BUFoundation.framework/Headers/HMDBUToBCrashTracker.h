//Jenkins防系统库编译出错自动添加 
#import <UIKit/UIKit.h> 
//Jenkins防系统库编译出错自动添加 
//
//  HMDBUToBCrashTracker.h
//  Heimdallr
//
//  Created by jinlin.liu on 2019/2/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HMDBUToBCrashTracker : NSObject

@property (nonatomic, strong, readonly) NSString *crashPath;

+ (instancetype)sharedTracker;

/*  使用说明：
    此库需与RangersAppLog SDK组合使用，请首先完成RangersAppLog SDK配置及启动，而后直接使用本库的start启动即可，
    单独使用本库则会抛出异常
 */
- (void)start;

@end

NS_ASSUME_NONNULL_END
