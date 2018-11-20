//
//  BUDislikeWords.h
//  BUAdSDK
//
//  Created by carl on 2017/8/10.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BUDislikeWords : NSObject <NSCoding>
@property (nonatomic, copy) NSString *dislikeID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL isSelected;

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError **)error;
@end
