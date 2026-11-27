//
//  BUDPrivacyProvider.m
//  BUDemo
//
//  Created by Willie on 2021/9/9.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "BUDPrivacyProvider.h"

@implementation BUDPrivacyProvider

- (BOOL)canUseLocation {
    return YES;
}

- (CLLocationDegrees)latitude {
    return 40;
}

- (CLLocationDegrees)longitude {
    return 120;
}

- (BOOL)canUseWiFiBSSID {
    return YES;
}

- (NSDictionary *)privacyConfig {
    NSMutableDictionary *privacy = [NSMutableDictionary dictionary];
    // motion_info表示是否允许传感器采集数据，默认不传时允许采集
    // "0": 不允许
    // "1": 允许
    // 其他值或不实现该协议方法认为允许采集
    [privacy setObject:@"1" forKey:@"motion_info"];

    // forbidden_idfa表示是否禁止idfa采集，"1"表示禁止
    [privacy setObject:@"0" forKey:@"forbidden_idfa"];

//    [privacy setObject:@"0" forKey:@"disable_default_attr"];

    return [privacy copy];
}

@end
