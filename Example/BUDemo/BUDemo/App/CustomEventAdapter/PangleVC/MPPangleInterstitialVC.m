//
//  MPPangleInterstitialVC.m
//  BUDemo
//
//  Created by wangyanlin on 2020/5/19.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "MPPangleInterstitialVC.h"
#import <mopub-ios-sdk/MPInterstitialAdController.h>
#import "BUDNormalButton.h"
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "BUDSelectedView.h"


/*
 The corresponding adapter class is shown in the corresponding table of the BUDSlotID class.
 对应的adapter类参见BUDSlotID类的对应表
 */
@interface MPPangleInterstitialVC () <MPInterstitialAdControllerDelegate>
@property (nonatomic, strong) BUDNormalButton *button;
@property (nonatomic, strong) MPInterstitialAdController *interstitial;


@property(nonatomic, copy) NSString *currentID;
@property(nonatomic, copy) NSDictionary *sizeDcit;
@property(nonatomic, strong) BUDSelectedView *selectedView;
@property (nonatomic, strong) UISwitch *isNativeSwitch;

@end

@implementation MPPangleInterstitialVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpSlotIds];
}

- (void)setUpSlotIds {
    self.sizeDcit = @{
                          //模板
                          @"945182439"   :  [NSValue valueWithCGSize:CGSizeMake(600, 90)],
                          @"945189364"  :  [NSValue valueWithCGSize:CGSizeMake(640, 100)],
                          @"945189363"  :  [NSValue valueWithCGSize:CGSizeMake(600, 150)],
                          };

    
    BUDSelcetedItem *item1 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":@"945182439",@"title":@"1:1"}];
    BUDSelcetedItem *item2 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":@"945189364",@"title":@"2:3"}];
    BUDSelcetedItem *item3 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":@"945189363",@"title":@"3:2"}];

    NSArray *titlesAndIDS = @[@[item1,item2,item3]];

    __weak typeof(self) weakself = self;
    self.selectedView = [[BUDSelectedView alloc] initWithAdName:@"Express & Native Interstitial" SelectedTitlesAndIDS:titlesAndIDS loadAdAction:^(NSString * _Nullable slotId) {
        __strong typeof(self) strongself = weakself;
        [strongself loadInterstitialWithSlotId:slotId];
    } showAdAction:^{
        __strong typeof(self) strongself = weakself;
        strongself.selectedView.promptStatus = BUDPromptStatusDefault;
        if (strongself.interstitial.ready) {
            [strongself.interstitial showFromViewController:strongself];
        }
    }];
    [self.view addSubview:self.selectedView];
    self.selectedView.promptStatus = BUDPromptStatusDefault;
    
    UILabel *carouselLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, self.selectedView.top + 50, 180, 30)];
    carouselLabel.text = @"Native Banner Switch";
    carouselLabel.textColor = [UIColor blackColor];
    carouselLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:carouselLabel];

    self.isNativeSwitch = [[UISwitch alloc] init];
    self.isNativeSwitch.onTintColor = mainColor;
    self.isNativeSwitch.frame = CGRectMake(200, self.selectedView.top + 50, 51, 31);
    [self.view addSubview:self.isNativeSwitch];

}


- (void)loadInterstitialWithSlotId:(NSString *)slotId {
    // Instantiate the interstitial using the class convenience method.
    self.interstitial = [MPInterstitialAdController
                         interstitialAdControllerForAdUnitId:mopub_official_intersttitial_UnitID];
    self.interstitial.localExtras = @{@"ad_placement_id":slotId};
    if (self.isNativeSwitch.on) {
        self.interstitial.localExtras = @{@"ad_placement_id":@"945166817"};
    }
    self.interstitial.delegate = self;
    [self.interstitial loadAd];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.button.center = CGPointMake(self.view.center.x, self.view.center.y*1.5);
}

#pragma mark 延迟加载

#pragma mark - MPInterstitialAdControllerDelegate
- (void)interstitialDidLoadAd:(MPInterstitialAdController *)interstitial {
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
