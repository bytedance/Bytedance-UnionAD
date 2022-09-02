//
//  BUDBannerViewController.m
//  BUDemo
//
//  Created by bytedance on 2022/5/15.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import "BUDBannerViewController.h"
#import "UIColor+DarkMode.h"
#import "BUDSlotID.h"
#import "BUDSelcetedItem.h"
#import "BUDSelectedView.h"
#import "BUDSwitchView.h"
#import "BUDMacros.h"
#import <PAGAdSDK/PAGBannerAd.h>

typedef NS_ENUM(NSUInteger, PAGBannerAdSizeType) {
    PAGBannerAdSizeType_640100 = 1,
    PAGBannerAdSizeType_600500 = 2,
};


@interface BUDBannerViewController ()<PAGBannerAdDelegate>

@property (nonatomic, copy)   NSArray *titlesAndIDS;
@property (nonatomic, copy)   NSDictionary *sizeDcit;
@property (nonatomic, strong) BUDSelectedView *selectedView;
@property (nonatomic, strong) UIView *bannerView;
@property (nonatomic, strong) BUDSwitchView *slotSwitchView;
@property (nonatomic, strong) PAGBannerAd *bannerAd;


@end

@implementation BUDBannerViewController

#pragma mark - Lifecycle

- (void)dealloc {
    [self _logWithSEL:_cmd msg:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupData];
    [self _setupUI];
}


#pragma mark - Private

/// Set up demo data
- (void)_setupData {
    
    self.sizeDcit = @{
                        express_banner_ID_640100  :  @(PAGBannerAdSizeType_640100),
                        express_banner_ID_600500_both  : @(PAGBannerAdSizeType_600500)
                     };
    
    BUDSelcetedItem *item2 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":express_banner_ID_640100,@"title":@"320*50"}];
    BUDSelcetedItem *item8 = [[BUDSelcetedItem alloc] initWithDict:@{@"slotID":express_banner_ID_600500_both,@"title":@"300*250"}];
    self.titlesAndIDS = @[@[item2,item8]];
}

/// Set up demo interface
- (void)_setupUI {
    
    self.view.backgroundColor = UIColor.bud_systemBackgroundColor;
    
    __weak typeof(self) weakself = self;
    self.selectedView = [[BUDSelectedView alloc] initWithAdName:self.adName SelectedTitlesAndIDS:self.titlesAndIDS loadAdAction:^(NSString * _Nullable slotId) {
        __strong typeof(self) strongself = weakself;
        [strongself _loadBannerWithSlotID:slotId];
    } showAdAction:^{
        __strong typeof(self) strongself = weakself;
        [strongself _showBanner];
    }];
    self.selectedView.promptStatus = BUDPromptStatusDefault;
    [self.view addSubview:self.selectedView];
}

- (void)_loadBannerWithSlotID:(NSString *)slotID {
    
    self.selectedView.promptStatus = BUDPromptStatusLoading;
    
    [self.bannerView removeFromSuperview];
    UIWindow *window = nil;
    if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
        window = [[UIApplication sharedApplication].delegate window];
    }
    if (![window isKindOfClass:[UIView class]]) {
        window = [UIApplication sharedApplication].keyWindow;
    }
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    CGFloat bottom = 0.0;
    if (@available(iOS 11.0, *)) {
        bottom = window.safeAreaInsets.bottom;
    } else {
        // Fallback on earlier versions
    }
    
    NSNumber *sizeNumber = [self.sizeDcit valueForKey:slotID];
    PAGBannerAdSizeType type = sizeNumber.intValue;
    PAGBannerAdSize size = kPAGBannerSize300x250;
    switch (type) {
        case PAGBannerAdSizeType_640100:
            size = kPAGBannerSize320x50;
            break;
        case PAGBannerAdSizeType_600500:
            size = kPAGBannerSize300x250;
            break;
            
        default:
            break;
    }
    [PAGBannerAd loadAdWithSlotID:slotID
                          request:[PAGBannerRequest requestWithBannerSize:size]
                completionHandler:^(PAGBannerAd * _Nullable bannerAd, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"banner ad load fail : %@",error);
            return;
        }
        self.selectedView.promptStatus = BUDPromptStatusAdLoaded;

        self.bannerAd = bannerAd;
        // 不支持中途更改代理，中途更改代理会导致接收不到广告相关回调，如若存在中途更改代理场景，需自行处理相关逻辑，确保广告相关回调正常执行。
        self.bannerAd.delegate = self;
        self.bannerAd.rootViewController = self;
        self.bannerView = self.bannerAd.bannerView;
        self.bannerView.frame = CGRectMake((self.view.width-size.size.width)/2.0, self.view.height-size.size.height-bottom, size.size.width, size.size.height);
    }];
}

- (void)_showBanner {
    
    self.selectedView.promptStatus = BUDPromptStatusDefault;

    [self.view addSubview:self.bannerView];
}

- (void)_logWithSEL:(SEL)sel msg:(NSString *)msg {
    BUD_Log(@"BUDBannerViewController | %@ | %@",NSStringFromSelector(sel), msg);
}

# pragma mark - PAGBannerAdDelegate

- (void)adDidShow:(id<PAGAdProtocol>)ad {
    
    [self _logWithSEL:_cmd msg:nil];
}

- (void)adDidClick:(id<PAGAdProtocol>)ad {
    
    [self _logWithSEL:_cmd msg:nil];
}

- (void)adDidDismiss:(id<PAGAdProtocol>)ad {
    
    [self _logWithSEL:_cmd msg:nil];
}





@end
