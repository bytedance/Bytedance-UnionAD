//
//  BUMDCustomExpressDrawView.h
//  BUMDemo
//
//  Created by ByteDance on 2022/5/6.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUMDCustomExpressDrawView : UIView

- (instancetype)initWithSize:(CGSize)size;

@property (nonatomic, weak) UIViewController *viewController;

@property (nonatomic, copy, nullable) void(^didClickAction)(BUMDCustomExpressDrawView *view);

@property (nonatomic, copy, nullable) void(^didMoveToSuperViewCallback)(BUMDCustomExpressDrawView *view);

@property (nonatomic, copy, nullable) void(^didClickCloseAction)(BUMDCustomExpressDrawView *view);

@end

NS_ASSUME_NONNULL_END
