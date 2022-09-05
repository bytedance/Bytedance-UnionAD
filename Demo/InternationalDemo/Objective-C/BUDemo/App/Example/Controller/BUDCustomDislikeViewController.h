//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#import <UIKit/UIKit.h>
#import <BUAdSDK/BUAdSDK.h>
NS_ASSUME_NONNULL_BEGIN
@class BUNativeAd;

@class BUDCustomDislikeViewController;
@protocol BUDCustomDislikeDelegate <NSObject>

- (void)customDislike:(BUDCustomDislikeViewController *)controller withNativeAd:(BUNativeAd *)nativeAd didSelected:(BUDislikeWords *)dislikeWorkd;


@end

@interface BUDCustomDislikeViewController : UIViewController

@property (nonatomic, weak) id<BUDCustomDislikeDelegate> delegate;


- (instancetype)initWithNativeAd:(BUNativeAd *)nativeAd;

@end
NS_ASSUME_NONNULL_END
