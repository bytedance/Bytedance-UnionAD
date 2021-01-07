//
//  BUDNativeBannerTableViewCell.h
//  BUDemo
//
//  Created by iCuiCui on 2018/11/5.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BUAdSDK/BUNativeAd.h>

NS_ASSUME_NONNULL_BEGIN
static CGFloat const bottomHeight = 30;

@interface BUDBannerModel : NSObject
@property (nonatomic,strong) BUNativeAd *nativeAd;
@property (nonatomic,assign) CGFloat imgeViewHeight;
- (instancetype)initWithNativeAd:(BUNativeAd *)nativeAd;
@end

@interface BUDNativeBannerTableViewCell : UITableViewCell
@property (nonatomic, strong) BUDBannerModel *bannerModel;
- (void)refreshUIWithModel:(BUDBannerModel *_Nonnull)model;
@end
NS_ASSUME_NONNULL_END
