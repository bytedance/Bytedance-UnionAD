//
//  BUMDCustomDrawView.h
//  BUMDemo
//
//  Created by ByteDance on 2022/5/6.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUMDCustomDrawView : UIView

@property (nonatomic, copy, nullable) void(^didMoveToSuperViewCallback)(BUMDCustomDrawView *view);

@end

NS_ASSUME_NONNULL_END
