//
//  BUMDDrawAdView.h
//  BUMDemo
//
//  Created by ByteDance on 2022/10/30.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BUAdSDK/BUAdSDK.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^CellClose)(NSInteger index);

@protocol BUMDDrawAdViewProtocol <NSObject>

@property (nonatomic, strong) UIButton *customBtn;
@property (nonatomic, strong) BUNativeAd *drawAdView;

- (void)refreshUIWithModel:(BUNativeAd *_Nonnull)model;

@property (nonatomic, copy) CellClose cellClose;

@end

@interface BUMDDrawAdView : UIView <BUMDDrawAdViewProtocol>

@property (nonatomic, strong, nullable) UIView *separatorLine;
@property (nonatomic, strong) BUNativeAd *drawAdView;
@property (nonatomic, strong) UIButton *customBtn;

- (void)buildupView;

@end

@interface BUMDDrawVideoAdView : BUMDDrawAdView
/**
 Creative button which is usede by video ad, need to actively add to the view, and register the view for user click.
 */
@property (nonatomic, strong, nullable) UIButton *creativeButton;
@property (nonatomic, strong) UIView *bgView;

@end

NS_ASSUME_NONNULL_END

