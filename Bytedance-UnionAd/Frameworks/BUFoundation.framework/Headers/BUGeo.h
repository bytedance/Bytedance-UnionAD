//
//  BUGeo.h
//  BUAdSDK
//
//  Created by chenren on 10/05/2017.
//  Copyright © 2017 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BUGeo : NSObject

// 经度
@property (atomic, strong) NSNumber *latitude;

// 纬度
@property (atomic, strong) NSNumber *longitude;

- (NSDictionary *)dictionaryValue;

@end

