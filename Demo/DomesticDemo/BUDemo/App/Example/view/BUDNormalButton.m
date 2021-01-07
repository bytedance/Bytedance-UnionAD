//
//  BUDNormalButton.m
//  BUDemo
//
//  Created by iCuiCui on 2018/11/1.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDNormalButton.h"
#import "BUDMacros.h"
#define buttonHeight 40
#define leftEdge 30

@implementation BUDNormalButton
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(leftEdge, frame.origin.y, BUDMINScreenSide-2*leftEdge, buttonHeight)];
    if (self) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setBackgroundColor:mainColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 5;
    }
    return self;
}

-(void)setShowRefreshIncon:(BOOL)showRefreshIncon {
    _showRefreshIncon = showRefreshIncon;
    if (showRefreshIncon) {
        [self setImage:[UIImage imageNamed:@"shuaxin.png"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"shuaxin.png"] forState:UIControlStateHighlighted];
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
    }
}

- (void)setIsValid:(BOOL)isValid {
    _isValid = isValid;
    self.enabled = isValid;
    if (isValid) {
        [self setBackgroundColor:mainColor];
    } else {
        [self setBackgroundColor:unValidColor];
    }
}
@end
