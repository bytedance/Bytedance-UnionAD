//
//  BUMDStoreViewController.h
//  BUMDemo
//
//  Created by bytedance on 2021/10/20.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUMDStoreViewController : SKStoreProductViewController

- (void)openAppStoreWithAppId:(NSString *)appId fromViewController:(UIViewController *)viewController complete:(void(^)(void))complete;

@end

NS_ASSUME_NONNULL_END
