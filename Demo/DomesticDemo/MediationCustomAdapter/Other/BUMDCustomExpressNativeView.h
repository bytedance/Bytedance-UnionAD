//
//  BUMDCustomExpressNativeView.h
//  BUMDemo
//
//  Created by bytedance on 2021/10/21.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUMDCustomExpressNativeView : UIView

- (instancetype)initWithSize:(CGSize)size andImageSize:(CGSize)imageSize;

@property (nonatomic, weak) UIViewController *viewController;

@property (nonatomic, copy) void(^didClickAction)(BUMDCustomExpressNativeView *view);

@property (nonatomic, copy) void(^didMoveToSuperViewCallback)(BUMDCustomExpressNativeView *view);

@property (nonatomic, copy) void(^didClickCloseAction)(BUMDCustomExpressNativeView *view);
@end

NS_ASSUME_NONNULL_END
