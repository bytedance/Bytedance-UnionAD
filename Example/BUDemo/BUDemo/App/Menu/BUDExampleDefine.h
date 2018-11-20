//
//  BUDExampleDefine.h
//  BUDemo
//
//  Created by carl on 2017/12/4.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol BUDExampleViewControl <NSObject>
@end

@protocol BUDExampleViewModel <NSObject>
@property (nonatomic, copy) NSString *slotID;
@end
