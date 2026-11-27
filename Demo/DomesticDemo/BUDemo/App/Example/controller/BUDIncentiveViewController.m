//
//  BUDEasyPlayViewController.m
//  BUDemo
//
//  Created by ByteDance on 2024/5/20.
//  Copyright © 2024 bytedance. All rights reserved.
//

#import "BUDIncentiveViewController.h"
#import <Masonry/Masonry.h>

@interface BUDIncentiveViewController ()<BUNativeAdDelegate, BUNativeAdsManagerDelegate, BUIncentiveAdDelegate>

@property(nonatomic, strong) BUNativeAd *nativeAd;
@property(nonatomic, strong) BUNativeAdsManager *adManager;
@property(nonatomic, strong) UIView *container;

@end

@implementation BUDIncentiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    // setp1--创建用于展示轻互动的视图容器
    self.container = self.container = [[UIView alloc] initWithFrame:CGRectZero];
    self.container.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.container];
    
    // setp2--加载信息流广告
    BUAdSlot *slot = [[BUAdSlot alloc] init];
    slot.ID = @"900546910";
    slot.AdType = BUAdSlotAdTypeFeed;
    
   // 通过BUNativeAdsManager加载广告看这里
    self.adManager = [[BUNativeAdsManager alloc] initWithSlot:slot];
    self.adManager.mediation.rootViewController = self;
    self.adManager.delegate = self;
    [self.adManager loadIncentiveAdDataWithCount:1];
    
    // setp2--加载福利广告(BUNativeAd方式)
//    self.nativeAd = [[BUNativeAd alloc] initWithSlot:slot];
//    self.nativeAd.rootViewController = self;
//    self.nativeAd.delegate = self;
//    self.nativeAd.incentiveAdDelegate = self;
//    
//    [self.nativeAd loadIncentiveAd];
}


#pragma mark - BUNativeAdsManagerDelegate
- (void)nativeAdsManagerSuccessToLoad:(BUNativeAdsManager *)adsManager nativeAds:(NSArray<BUNativeAd *> *)nativeAdDataArray {
    // manager 模式下，以 manager 成功回调作为广告对象初始化入口
    self.nativeAd = nativeAdDataArray.firstObject;
    if (!self.nativeAd) {
        return;
    }
    self.nativeAd.rootViewController = self;
    self.nativeAd.delegate = self;
    self.nativeAd.incentiveAdDelegate = self;
    [self.nativeAd registerContainer:self.container withClickableViews:@[self.container]];
}

#pragma mark - BUNativeAdDelegate

- (void)nativeAdDidLoad:(BUNativeAd *)nativeAd {
    // manager 模式下加载完成以 nativeAdsManagerSuccessToLoad: 为准，这里仅保留兼容回调。
}

- (void)nativeAdDidBecomeVisible:(BUNativeAd *)nativeAd {
    
}

- (void)nativeAdDidClick:(BUNativeAd *)nativeAd withView:(UIView *_Nullable)view {
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)incentiveAdInfo:(NSDictionary *)info {
    // setp3--根据返回的建议尺寸&宽高比，更新容器大小
    CGFloat defaultWidth = 180.0;
    CGFloat defaultHeight = 138.0;
    CGFloat width = defaultWidth;
    CGFloat height = defaultHeight;
    
    // 推荐使用宽高比
    CGFloat preferredAspectRatio = [info[@"preferred_aspect_ratio"] doubleValue];
    if (preferredAspectRatio > 0) {
        width = defaultWidth;
        height = defaultWidth / preferredAspectRatio;
    }
    
    [self.container mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-100);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(height);
    }];
    [self.container layoutIfNeeded];
}

// 福利广告组件渲染成功，返回当前福利广告组件实际可交互的区域信息
- (void)incentiveAdRenderSuccess:(NSDictionary *)info {
    
}

// 福利广告组件渲染失败
- (void)incentiveAdRenderFail:(NSError *)error {
    
}

// 福利广告组件关闭，若福利广告组件没有展示，不会回调该方法
- (void)incentiveAdDidClose {
    
}

@end
