//
//  BUDSelcetedItem.h
//  BUDemo
//
//  Created by cuiyanan on 2019/12/4.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUDSelcetedItem : NSObject
@property (nonatomic, copy) NSString *slotID;
@property (nonatomic, copy) NSString *title;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
