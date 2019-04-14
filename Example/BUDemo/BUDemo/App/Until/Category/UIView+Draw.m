//
//  UIView+Draw.m
//  BUAdSDKDemo
//
//  Created by iCuiCui on 2018/10/28.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "UIView+Draw.h"

@implementation UIView (Draw)

- (BOOL)inScreen {
    if (!self) { return NO; }
    // If the view hidden
    UIView *currentNode = self;
    while (currentNode.superview != nil) {
        if (currentNode.hidden) {
            return NO;
        }
        currentNode = currentNode.superview;
    }
    
    // If no superview
    currentNode = self;
    while (currentNode.superview != nil) {
        currentNode = currentNode.superview;
    }
    if (![currentNode isKindOfClass:[UIWindow class]]) {
        return NO;
    }
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    

    CGRect rect = [self convertRect:self.bounds toView:[UIApplication sharedApplication].keyWindow];
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect)) {
        return NO;
    }
    
    // If the size is CGrectZero
    if (CGSizeEqualToSize(rect.size, CGSizeZero)) {
        return NO;
    }
    
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
