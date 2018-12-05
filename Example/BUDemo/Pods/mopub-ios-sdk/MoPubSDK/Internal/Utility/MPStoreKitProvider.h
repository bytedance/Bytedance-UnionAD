//
//  MPStoreKitProvider.h
//
//  Copyright 2018 Twitter, Inc.
//  Licensed under the MoPub SDK License Agreement
//  http://www.mopub.com/legal/sdk-license-agreement/
//

#import <Foundation/Foundation.h>
#import "MPGlobal.h"
#import <StoreKit/StoreKit.h>

@class SKStoreProductViewController;

@interface MPStoreKitProvider : NSObject

+ (BOOL)deviceHasStoreKit;
+ (SKStoreProductViewController *)buildController;

@end

@protocol MPSKStoreProductViewControllerDelegate <SKStoreProductViewControllerDelegate>
@end
