//
//  BUMDFeedNormalModel.h
//  BUDemo
//
//  Created by ByteDance on 2022/10/23.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUMDFeedNormalModel : NSObject
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *incon;
@property (nonatomic, copy) NSArray *imgs;
@property (nonatomic, assign) float cellHeight;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END

