//
//  UIView+Draw.m
//  BUAdSDKDemo
//
//  Created by iCuiCui on 2018/10/28.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "UIView+Draw.h"

@implementation UIView (Draw)

- (bool)inScreen {
    if (!self) { return NO; }
    // 若view隐藏
    UIView *currentNode = self;
    while (currentNode.superview != nil) {
        if (currentNode.hidden) {
            return NO;
        }
        currentNode = currentNode.superview;
    }
    
    // 若没有superview
    currentNode = self;
    while (currentNode.superview != nil) {
        currentNode = currentNode.superview;
    }
    if (![currentNode isKindOfClass:[UIWindow class]]) {
        return NO;
    }
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    // 转换view对应window的Rect
    CGRect rect = [self convertRect:self.bounds toView:[UIApplication sharedApplication].keyWindow];
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect)) {
        return NO;
    }
    
    // 若size为CGrectZero
    if (CGSizeEqualToSize(rect.size, CGSizeZero)) {
        return NO;
    }
    
    // 获取view与window交叉的Rect
    CGRect intersectionRect = CGRectIntersection(rect, screenRect);
    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)) {
        return NO;
    }
    
    return YES;
}

- (CGFloat)left { return self.frame.origin.x; }
- (CGFloat)right { return CGRectGetMaxX(self.frame); }
- (CGFloat)top { return self.frame.origin.y; }
- (CGFloat)bottom { return CGRectGetMaxY(self.frame); }
- (CGPoint)origin { return self.frame.origin; }

- (CGFloat)width { return self.frame.size.width; }
- (CGFloat)height { return self.frame.size.height; }
- (CGSize)size { return self.frame.size; }

@end
