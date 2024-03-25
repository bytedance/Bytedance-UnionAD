//
//  BUADServiceImageFanqie.h
//  BUDemo
//
//  Created by zth on 2023/6/26.
//  Copyright © 2023 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<BUAdSDK/BUADServiceImageProtocol.h>)
#import <BUAdSDK/BUADServiceImageProtocol.h>
#else
#import "BUADServiceImageProtocol.h"
#endif



NS_ASSUME_NONNULL_BEGIN

@interface BUADServiceImageFanqie : NSObject <BUADServiceImageProtocol>
@end

NS_ASSUME_NONNULL_END
