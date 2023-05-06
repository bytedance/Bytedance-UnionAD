//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#import "BUDAdmobTool.h"
#import <PAGAdSDK/PAGConfig.h>

@implementation BUDAdmobTool
+ (void)setExtData {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /// tag
        [[PAGConfig shareConfig] setUserDataString:[NSString stringWithFormat:@"[{\"name\":\"mediation\",\"value\":\"admob\"},{\"name\":\"adapter_version\",\"value\":\"%@\"}]", PAGAdmobCustomEventAdapterVersion]];
    });
}
@end
