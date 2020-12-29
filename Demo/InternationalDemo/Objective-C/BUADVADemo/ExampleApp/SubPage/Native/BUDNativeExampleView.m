//
//  BUDNativeExampleView.m
//  BUADVADemo
//
//  Created by bytedance on 2020/11/11.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDNativeExampleView.h"

@interface BUDNativeExampleView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *customButton;
@property (nonatomic, strong) BUNativeAdRelatedView *nativeAdRelatedView;
@end

@implementation BUDNativeExampleView

- (void)setNativeAd:(BUNativeAd *)nativeAd {
    _nativeAd = nativeAd;
    
    _titleLabel.text = _nativeAd.data.AdTitle;
    _subTitleLabel.text = _nativeAd.data.AdDescription;
    [_customButton setTitle:_nativeAd.data.buttonText?:@"CustomButton" forState:UIControlStateNormal];
    
    _nativeAdRelatedView = [[BUNativeAdRelatedView alloc] init];
    [_nativeAdRelatedView refreshData:_nativeAd];
    if (_nativeAdRelatedView.videoAdView) {
        [self addVideoView];
    }
    ///add logo view
    [self addLogoView];
    ///dislike view
    [self addDislikeView];
    ///regist view
    [_nativeAd registerContainer:self withClickableViews:@[self.customButton]];
    ///load image
    __weak typeof(self) weakSelf = self;
    NSString *imageUrl = _nativeAd.data.imageAry.firstObject.imageURL;
    if (imageUrl) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:imageUrl] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (data) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakSelf.imageView.image = [UIImage imageWithData:data];
                    });
                }
            }];
            [task resume];
        });
    }
}
- (CGFloat)getHeight:(CGFloat)width {
    CGFloat height = 140;
    CGFloat scale = (_nativeAd.data.imageAry.firstObject.height?:0)/(_nativeAd.data.imageAry.firstObject.width?:1);
    return width*scale + height;
}
///ExampleUI
- (void)addVideoView {
    UIView *videoView = _nativeAdRelatedView.videoAdView;
    videoView.translatesAutoresizingMaskIntoConstraints = NO;
    [_imageView addSubview:videoView];
    [_imageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[videoView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(videoView)]];
    [_imageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[videoView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(videoView)]];
}
- (void)addLogoView {
    UIView *logo = _nativeAdRelatedView.logoADImageView;
    logo.translatesAutoresizingMaskIntoConstraints = NO;
    [_imageView addSubview:logo];
    [_imageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[logo(40)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(logo)]];
    [_imageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[logo(15)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(logo)]];
}
- (void)addDislikeView {
    UIButton *dislikeView = _nativeAdRelatedView.dislikeButton;
    dislikeView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:dislikeView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[dislikeView(20)]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(dislikeView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[dislikeView(20)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(dislikeView)]];
}

@end


