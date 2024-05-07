//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#import "BUDRefreshButton.h"
#import "BUDMacros.h"

@implementation BUDRefreshButton
- (instancetype)init {
    self = [super init];
    if (self) {
        CGSize size = [UIScreen mainScreen].bounds.size;
        self.frame = CGRectMake(size.width-20-40, size.height - 120, 40, 40);
        [self setImage:[UIImage imageNamed:@"refresh.png"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"refresh.png"] forState:UIControlStateHighlighted];
    }
    return self;
}
@end
