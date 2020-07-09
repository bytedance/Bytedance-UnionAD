//
//  MPPangleBannerVC.m
//  BUDemo
//
//  Created by wangyanlin on 2020/5/19.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "MPPangleBannerVC.h"
#import <mopub-ios-sdk/MPAdView.h>
#import "BUDNormalButton.h"
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import "NSString+LocalizedString.h"
#import "BUDSelectedView.h"

/*
 The corresponding adapter class is shown in the corresponding table of the BUDSlotID class.
 对应的adapter类参见BUDSlotID类的对应表
 */
@interface MPPangleBannerVC () <MPAdViewDelegate>

@property (nonatomic) MPAdView *adView;
@property (nonatomic, strong) NSMutableArray *slotIdArray;

@property(nonatomic, copy) NSString *currentID;
@property(nonatomic, copy) NSDictionary *sizeDcit;
@property(nonatomic, strong) BUDSelectedView *selectedView;
@property (nonatomic, strong) UISwitch *isNativeSwitch;
@property (nonatomic, strong) UITextField *widthTF;
@property (nonatomic, strong) UITextField *heightTF;

@end

@implementation MPPangleBannerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpSlotIds];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"清除广告" style:UIBarButtonItemStylePlain target:self action:@selector(cleanAd)];
}

- (void)setUpSlotIds {
    self.sizeDcit = @{
                          @"945183948"   :  [NSValue valueWithCGSize:CGSizeMake(600, 90)],
                          @"945166818"  :  [NSValue valueWithCGSize:CGSizeMake(640, 100)],
                          @"900546198"  :  [NSValue valueWithCGSize:CGSizeMake(600, 150)],
                          @"900546673"  :  [NSValue valueWithCGSize:CGSizeMake(690, 388)],
                          @"900546387"  :  [NSValue valueWithCGSize:CGSizeMake(600, 260)],
                          @"945182437"  :  [NSValue valueWithCGSize:CGSizeMake(600, 300)],
                          @"945113150"  :  [NSValue valueWithCGSize:CGSizeMake(600, 400)],
                          @"945189361"  :  [NSValue valueWithCGSize:CGSizeMake(600, 500)],
                          };

    
    BUDSelcetedItem *item1 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":@"945183948",@"title":@"600*90"}];
    BUDSelcetedItem *item2 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":@"945166818",@"title":@"640*100"}];
    BUDSelcetedItem *item3 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":@"900546198",@"title":@"600*150"}];
    BUDSelcetedItem *item4 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":@"900546673",@"title":@"690*388"}];
    BUDSelcetedItem *item5 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":@"900546387",@"title":@"600*260"}];
    BUDSelcetedItem *item6 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":@"945182437",@"title":@"600*300"}];
    BUDSelcetedItem *item7 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":@"945113150",@"title":@"600*400"}];
    BUDSelcetedItem *item8 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":@"945189361",@"title":@"600*500"}];

    NSArray *titlesAndIDS = @[@[item1,item2,item3],@[item4,item5,item6],@[item7,item8]];

    __weak typeof(self) weakself = self;
    self.selectedView = [[BUDSelectedView alloc] initWithAdName:@"Express & Native Banner" SelectedTitlesAndIDS:titlesAndIDS loadAdAction:^(NSString * _Nullable slotId) {
        __strong typeof(self) strongself = weakself;
        [strongself.adView removeFromSuperview];
        [strongself loadBannerViewSlotId:slotId size:CGSizeZero];
    } showAdAction:^{
        __strong typeof(self) strongself = weakself;
        strongself.selectedView.promptStatus = BUDPromptStatusDefault;
        [strongself.view addSubview:strongself.adView];
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
    
    self.widthTF = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.selectedView.frame), 100, 50)];
    self.widthTF.placeholder = @"请输入宽";
    [self.view addSubview:self.widthTF];
    self.heightTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.widthTF.frame) + 10, CGRectGetMaxY(self.selectedView.frame), 100, 50)];
    self.heightTF.placeholder = @"请输入高";
    [self.view addSubview:self.heightTF];
    self.widthTF.layer.borderColor = [UIColor blackColor].CGColor;
    self.widthTF.layer.borderWidth = 1.0;
    self.heightTF.layer.borderColor = [UIColor blackColor].CGColor;
    self.heightTF.layer.borderWidth = 1.0;

    UIButton *loadBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.heightTF.frame) + 10, CGRectGetMaxY(self.selectedView.frame), 100, 50)];
    [self.view addSubview:loadBtn];
    loadBtn.backgroundColor = [UIColor grayColor];
    [loadBtn setTitle:@"展示" forState:UIControlStateNormal];
    [loadBtn addTarget:self action:@selector(loadBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loadBtnClick{
    [self.adView removeFromSuperview];
    [self loadBannerViewSlotId:self.selectedView.currentID size:CGSizeMake(self.widthTF.text.floatValue, self.heightTF.text.floatValue)];
    [self.view addSubview:self.adView];
}

- (void)cleanAd{
    [self.view endEditing:YES];
    [self.adView removeFromSuperview];
}

- (void)loadBannerViewSlotId:(NSString *)slotId size:(CGSize)inputSize{
    self.view.backgroundColor = [UIColor orangeColor];

    [self.view endEditing:YES];
    [self.adView removeFromSuperview];
    
    NSValue *sizeValue = [self.sizeDcit objectForKey:slotId];
    CGSize size = [sizeValue CGSizeValue];
    if (inputSize.width && inputSize.height) {
        size = inputSize;
    }
    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat bannerHeigh = screenWidth/size.width*size.height;

    self.adView = [[MPAdView alloc] initWithAdUnitId:mopub_official_banner_UnitID];
    self.adView.localExtras = @{@"ad_placement_id":slotId};
    if (self.isNativeSwitch.on) {
        self.adView.localExtras = @{@"ad_placement_id":@"945166816"};
    }
    self.adView.delegate = self;
    self.adView.frame = CGRectMake(0, self.view.height-bannerHeigh - 34, screenWidth, bannerHeigh);
    [self.adView loadAd];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

#pragma mark 延迟加载

#pragma mark MPAdViewDelegate
- (UIViewController *)viewControllerForPresentingModalView {
    return self;
}

- (void)adViewDidLoadAd:(MPAdView *)view adSize:(CGSize)adSize {
    self.selectedView.promptStatus = BUDPromptStatusAdLoaded;
    BUD_Log(@"%s", __func__);
}

- (void)adView:(MPAdView *)view didFailToLoadAdWithError:(NSError *)error {
    BUD_Log(@"%s", __func__);
}

- (void)willPresentModalViewForAd:(MPAdView *)view {
    BUD_Log(@"%s", __func__);
}

-(void)didDismissModalViewForAd:(MPAdView *)view {
    BUD_Log(@"%s", __func__);
}

@end
