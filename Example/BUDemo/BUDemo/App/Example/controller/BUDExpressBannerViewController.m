//
//  BUDExpressBannerViewController.m
//  BUDemo
//
//  Created by xxx on 2019/5/15.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDExpressBannerViewController.h"
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import <BUAdSDK/BUNativeExpressBannerView.h>
#import <BUAdSDK/BUAdSDK.h>
#import "BUDSelectedView.h"
#import "NSString+LocalizedString.h"

@interface BUDExpressBannerViewController ()<BUNativeExpressBannerViewDelegate>
@property(nonatomic, strong) BUDSelectedView *selectedView;
@property(nonatomic, strong) BUNativeExpressBannerView *bannerView;
@property (nonatomic, strong) UISwitch *isCarouselSwitch;

@property(nonatomic, copy) NSString *currentID;
@property(nonatomic, copy) NSDictionary *sizeDcit;
@end

@implementation BUDExpressBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.sizeDcit = @{
                          express_banner_ID         :  [NSValue valueWithCGSize:CGSizeMake(600, 90)],
                          express_banner_ID_60090   :  [NSValue valueWithCGSize:CGSizeMake(600, 90)],
                          express_banner_ID_640100  :  [NSValue valueWithCGSize:CGSizeMake(640, 100)],
                          express_banner_ID_600150  :  [NSValue valueWithCGSize:CGSizeMake(600, 150)],
                          express_banner_ID_690388  :  [NSValue valueWithCGSize:CGSizeMake(690, 388)],
                          express_banner_ID_600260  :  [NSValue valueWithCGSize:CGSizeMake(600, 260)],
                          express_banner_ID_600300  :  [NSValue valueWithCGSize:CGSizeMake(600, 300)],
                          express_banner_ID_600400_both  :  [NSValue valueWithCGSize:CGSizeMake(600, 400)],
                          express_banner_ID_600500_both  :  [NSValue valueWithCGSize:CGSizeMake(600, 500)],
                          };

    
    BUDSelcetedItem *item1 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":express_banner_ID_60090,@"title":@"600*90"}];
    BUDSelcetedItem *item2 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":express_banner_ID_640100,@"title":@"640*100"}];
    BUDSelcetedItem *item3 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":express_banner_ID_600150,@"title":@"600*150"}];
    BUDSelcetedItem *item4 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":express_banner_ID_690388,@"title":@"690*388"}];
    BUDSelcetedItem *item5 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":express_banner_ID_600260,@"title":@"600*260"}];
    BUDSelcetedItem *item6 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":express_banner_ID_600300,@"title":@"600*300"}];
    BUDSelcetedItem *item7 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":express_banner_ID_600400_both,@"title":@"600*400-both"}];
    BUDSelcetedItem *item8 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":express_banner_ID_600500_both,@"title":@"600*500-both"}];
    NSArray *titlesAndIDS = @[@[item1,item2,item3],@[item4,item5,item6],@[item7,item8]];

    __weak typeof(self) weakself = self;
    self.selectedView = [[BUDSelectedView alloc] initWithAdName:@"Express Banner" SelectedTitlesAndIDS:titlesAndIDS loadAdAction:^(NSString * _Nullable slotId) {
        __strong typeof(self) strongself = weakself;
        [strongself loadBannerWithSlotID:slotId];
    } showAdAction:^{
        __strong typeof(self) strongself = weakself;
        [strongself showBanner];
    }];
    [self.view addSubview:self.selectedView];
    self.selectedView.promptStatus = BUDPromptStatusDefault;
    
    //是否使用轮播banner的开关
    UILabel *carouselLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, self.selectedView.bottom+20, 100, 30)];
    carouselLabel.text = [NSString localizedStringForKey:IsCarousel];
    carouselLabel.textColor = [UIColor blackColor];
    carouselLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:carouselLabel];
    
    self.isCarouselSwitch = [[UISwitch alloc] init];
    self.isCarouselSwitch.onTintColor = mainColor;
    self.isCarouselSwitch.frame = CGRectMake(120, self.selectedView.bottom+20, 51, 31);
    [self.view addSubview:self.isCarouselSwitch];
}

- (void)loadBannerWithSlotID:(NSString *)slotID {
    [self.bannerView removeFromSuperview];
    
    NSValue *sizeValue = [self.sizeDcit objectForKey:slotID];
    CGSize size = [sizeValue CGSizeValue];
    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat bannerHeigh = screenWidth/size.width*size.height;
#warning 升级的用户请注意，初始化方法去掉了imgSize参数
    if (self.isCarouselSwitch.on) {
        self.bannerView = [[BUNativeExpressBannerView alloc] initWithSlotID:slotID rootViewController:self adSize:CGSizeMake(screenWidth, bannerHeigh) IsSupportDeepLink:YES interval:30];
    } else {
        self.bannerView = [[BUNativeExpressBannerView alloc] initWithSlotID:slotID rootViewController:self adSize:CGSizeMake(screenWidth, bannerHeigh) IsSupportDeepLink:YES];
    }
    self.bannerView.frame = CGRectMake(0, self.view.height-bannerHeigh, screenWidth, bannerHeigh);
    self.bannerView.delegate = self;
    [self.bannerView loadAdData];
    self.selectedView.promptStatus = BUDPromptStatusLoading;
}

- (void)showBanner {
    [self.view addSubview:self.bannerView];
    self.selectedView.promptStatus = BUDPromptStatusDefault;
}

#pragma BUNativeExpressBannerViewDelegate
- (void)nativeExpressBannerAdViewDidLoad:(BUNativeExpressBannerView *)bannerAdView {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView didLoadFailWithError:(NSError *)error {
    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    BUD_Log(@"%s",__func__);
    NSLog(@"error code : %ld , error message : %@",(long)error.code,error.description);
}

- (void)nativeExpressBannerAdViewRenderSuccess:(BUNativeExpressBannerView *)bannerAdView {
    self.selectedView.promptStatus = BUDPromptStatusAdLoaded;
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressBannerAdViewRenderFail:(BUNativeExpressBannerView *)bannerAdView error:(NSError *)error {
    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressBannerAdViewWillBecomVisible:(BUNativeExpressBannerView *)bannerAdView {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressBannerAdViewDidClick:(BUNativeExpressBannerView *)bannerAdView {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterwords {
    BUD_Log(@"%s",__func__);
    [UIView animateWithDuration:0.25 animations:^{
        bannerAdView.alpha = 0;
    } completion:^(BOOL finished) {
        [bannerAdView removeFromSuperview];
        self.bannerView = nil;
    }];
    self.selectedView.promptStatus = BUDPromptStatusDefault;
}

- (void)nativeExpressBannerAdViewDidCloseOtherController:(BUNativeExpressBannerView *)bannerAdView interactionType:(BUInteractionType)interactionType {
    NSString *str = nil;
    if (interactionType == BUInteractionTypePage) {
        str = @"ladingpage";
    } else if (interactionType == BUInteractionTypeVideoAdDetail) {
        str = @"videoDetail";
    } else {
        str = @"appstoreInApp";
    }
    BUD_Log(@"%s __ %@",__func__,str);
}

@end
