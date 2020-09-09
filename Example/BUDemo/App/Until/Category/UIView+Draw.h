//
//  UIView+Draw.h
//  BUAdSDKDemo
//
//  Created by iCuiCui on 2018/10/28.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Draw)
- (BOOL)inScreen;
- (CGFloat)left;
- (CGFloat)right;
- (CGFloat)top;
- (CGFloat)bottom;
- (CGPoint)origin;

- (CGFloat)width;
- (CGFloat)height;
- (CGSize)size;
@end
