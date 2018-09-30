//
//  BUAFeedAdCell.m
//  BUAemo
//
//  Created by carlliu on 2017/7/27.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import "BUAFeedAdTableViewCell.h"

#import "UIImageView+WMNetWorking.h"
#import "BUAFeedStyleHelper.h"

static CGFloat const margin = 15;
static UIEdgeInsets const padding = {10, 15,10,15};

@implementation BUAFeedAdBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self buildupView];
    }
    return self;
}

- (void)buildupView {
    CGFloat swidth = [[UIScreen mainScreen] bounds].size.width;
    self.iv1 = [[UIImageView alloc] initWithFrame:CGRectMake(swidth - 130, 10, 120, 130)];
    self.iv1.userInteractionEnabled = YES;
    [self.contentView addSubview:self.iv1];
    
    self.adTitleLabel = [UILabel new];
    self.adTitleLabel.numberOfLines = 0;
    self.adTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.adTitleLabel];
    
    [self.contentView addSubview:self.adLabel];
    
    self.adDescriptionLabel = [UILabel new];
    self.adDescriptionLabel.numberOfLines = 0;
    [self.contentView addSubview:self.adDescriptionLabel];
    
    [self.contentView addSubview:self.dislikeButton];
}

+ (CGFloat)cellHeightWithModel:(id)model width:(CGFloat)width {
    return 0;
}

- (void)refreshUIWithModel:(id)model {
    self.materialMeta = model;
}

@end

@implementation BUAFeedAdLeftTableViewCell

