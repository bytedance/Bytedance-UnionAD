//
//  BUDSettingTableView.m
//  BUDemo
//
//  Created by iCuiCui on 2018/11/2.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDSettingTableView.h"

@implementation BUDSettingTableView
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    id view = [super hitTest:point withEvent:event];
    if (![view isKindOfClass:[UITextField class]]) {
        [self.superview endEditing:YES];
    }
    return view;
}
@end
