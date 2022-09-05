//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

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

@end
