//
//  BUDdemoDislikeCollectionCell.m
//  BUDemo
//
//  Created by iCuiCui on 2018/12/18.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDdemoDislikeCollectionCell.h"
#import "BUDMacros.h"

static CGSize const nextImgSize = {20, 20};

@interface BUDdemoDislikeCollectionCell()
@property(nonatomic,strong) UILabel *titleLable;
@property(nonatomic,strong) UIImageView *nextImg;
@end
@implementation BUDdemoDislikeCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createItems];
    }
    return self;
}

- (void)createItems {
    _titleLable = [UILabel new];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    _titleLable.frame = CGRectMake(10, 10, (width-2*margin)/2-20, 40);
    _titleLable.userInteractionEnabled = NO;
    _titleLable.font = [UIFont systemFontOfSize:14];
    _titleLable.textAlignment = NSTextAlignmentCenter;
    _titleLable.clipsToBounds = YES;
    _titleLable.layer.cornerRadius = 20;
    _titleLable.layer.borderWidth = 0.5;
    _titleLable.layer.borderColor = BUD_RGB(0xd2, 0xd2, 0xd2).CGColor;
    _titleLable.backgroundColor = BUD_RGB(0xf2, 0xf2, 0xf2);
    [self addSubview:_titleLable];
    
    _nextImg = [[UIImageView alloc] init];
    _nextImg.image = [UIImage imageNamed:@"nextDislike.png"];
    [self addSubview:_nextImg];
}

- (void)refleshUIWithModel:(BUDislikeWords *)dislikeWord {
    self.nextImg.frame = CGRectMake(self.bounds.size.width-nextImgSize.width-13, (self.bounds.size.height-nextImgSize.height)/2, nextImgSize.width, nextImgSize.height);
    self.titleLable.text = dislikeWord.name;
    //whether to show the secondary pages
    self.nextImg.hidden = dislikeWord.options.count?NO:YES;
}
@end
