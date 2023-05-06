//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#import "BUDActionAreaView.h"
#import "NSString+LocalizedString.h"

@implementation BUDActionAreaView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buildupView];
    }
    return self;
}

- (void)configWitModel:(id)model {
    self.subTitleLabel.text = [NSString localizedStringForKey:TestDescription];
    [self.actionButton setTitle:[NSString localizedStringForKey:Download] forState:UIControlStateNormal];
    [self.actionButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    self.actionButton.frame = CGRectMake(width - 100 - 5, 0, 100, height);
    self.subTitleLabel.frame = CGRectMake(0, 0, width - 100 - 5, height);
}

- (void)buildupView {
    self.subTitleLabel = [UILabel new];
    [self addSubview:self.subTitleLabel];
    self.actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.actionButton];
}

@end
