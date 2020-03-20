//
//  NSMutableArray+Utilities.h
//  BUAdSDK
//
//  Created by 李盛 on 2018/2/28.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (BU_Utilities)

- (void)bu_safeAddObject:(id)object;
- (void)bu_safeAddNilObject;
- (void)bu_safeInsertObject:(id)object atIndex:(NSUInteger)index;
- (void)bu_safeInsertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes;
- (void)bu_safeRemoveObject:(id)object;
- (instancetype)bu_objectAtIndexSafely:(NSUInteger)index;
- (void)bu_removeObjectAtIndexSafely:(NSUInteger)index;

@end

@interface NSArray(BU_JSONValue)
- (NSString *)bu_JSONRepresentation:(NSError **)error;
@end

