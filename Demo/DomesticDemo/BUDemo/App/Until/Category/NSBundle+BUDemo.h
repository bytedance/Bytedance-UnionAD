//
//  NSBundle+BUDemo.h
//  BUDemoSource
//
//  Created by Rush.D.Xzj on 2024/5/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (BUDemo)

+ (NSString *)csjDemoResource_pathForResource:(nullable NSString *)name ofType:(nullable NSString *)ext;

@end

NS_ASSUME_NONNULL_END
