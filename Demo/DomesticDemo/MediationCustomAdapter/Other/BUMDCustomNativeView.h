//
//  BUMDCustomNativeView.h
//  BUMDemo
//
//  Created by bytedance on 2021/10/21.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUMDCustomNativeView : UIView

@property (nonatomic, copy, nullable) void(^didMoveToSuperViewCallback)(BUMDCustomNativeView *view);

@end

NS_ASSUME_NONNULL_END
