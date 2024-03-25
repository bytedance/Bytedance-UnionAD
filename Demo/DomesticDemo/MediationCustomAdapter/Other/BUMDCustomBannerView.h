//
//  BUMDCustomBannerView.h
//  BUMDemo
//
//  Created by bytedance on 2021/10/20.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUMDCustomBannerView : UIButton

@property (nonatomic, copy) void(^didMoveToSuperViewCallback)(BUMDCustomBannerView *view);

@property (nonatomic, copy) void(^closeAction)(BUMDCustomBannerView *view);

@end

NS_ASSUME_NONNULL_END
