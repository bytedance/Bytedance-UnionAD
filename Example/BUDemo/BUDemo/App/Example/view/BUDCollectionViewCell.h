//
//  BUDCollectionViewCell.h
//  BUDemo
//
//  Created by 李盛 on 2019/3/1.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BUAdSDK/BUNativeAdRelatedView.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUDCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) BUNativeAdRelatedView *relatedView;

- (void)setNativeAd:(BUNativeAd *)nativeAd;

@end

NS_ASSUME_NONNULL_END
