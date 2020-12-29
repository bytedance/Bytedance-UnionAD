//
//  BUDSwitchView.h
//  BUDemo
//
//  Created by Rush.D.Xzj on 2020/10/22.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUDSwitchView : UIView
@property (nonatomic, readonly, getter=isOn) BOOL on;

- (id)initWithTitle:(NSString *)title on:(BOOL)on height:(CGFloat)height;
@end

NS_ASSUME_NONNULL_END
