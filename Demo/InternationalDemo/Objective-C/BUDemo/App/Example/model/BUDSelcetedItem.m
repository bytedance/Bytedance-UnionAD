//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

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
