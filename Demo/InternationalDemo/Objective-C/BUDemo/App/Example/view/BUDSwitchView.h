//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUDSwitchView : UIView
@property (nonatomic, readonly, getter=isOn) BOOL on;
@property (nonatomic, strong) UISwitch *switchView;

- (id)initWithTitle:(NSString *)title on:(BOOL)on height:(CGFloat)height;
@end

NS_ASSUME_NONNULL_END
