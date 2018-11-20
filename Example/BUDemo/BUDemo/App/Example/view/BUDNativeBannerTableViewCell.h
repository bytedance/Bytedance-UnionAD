//
//  BUDNativeBannerTableViewCell.h
//  BUDemo
//
//  Created by iCuiCui on 2018/11/5.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BUAdSDK/BUNativeAd.h>

@interface BUDNativeBannerTableViewCell : UITableViewCell
@property (nonatomic, strong) BUNativeAd *nativeAd;
- (void)refreshUIWithModel:(BUNativeAd *_Nonnull)model;
@end
