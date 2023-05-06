//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#import <Foundation/Foundation.h>

@interface BUDFeedNormalModel : NSObject
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *incon;
@property (nonatomic, copy) NSArray *imgs;
@property (nonatomic, assign) float cellHeight;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
