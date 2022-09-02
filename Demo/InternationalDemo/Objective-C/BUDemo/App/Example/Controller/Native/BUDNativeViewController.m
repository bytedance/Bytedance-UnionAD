//
//  BUDNativeViewController.m
//  BUDemo
//
//  Created by Willie on 2022/4/24.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import <PAGAdSDK/PAGLNativeAd.h>
#import <PAGAdSDK/PAGNativeRequest.h>
#import <PAGAdSDK/PAGLNativeAdDelegate.h>
#import <PAGAdSDK/PAGLMaterialMeta.h>

#import "BUDNativeViewController.h"
#import "BUDSlotID.h"
#import "BUDNativeView.h"

@interface BUDNativeViewController () <PAGLNativeAdDelegate>

@property (nonatomic, strong) PAGLNativeAd *nativeAd;
@property (nonatomic, strong) BUDNativeView *nativeView;

@end

@implementation BUDNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.nativeView = [[BUDNativeView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 500)];
    [self.view addSubview:self.nativeView];
    
    __weak typeof(self) weakSelf = self;
    __weak typeof(BUDNativeView) *weakView = self.nativeView;
    [PAGLNativeAd loadAdWithSlotID:native_feed_ID
                           request:PAGNativeRequest.request
                 completionHandler:^(PAGLNativeAd * _Nullable nativeAd, NSError * _Nullable error) {

        if (!weakSelf) {
            return;
        }
        __strong typeof(weakSelf) self = weakSelf;

        if (error) {
            NSLog(@"native ad load fail : %@", error);
            return;
        }
        
        self.nativeAd = nativeAd;
        [weakView refreshWithNativeAd:nativeAd];
        
        UIButton *customButton = [UIButton buttonWithType:UIButtonTypeSystem];
        customButton.frame = CGRectMake(self.view.frame.size.width - 80, 480, 70, 20);
        [customButton setTitle:@"see more" forState:UIControlStateNormal];
        [weakView addSubview:customButton];
        
        nativeAd.rootViewController = self;
        nativeAd.delegate = self;
        [nativeAd registerContainer:weakView withClickableViews:@[customButton]];
    }];
}

#pragma mark - PAGLNativeAdDelegate

- (void)adDidShow:(id<PAGAdProtocol>)ad {
    
}

- (void)adDidClick:(id<PAGAdProtocol>)ad {
    
}

- (void)adDidDismiss:(id<PAGAdProtocol>)ad {
    self.nativeAd = nil;
    [self.nativeView removeFromSuperview];
    self.nativeView = nil;
}

@end
