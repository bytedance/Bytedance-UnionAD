//
//  BUDDrawAdTableViewCell.m
//  BUDemo
//
//  Created by 崔亚楠 on 2018/9/20.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDDrawTableViewCell.h"
#define GlobleHeight [UIScreen mainScreen].bounds.size.height
#define GlobleWidth [UIScreen mainScreen].bounds.size.width
#define random(r, g, b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256),0.1)

@implementation BUDDrawBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self buildupView];
    }
    return self;
}

- (void)buildupView {
    self.titleLabel = [UILabel new];
    self.titleLabel.frame = CGRectMake(13, GlobleHeight-180, GlobleWidth-26, 30);
    self.titleLabel.font = [UIFont boldSystemFontOfSize:19];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.titleLabel];
    
    self.descriptionLabel = [UILabel new];
    self.descriptionLabel.frame = CGRectMake(13, GlobleHeight-180+40, GlobleWidth-26, 50);
    self.descriptionLabel.font = [UIFont systemFontOfSize:13];
    self.descriptionLabel.numberOfLines = 0;
    [self.contentView addSubview:self.descriptionLabel];
}

+ (CGFloat)cellHeight{
    return GlobleHeight;
}

@end

@implementation BUDDrawNormalTableViewCell

-(void)refreshUIAtIndex:(NSUInteger)index{
    self.titleLabel.textColor = [UIColor blackColor];
    self.descriptionLabel.textColor = [UIColor blackColor];
    self.titleLabel.text = [NSString stringWithFormat:@"第 【%lu】 页，[Draw]模拟视频标题",(unsigned long)index];
    self.descriptionLabel.text = @"沉浸式视频，超强体验，你值得拥有。沉浸式视频，超强体验，你值得拥有。沉浸式视频，超强体验，你值得拥有。沉浸式视频，超强体验，你值得拥有。";
    self.backgroundColor = randomColor;
}

@end

@implementation BUDDrawAdTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self buildupVideoView];
    }
    return self;
}

- (void)buildupVideoView{
    self.nativeAdRelatedView = [[BUNativeAdRelatedView alloc] init];
    
    if (!self.nativeAdRelatedView.videoAdView.superview) {
        self.nativeAdRelatedView.videoAdView.frame = CGRectMake(0, 0, GlobleWidth, GlobleHeight);
        [self.nativeAdRelatedView.videoAdView playerPlayIncon:[UIImage imageNamed:@"adPlay.png"] playInconSize:CGSizeMake(80, 80)];
        //更改视频是否可以点击暂停
        self.nativeAdRelatedView.videoAdView.drawVideoClickEnable = YES;
        [self.contentView addSubview:self.nativeAdRelatedView.videoAdView];
    }
    
    if (!self.nativeAdRelatedView.adLabel.superview) {
        self.nativeAdRelatedView.adLabel.frame = CGRectMake(13, GlobleHeight-180-30, 30, 16);
        [self.contentView addSubview:self.nativeAdRelatedView.adLabel];
    }
    
    if (self.creativeButton && !self.creativeButton.superview) {
        self.creativeButton.frame = CGRectMake(15, GlobleHeight-80, GlobleWidth-30, 40);
        [self.creativeButton.layer setCornerRadius:3];
        [self.contentView addSubview:self.creativeButton];
    }
    
    [self.contentView bringSubviewToFront:self.titleLabel];
    [self.contentView bringSubviewToFront:self.descriptionLabel];
}

- (UIButton *)creativeButton{
    if (!_creativeButton) {
        _creativeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_creativeButton setTitle:@"查看详情 >" forState:UIControlStateNormal];
        _creativeButton.tintColor = [UIColor darkGrayColor];
        _creativeButton.backgroundColor = random(0x80,0xbb,0x41,1);
        _creativeButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _creativeButton;
}

-(void)refreshUIWithModel:(BUNativeAd *)model{
    self.titleLabel.textColor = [UIColor whiteColor];
    self.descriptionLabel.textColor = [UIColor whiteColor];
    self.titleLabel.text = model.data.AdTitle;
    self.descriptionLabel.text = model.data.AdDescription;
    [self.creativeButton setTitle:model.data.buttonText forState:UIControlStateNormal];
    [self.nativeAdRelatedView refreshData:model];
}

@end
