//
//  BUDAppOpenAdManager.h
//  BUDemo
//
//  Created by bytedance on 2022/1/17.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BUDAppOpenAdManagerDelegate <NSObject>

//Method to be invoked when an app open ad load complete
- (void)adloadComplete:(nullable NSError *)error;

@end

@interface BUDAppOpenAdManager : NSObject

@property (nonatomic, weak) id<BUDAppOpenAdManagerDelegate> _Nullable delegate;

+ (nonnull BUDAppOpenAdManager *)sharedInstance;
- (void)loadAdWithSlotId:(nonnull NSString *)slotId;
- (void)showAdIfAvailable:(nonnull UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
