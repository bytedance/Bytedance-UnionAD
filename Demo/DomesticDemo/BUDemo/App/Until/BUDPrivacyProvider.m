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

@end
