//
//  BUDSelectedCollectionViewCell.m
//  BUDemo
//
//  Created by Bytedance on 2019/12/2.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDSelectedCollectionViewCell.h"
#import "BUDMacros.h"

@interface BUDSelectedCollectionViewCell ()
@property(nonatomic,strong) UILabel *titleLable;
@end

@implementation BUDSelectedCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.titleLable];
        self.titleLable.frame = CGRectIntegral(CGRectMake(0, 0, frame.size.width, frame.size.height));
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        self.titleLable.textColor = mainColor;
        self.titleLable.font = [UIFont boldSystemFontOfSize:17];
    } else {
        self.titleLable.textColor = [UIColor blackColor];
        self.titleLable.font = [UIFont systemFontOfSize:16];

    }
}

- (void)refleshUIWithTitle:(NSString *)title {
    _titleLable.text = title;
}

#pragma mark getter && setter
- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [UILabel new];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.clipsToBounds = YES;
        _titleLable.layer.cornerRadius = 5;
        _titleLable.backgroundColor = BUD_RGB(0xf2, 0xf2, 0xf2);
        _titleLable.textColor = [UIColor blackColor];
        _titleLable.font = [UIFont systemFontOfSize:16];
    }
    return _titleLable;
}

@end
