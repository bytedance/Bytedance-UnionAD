//
//  BUADServiceImageFanqieModule.m
//  BUDemo
//
//  Created by zth on 2023/6/26.
//  Copyright © 2023 bytedance. All rights reserved.
//

#import "BUADServiceImageFanqieModule.h"

#import "BUADServiceFanqieImage.h"
#import "BUADServiceImageProtocol.h"

@implementation BUADServiceImageFanqieModule

- (void)configure {
    // name硬编码, 不准备考虑在哪里统一Public的定义. 对外尽量的不暴露
    [self bind:[[BUADServiceImageFanqie alloc] init] toProtocol:@protocol(BUADServiceImageProtocol) name:nil];

}

@end
