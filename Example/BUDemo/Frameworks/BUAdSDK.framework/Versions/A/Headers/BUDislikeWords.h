//
//  BUDislikeWords.h
//  BUAdSDK
//
//  Created by carl on 2017/8/10.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BUDislikeWords : NSObject <NSCoding>
@property (nonatomic, copy, readonly) NSString *dislikeID;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, assign, readonly) BOOL isSelected;
@property (nonatomic, copy,readonly) NSArray<BUDislikeWords *> *options;

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError **)error;
@end
