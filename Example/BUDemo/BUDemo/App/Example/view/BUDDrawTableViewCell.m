//
//  BUDDrawAdTableViewCell.m
//  BUDemo
//
//  Created by iCuiCui on 2018/9/20.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDDrawTableViewCell.h"
#import "BUDPlayerController.h"
#import "BUDMacros.h"

#define GlobleHeight [UIScreen mainScreen].bounds.size.height
#define GlobleWidth [UIScreen mainScreen].bounds.size.width
#define inconWidth 45
#define inconEdge 15
#define bu_textEnde 5
#define bu_textColor BUD_RGB(0xf0, 0xf0, 0xf0)
#define bu_textFont 14

@interface BUDDrawBaseTableViewCell()
@property (nonatomic, strong, nullable) UIImageView *likeImg;
@property (nonatomic, strong, nullable) UILabel *likeLable;
@property (nonatomic, strong, nullable) UIImageView *commentImg;
@property (nonatomic, strong, nullable) UILabel *commentLable;
@property (nonatomic, strong, nullable) UIImageView *forwardImg;
@property (nonatomic, strong, nullable) UILabel *forwardLable;
@end

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
    self.titleLabel.textColor = bu_textColor;
    [self.contentView addSubview:self.titleLabel];
    
    self.descriptionLabel = [UILabel new];
    self.descriptionLabel.frame = CGRectMake(13, GlobleHeight-180+40, GlobleWidth-26, 50);
    self.descriptionLabel.font = [UIFont systemFontOfSize:16];
    self.descriptionLabel.numberOfLines = 0;
    self.descriptionLabel.textColor = bu_textColor;
    [self.contentView addSubview:self.descriptionLabel];
    
    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(GlobleWidth-inconWidth-13, GlobleHeight*0.3, inconWidth, inconWidth)];
    _headImg.image = [UIImage imageNamed:@"head"];
    _headImg.clipsToBounds = YES;
    _headImg.layer.cornerRadius = inconWidth/2;
    _headImg.layer.borderColor = bu_textColor.CGColor;
    _headImg.layer.borderWidth = 1;
    [self.contentView addSubview:_headImg];
    
    _likeImg = [[UIImageView alloc] initWithFrame:CGRectMake(GlobleWidth-inconWidth-13, _headImg.frame.origin.y + inconWidth + inconEdge, inconWidth, inconWidth)];
    _likeImg.image = [UIImage imageNamed:@"like"];
    [self.contentView addSubview:_likeImg];
    
    _likeLable = [[UILabel alloc] initWithFrame:CGRectMake(GlobleWidth-inconWidth-13, _likeImg.frame.origin.y + inconWidth + bu_textEnde, inconWidth, bu_textFont)];
    _likeLable.font = [UIFont systemFontOfSize:bu_textFont];
    _likeLable.textAlignment = NSTextAlignmentCenter;
    _likeLable.textColor = bu_textColor;
    _likeLable.text = @"21.4w";
    [self.contentView addSubview:_likeLable];
    
    _commentImg = [[UIImageView alloc] initWithFrame:CGRectMake(GlobleWidth-inconWidth-13, _likeLable.frame.origin.y + bu_textFont + inconEdge, inconWidth, inconWidth)];
    _commentImg.image = [UIImage imageNamed:@"comment"];
    [self.contentView addSubview:_commentImg];
    
    _commentLable = [[UILabel alloc] initWithFrame:CGRectMake(GlobleWidth-inconWidth-13, _commentImg.frame.origin.y + inconWidth + bu_textEnde, inconWidth, bu_textFont)];
    _commentLable.font = [UIFont systemFontOfSize:bu_textFont];
    _commentLable.textAlignment = NSTextAlignmentCenter;
    _commentLable.textColor = bu_textColor;
    _commentLable.text = @"3065";
    [self.contentView addSubview:_commentLable];
    
    _forwardImg = [[UIImageView alloc] initWithFrame:CGRectMake(GlobleWidth-inconWidth-13, _commentLable.frame.origin.y + bu_textFont + inconEdge, inconWidth, inconWidth)];
    _forwardImg.image = [UIImage imageNamed:@"forward"];
    [self.contentView addSubview:_forwardImg];
    
    _forwardLable = [[UILabel alloc] initWithFrame:CGRectMake(GlobleWidth-inconWidth-13, _forwardImg.frame.origin.y + inconWidth + bu_textEnde, inconWidth, bu_textFont)];
    _forwardLable.font = [UIFont systemFontOfSize:bu_textFont];
    _forwardLable.textAlignment = NSTextAlignmentCenter;
    _forwardLable.textColor = bu_textColor;
    _forwardLable.text = @"2.9w";
    [self.contentView addSubview:_forwardLable];
}

+ (CGFloat)cellHeight{
    return GlobleHeight;
}

@end

@interface BUDDrawNormalTableViewCell()
@property (nonatomic, strong)BUDPlayerController *player;
@end

@implementation BUDDrawNormalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)autoPlay {
    self.player = [self reuseInlinePlayer];
    NSString *resourceName = [NSString stringWithFormat:@"drawLocal_0%u",arc4random()%8];
    NSString *loacUrl = [[NSBundle mainBundle] pathForResource:resourceName ofType:@"mp4"];
    _player.contentURL = [NSURL fileURLWithPath:loacUrl];
    [_player play];
}

- (void)pause {
    [_player pause];
}

- (void)setPlayer:(BUDPlayerController *)player {
    _player = player;
    if (_player) {
        _player.view.frame = CGRectMake(0, 0, GlobleWidth, GlobleHeight);
        [self.contentView insertSubview:_player.view atIndex:0];
    }
}

- (BOOL)willDealloc {
    return NO;
}

- (BUDPlayerController *)reuseInlinePlayer {
    static BUDPlayerController* player = nil;
    if (!player) {
        player = [[BUDPlayerController alloc] init];
    }else{
        player.contentURL = nil;
        [player.view removeFromSuperview];
        [player pause];
    }
    return player;
}

-(void)refreshUIAtIndex:(NSUInteger)index{
    self.titleLabel.text = [NSString localizedStringWithFormat:[NSString localizedStringForKey:DrawTitle],(unsigned long)index];
    self.descriptionLabel.text = [NSString localizedStringForKey:DrawDescription];
    self.backgroundColor = [UIColor blackColor];
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
        [self.nativeAdRelatedView.videoAdView playerPlayIncon:[UIImage imageNamed:@"adPlay.png"] playInconSize:CGSizeMake(60, 60)];
        //Whether to support click pause
        self.nativeAdRelatedView.videoAdView.drawVideoClickEnable = YES;
        [self.contentView insertSubview:self.nativeAdRelatedView.videoAdView atIndex:0];
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
}

- (UIButton *)creativeButton{
    if (!_creativeButton) {
        _creativeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _creativeButton.accessibilityIdentifier = @"button";
        [_creativeButton setTitle:[NSString localizedStringForKey:Detail] forState:UIControlStateNormal];
        _creativeButton.backgroundColor = BUD_RGB(0x80,0xbb,0x41);
        _creativeButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _creativeButton;
}

-(void)refreshUIWithModel:(BUNativeAd *)model{
    self.titleLabel.text = model.data.AdTitle;
    self.descriptionLabel.text = model.data.AdDescription;
    [self.creativeButton setTitle:model.data.buttonText forState:UIControlStateNormal];
    [self.nativeAdRelatedView refreshData:model];
}

@end
