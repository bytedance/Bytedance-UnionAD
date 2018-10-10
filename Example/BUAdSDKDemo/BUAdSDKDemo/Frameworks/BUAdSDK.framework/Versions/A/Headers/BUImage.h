//
//  BUImage.h
//  BUAdSDK
//
//  Created by chenren on 10/05/2017.
//  Copyright © 2017 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BUImage : NSObject <NSCoding>

// 图片地址URL
@property (nonatomic, copy) NSString *imageURL;

// 图片高度
@property (nonatomic, assign) float width;

// 图片宽度
@property (nonatomic, assign) float height;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end

