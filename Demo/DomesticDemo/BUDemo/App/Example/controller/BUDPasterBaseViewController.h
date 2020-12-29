//
//  BUDPasterBaseViewController.h
//  BUDemo
//
//  Created by bytedance on 2020/10/28.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUDBaseExampleViewController.h"
#import "BUDVideoView.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BUDPasterPlayerStyle) {
    BUDPasterPlayerStyleCustom = 0,
    BUDPasterPlayerStylePangle = 1
};

@class BUNativeAd;
@class BUDPasterContentView;

@interface BUDPasterBaseViewController : BUDBaseExampleViewController

@property (nonatomic, strong) NSMutableArray<BUNativeAd *> *currentAds;

@property (nonatomic, strong) NSMutableArray<BUDPasterContentView *> *adViews;

@property (nonatomic, assign) NSInteger currentAdIndex;

- (void)reportPangleWithStatus:(BUDVideoViewStatus)status;
- (BUDPasterPlayerStyle)playerStyle;
@end

NS_ASSUME_NONNULL_END
