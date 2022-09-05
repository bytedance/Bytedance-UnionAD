//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#import <Foundation/Foundation.h>


@protocol BUDExampleViewControl <NSObject>
@end

@protocol BUDExampleViewModel <NSObject>
@property (nonatomic, copy) NSString *slotID;
@end
