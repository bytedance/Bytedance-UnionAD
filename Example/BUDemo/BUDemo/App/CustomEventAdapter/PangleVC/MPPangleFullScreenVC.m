//
//  MPPangleFullScreenVC.m
//  BUDemo
//
//  Created by wangyanlin on 2020/5/20.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "MPPangleFullScreenVC.h"
#import <mopub-ios-sdk/MPInterstitialAdController.h>
#import "BUDNormalButton.h"
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import "NSString+LocalizedString.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "BUDSelectedView.h"


/*
 The corresponding adapter class is shown in the corresponding table of the BUDSlotID class.
 对应的adapter类参见BUDSlotID类的对应表
 */
@interface MPPangleFullScreenVC () <MPInterstitialAdControllerDelegate>
@property (nonatomic, strong) MPInterstitialAdController *interstitial;
@property (nonatomic, strong) BUDSelectedView *selectedView;

@end

@implementation MPPangleFullScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    BUDSelcetedItem *item1 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":normal_fullscreen_ID,@"title":[NSString localizedStringForKey:Vertical]}];
    BUDSelcetedItem *item2 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":normal_fullscreen_landscape_ID,@"title":[NSString localizedStringForKey:Horizontal]}];
    NSArray *titlesAndIDS = @[@[item1,item2]];

    __weak typeof(self) weakself = self;
    self.selectedView = [[BUDSelectedView alloc] initWithAdName:@"FullScreenVideo Ad" SelectedTitlesAndIDS:titlesAndIDS loadAdAction:^(NSString * _Nullable slotId) {
          __strong typeof(self) strongself = weakself;
          [strongself loadFullscreenVideoAdWithSlotID:slotId];
    } showAdAction:^{
        __strong typeof(self) strongself = weakself;
        strongself.selectedView.promptStatus = BUDPromptStatusDefault;
        if (strongself.interstitial.ready) {
          [strongself.interstitial showFromViewController:self];
        }
    }];
    [self.view addSubview:self.selectedView];
    self.selectedView.promptStatus = BUDPromptStatusDefault;
}

- (void)loadFullscreenVideoAdWithSlotID:(NSString *)slotId {
    // Instantiate the interstitial using the class convenience method.
    self.interstitial = [MPInterstitialAdController
                         interstitialAdControllerForAdUnitId:mopub_official_intersttitial_UnitID];
    self.interstitial.localExtras = @{@"ad_placement_id":slotId};
    self.interstitial.delegate = self;
    [self.interstitial loadAd];
}

#pragma mark 延迟加载

#pragma mark - MPInterstitialAdControllerDelegate
- (void)interstitialDidLoadAd:(MPInterstitialAdController *)interstitial {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.offset = CGPointMake(0, -100);
    hud.label.text = @"fullscreen data load success";
    [hud hideAnimated:YES afterDelay:2];
    self.selectedView.promptStatus = BUDPromptStatusAdLoaded;
    BUD_Log(@"%s", __func__);
}

- (void)interstitialDidFailToLoadAd:(MPInterstitialAdController *)interstitial
                          withError:(NSError *)error {
    BUD_Log(@"%s", __func__);
}

- (void)interstitialWillAppear:(MPInterstitialAdController *)interstitial {
    BUD_Log(@"%s", __func__);
}

- (void)interstitialDidAppear:(MPInterstitialAdController *)interstitial {
    BUD_Log(@"%s", __func__);
}

- (void)interstitialWillDisappear:(MPInterstitialAdController *)interstitial {
    BUD_Log(@"%s", __func__);
}

- (void)interstitialDidDisappear:(MPInterstitialAdController *)interstitial {
    BUD_Log(@"%s", __func__);
}

- (void)interstitialDidExpire:(MPInterstitialAdController *)interstitial {
    BUD_Log(@"%s", __func__);
}

- (void)interstitialDidReceiveTapEvent:(MPInterstitialAdController *)interstitial {
    BUD_Log(@"%s", __func__);
}

@end