- (void)refreshUIWithModel:(WMMaterialMeta *)model {
    [super refreshUIWithModel:model];
    
    CGFloat width = CGRectGetWidth(self.contentView.bounds);
    CGFloat contentWidth = (width - 2 * margin);
    CGFloat y = padding.top;
    
    WMImage *image = model.imageAry.firstObject;
    const CGFloat imageWidth = (width - 2 * margin) / 3;
    const CGFloat imageHeight = imageWidth * (image.height / image.width);
    CGFloat imageX = width - margin - imageWidth;
    self.iv1.frame = CGRectMake(imageX, y, imageWidth, imageHeight);
    [self.iv1 setImageWithURL:[NSURL URLWithString:image.imageURL] placeholderImage:nil];
    
    CGFloat maxTitleWidth =  contentWidth - imageWidth - margin;
    NSAttributedString *attributedText = [BUAFeedStyleHelper titleAttributeText:model.AdTitle];
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(maxTitleWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;
    self.adTitleLabel.frame = CGRectMake(padding.left, y , maxTitleWidth, MIN(titleSize.height, imageHeight));
    self.adTitleLabel.attributedText = attributedText;
    
    y += imageHeight;
    y += 5;
    
    CGFloat originInfoX = padding.left;
    self.adLabel.frame = CGRectMake(originInfoX, y + 3, 26, 14);
    originInfoX += 24;
    originInfoX += 5;
    
    CGFloat dislikeX = width - 24 - padding.right;
    self.dislikeButton.frame = CGRectMake(dislikeX, y, 24, 20);
    
    CGFloat maxInfoWidth = width - 2 * margin - 24 - 24 - 10;
    self.adDescriptionLabel.frame = CGRectMake(originInfoX , y , maxInfoWidth, 20);
    self.adDescriptionLabel.attributedText = [BUAFeedStyleHelper subtitleAttributeText:model.AdDescription];
}

+ (CGFloat)cellHeightWithModel:(WMMaterialMeta *)model width:(CGFloat)width {
    WMImage *image = model.imageAry.firstObject;
    const CGFloat contentWidth = (width - 2 * margin) / 3;
    const CGFloat imageHeight = contentWidth * (image.height / image.width);
    return padding.top + imageHeight + 10 + 20 + padding.bottom;
}

@end

@implementation BUAFeedAdLargeTableViewCell

- (void)refreshUIWithModel:(WMMaterialMeta *)model {
    [super refreshUIWithModel:model];
    
    CGFloat width = CGRectGetWidth(self.contentView.bounds);
    CGFloat contentWidth = (width - 2 * margin);
    CGFloat y = padding.top;
    
    NSAttributedString *attributedText = [BUAFeedStyleHelper titleAttributeText:model.AdTitle];
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;
    self.adTitleLabel.frame = CGRectMake(padding.left, y , contentWidth, titleSize.height);
    self.adTitleLabel.attributedText = attributedText;
    
    y += titleSize.height;
    y += 5;
    
    WMImage *image = model.imageAry.firstObject;
    const CGFloat imageHeight = contentWidth * (image.height / image.width);
    self.iv1.frame = CGRectMake(padding.left, y, contentWidth, imageHeight);
    [self.iv1 setImageWithURL:[NSURL URLWithString:image.imageURL] placeholderImage:nil];
    
    y += imageHeight;
    y += 5;
    
    CGFloat originInfoX = padding.left;
    self.adLabel.frame = CGRectMake(originInfoX, y + 3, 26, 14);
    originInfoX += 24;
    originInfoX += 5;
    
    CGFloat dislikeX = width - 24 - padding.right;
    self.dislikeButton.frame = CGRectMake(dislikeX, y, 24, 20);
    
    CGFloat maxInfoWidth = width - 2 * margin - 24 - 24 - 10;
    self.adDescriptionLabel.frame = CGRectMake(originInfoX , y , maxInfoWidth, 20);
    self.adDescriptionLabel.attributedText = [BUAFeedStyleHelper subtitleAttributeText:model.AdDescription];
}

+ (CGFloat)cellHeightWithModel:(WMMaterialMeta *)model width:(CGFloat)width {
    CGFloat contentWidth = (width - 2 * margin);
    NSAttributedString *attributedText = [BUAFeedStyleHelper titleAttributeText:model.AdTitle];
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;
    
    WMImage *image = model.imageAry.firstObject;
    const CGFloat imageHeight = contentWidth * (image.height / image.width);
    return padding.top + titleSize.height + 5+ imageHeight + 5 + 20 + padding.bottom;
}


@end

@implementation BUAFeedAdGroupTableViewCell

- (void)buildupView {
    [super buildupView];
    self.iv1 = [UIImageView new];
    [self addSubview:self.iv1];
    
    self.iv2 = [UIImageView new];
    [self addSubview:self.iv2];
    self.iv3 = [UIImageView new];
    [self addSubview:self.iv3];
    
    self.actionView = [BUAActionAreaView new];
    
    [self addSubview:self.actionView];
}

- (void)refreshUIWithModel:(WMMaterialMeta *)model {
    [super refreshUIWithModel:model];
    
    CGFloat width = CGRectGetWidth(self.contentView.bounds);
    CGFloat contentWidth = (width - 2 * margin);
    CGFloat y = padding.top;
    
    NSAttributedString *attributedText = [BUAFeedStyleHelper titleAttributeText:model.AdTitle];
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;
    self.adTitleLabel.frame = CGRectMake(padding.left, y , contentWidth, titleSize.height);
    self.adTitleLabel.attributedText = attributedText;
    
    y += titleSize.height;
    y += 5;
    
    CGFloat imageWidth = (contentWidth - 2 * 2) / 3;
    WMImage *image = model.imageAry[0];
    const CGFloat imageHeight = imageWidth * (image.height / image.width);
    
    CGFloat originX = padding.left;
    self.iv1.frame = CGRectMake(originX, y, imageWidth, imageHeight);
    [self.iv1 setImageWithURL:[NSURL URLWithString: model.imageAry[0].imageURL] placeholderImage:nil];
    originX += (imageWidth + 2);
    self.iv2.frame = CGRectMake(originX, y, imageWidth, imageHeight);
    [self.iv2 setImageWithURL:[NSURL URLWithString: model.imageAry[1].imageURL] placeholderImage:nil];
    originX += (imageWidth + 2);
    self.iv3.frame = CGRectMake(originX, y, imageWidth, imageHeight);
    [self.iv3 setImageWithURL:[NSURL URLWithString: model.imageAry[2].imageURL] placeholderImage:nil];
    
    y += imageHeight;
    y += 5;
    
    // action
    if (model.interactionType == WMInteractionTypeDownload) {
        [self.actionView configWitModel:model];
        self.actionView.frame = CGRectMake(padding.left, y, contentWidth, 28);
        y += 28;
        y += 5;
    }
    // info
    CGFloat originInfoX = padding.left;
    self.adLabel.frame = CGRectMake(originInfoX, y + 3, 26, 14);
    originInfoX += 24;
    originInfoX += 5;
    
    CGFloat dislikeX = width - 24 - padding.right;
    self.dislikeButton.frame = CGRectMake(dislikeX, y, 24, 20);
    
    CGFloat maxInfoWidth = width - 2 * margin - 24 - 24 - 10;
    self.adDescriptionLabel.frame = CGRectMake(originInfoX , y , maxInfoWidth, 20);
    self.adDescriptionLabel.attributedText = [BUAFeedStyleHelper subtitleAttributeText:model.AdDescription];
}

+ (CGFloat)cellHeightWithModel:(WMMaterialMeta *)model width:(CGFloat)width {
    CGFloat height = padding.top;
    WMImage *image = model.imageAry.firstObject;
    const CGFloat contentWidth = (width - 2 * margin) / 3;
    const CGFloat imageHeight = contentWidth * (image.height / image.width);
    height += 17 + 5+ imageHeight + 5 + 20;
    height += padding.bottom;
    if (model.interactionType == WMInteractionTypeDownload) {
        height += 28 +5;
    }
    return height;
}

@end

// 视频广告 cell
@interface BUAFeedVideoAdTableViewCell ()

@end

@implementation BUAFeedVideoAdTableViewCell

- (void)buildupView {
    [super buildupView];
    [self addSubview:self.videoAdView];
    [self addSubview:self.creativeButton];
}

- (void)refreshUIWithModel:(WMMaterialMeta *)model {
    [super refreshUIWithModel:model];
    
    CGFloat width = CGRectGetWidth(self.contentView.bounds);
    CGFloat contentWidth = (width - 2 * margin);
    CGFloat y = padding.top;
    
    NSAttributedString *attributedText = [BUAFeedStyleHelper titleAttributeText:model.AdTitle];
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;
    self.adTitleLabel.frame = CGRectMake(padding.left, y , contentWidth, titleSize.height);
    self.adTitleLabel.attributedText = attributedText;
    
    y += titleSize.height;
    y += 5;
    
    // 广告展位图
    WMImage *image = model.imageAry.firstObject;
    const CGFloat imageHeight = contentWidth * (image.height / image.width);
    self.videoAdView.materialMeta = self.materialMeta;
    self.videoAdView.frame = CGRectMake(padding.left, y, contentWidth, imageHeight);
    
    y += imageHeight;
    y += 5;
    
    // 创意按钮
    [self.creativeButton setTitle:self.materialMeta.buttonText forState:UIControlStateNormal];
    [self.creativeButton sizeToFit];
    CGSize buttonSize = self.creativeButton.frame.size;
    self.creativeButton.frame = CGRectMake(contentWidth - buttonSize.width + padding.left, y, buttonSize.width, buttonSize.height);
    // 创意按钮结束
    
    // source
    CGFloat maxInfoWidth = width - 2 * margin - buttonSize.width - 10;
    self.adDescriptionLabel.frame = CGRectMake(padding.left , y , maxInfoWidth, 20);
    self.adDescriptionLabel.attributedText = [BUAFeedStyleHelper subtitleAttributeText:model.AdDescription];
    y += buttonSize.height;
    
    CGFloat originInfoX = padding.left;
    self.adLabel.frame = CGRectMake(originInfoX, y + 3, 26, 14);
    originInfoX += 24;
    originInfoX += 5;
    
    CGFloat dislikeX = width - 24 - padding.right;
    self.dislikeButton.frame = CGRectMake(dislikeX, y, 24, 20);
}

+ (CGFloat)cellHeightWithModel:(WMMaterialMeta *)model width:(CGFloat)width {
    CGFloat contentWidth = (width - 2 * margin);
    NSAttributedString *attributedText = [BUAFeedStyleHelper titleAttributeText:model.AdTitle];
    
    CGSize titleSize = [attributedText boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:0].size;
    
    WMImage *image = model.imageAry.firstObject;
    const CGFloat imageHeight = contentWidth * (image.height / image.width);
    return padding.top + titleSize.height + 5+ imageHeight + 5 + 20 + padding.bottom + 28;
}

- (UIButton *)creativeButton
{
    if (!_creativeButton) {
        _creativeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_creativeButton setTitle:self.materialMeta.buttonText forState:UIControlStateNormal];
        [_creativeButton setContentEdgeInsets:UIEdgeInsetsMake(4.0, 8.0, 4.0, 8.0)];
        [_creativeButton setTitleColor:[UIColor colorWithRed:0.165 green:0.565 blue:0.843 alpha:1] forState:UIControlStateNormal];
        _creativeButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_creativeButton sizeToFit];
        _creativeButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        _creativeButton.clipsToBounds = YES;
        [_creativeButton.layer setBorderColor:[UIColor colorWithRed:0.165 green:0.565 blue:0.843 alpha:1].CGColor];
        [_creativeButton.layer setBorderWidth:1];
        [_creativeButton.layer setCornerRadius:6];
        [_creativeButton.layer setShadowRadius:3];
    }
    return _creativeButton;
}

@end
