//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#import <UIKit/UIKit.h>
#import <BUAdSDK/BUAdSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUDCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) BUNativeAdRelatedView *relatedView;

- (void)setNativeAd:(BUNativeAd *)nativeAd;

@end

NS_ASSUME_NONNULL_END
