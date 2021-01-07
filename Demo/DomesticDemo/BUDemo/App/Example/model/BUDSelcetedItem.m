//
//  BUDSelcetedItem.m
//  BUDemo
//
//  Created by cuiyanan on 2019/12/4.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDSelcetedItem.h"

@implementation BUDSelcetedItem
- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.slotID = dict[@"slotID"];
        self.title = dict[@"title"];
    }
    return self;
}
@end
