//
//  BUMDStoreViewController.m
//  BUMDemo
//
//  Created by bytedance on 2021/10/20.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "BUMDStoreViewController.h"

@interface BUMDStoreViewController () <SKStoreProductViewControllerDelegate>

@property (nonatomic, copy) void(^complete)(void);

@end

@implementation BUMDStoreViewController
// id 1142110895

- (void)openAppStoreWithAppId:(NSString *)appId fromViewController:(UIViewController *)viewController complete:(void(^)(void))complete {
    if (appId.length == 0) return;
    self.complete = complete;
    SKStoreProductViewController *store = [[SKStoreProductViewController alloc] init];
    store.delegate = self;
    NSDictionary<NSString *, id> *parameters = @{SKStoreProductParameterITunesItemIdentifier: appId};
    
    [viewController presentViewController:store animated:YES completion:NULL];
    [store loadProductWithParameters:parameters completionBlock:^(BOOL result, NSError *error) {
        if (error) return;
        
    }];
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    [viewController dismissViewControllerAnimated:YES completion:NULL];
    self.complete ? self.complete() : (void *)0;
}

@end
