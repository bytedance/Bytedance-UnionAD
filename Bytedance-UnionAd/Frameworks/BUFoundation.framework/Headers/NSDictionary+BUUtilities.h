//
//  NSMutableDictionary+Utilities.h
//  BUAdSDK
//
//  Created by 李盛 on 2018/2/28.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (BU_Helper)

- (BOOL)bu_isNull:(id)value;
- (instancetype)bu_objectForKeySafely:(id)aKey;
- (instancetype)bu_valueForKeySafely:(NSString *)key;
- (instancetype)bu_valueForKeyPathSafely:(NSString *)keyPath;

@end

@interface NSDictionary(BU_JSONValue)

- (NSString *)bu_JSONRepresentation:(NSError **)error;
+ (id)bu_dictionaryWithJSONData:(NSData *)inData error:(NSError **)outError;
+ (id)bu_dictionaryWithJSONString:(NSString *)inJSON error:(NSError **)outError;
@end
