//
//  BUTLocationService.h
//  BUAdSDK
//
//  Created by carl on 2017/8/17.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUGeo.h"

@interface BUTLocationService : NSObject

@property (nonatomic, strong, readonly) BUGeo *geo;
+ (instancetype)locationService;
- (void)requestLatestStatus;
@end
