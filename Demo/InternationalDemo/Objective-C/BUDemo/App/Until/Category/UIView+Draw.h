//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

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

- (void)bud_removeAllSubViews;

@end
