//
//  UIView+Additions.m
//  BUAdSDK
//
//  Created by bytedance_yuanhuan on 2018/3/15.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "UIView+BUDAdditions.h"

@implementation UIView (BUD_FrameAdditions)
- (float)bu_x {
    return self.frame.origin.x;
}

- (void)setBu_x:(float)newX {
    CGRect frame = self.frame;
    frame.origin.x = newX;
    self.frame = frame;
}

- (float)bu_y {
    return self.frame.origin.y;
}

- (void)setBu_y:(float)newY {
    CGRect frame = self.frame;
    frame.origin.y = newY;
    self.frame = frame;
}

- (float)bu_width {
    return self.frame.size.width;
}

- (void)setBu_width:(float)newWidth {
    CGRect frame = self.frame;
    frame.size.width = newWidth;
    self.frame = frame;
}

- (float)bu_height {
    return self.frame.size.height;
}

- (void)setBu_height:(float)newHeight {
    CGRect frame = self.frame;
    frame.size.height = newHeight;
    self.frame = frame;
}

- (float)bu_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setBu_right:(float)newRight{
    CGRect frame = self.frame;
    frame.origin.x = newRight - frame.size.width;
    self.frame = frame;
}

- (float)bud_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBud_bottom:(float)bottom{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGSize)bud_size {
    return self.frame.size;
}

- (void)setBud_size:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGPoint)bu_origin {
    return self.frame.origin;
}

- (void)setBu_origin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGFloat)bu_centerX {
    return self.center.x;
}

- (void)setBu_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)bu_centerY {
    return self.center.y;
}

- (void)setBu_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (void)bu_setMaxRight:(CGFloat)maxRight {
    float maxWidth = maxRight - self.bu_left;
    if (maxWidth >= 0 && self.bu_width > maxWidth) {
        self.bu_width = maxWidth;
    }
}
- (UIViewController *)bu_viewController
{
    for (UIView *next = self.superview; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
@end
