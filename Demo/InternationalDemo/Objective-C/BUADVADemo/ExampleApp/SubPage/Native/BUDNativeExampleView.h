//
//  BUDNativeExampleView.h
//  BUADVADemo
//
//  Created by bytedance on 2020/11/11.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BUAdSDK/BUAdSDK.h>
NS_ASSUME_NONNULL_BEGIN

@interface BUDNativeExampleView : UIView
@property (nonatomic, strong) BUNativeAd *nativeAd;
- (CGFloat)getHeight:(CGFloat)width;
@end

NS_ASSUME_NONNULL_END
