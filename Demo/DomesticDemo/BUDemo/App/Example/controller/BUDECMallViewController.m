//
//  BUDECMallViewController.m
//  BUDemoSource
//
//  Created by yujie on 2024/10/31.
//

#import "BUDECMallViewController.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDSlotID.h"
@interface BUDECMallViewController ()
@property (nonatomic, strong) BUNativeAdsManager *adManager;
@property (nonatomic, strong) BUNativeAdRelatedView *relatedView;
@end

@implementation BUDECMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadNativeAds];
    // Do any additional setup after loading the view.
}

- (void)loadNativeAds {
    BUAdSlot *slot1 = [[BUAdSlot alloc] init];
    slot1.ID = native_feed_ecmall_ID;
    slot1.AdType = BUAdSlotAdTypeFeed;
    slot1.supportRenderControl = self.renderSwitchView.on;
    slot1.imgSize = [BUSize sizeBy:BUProposalSize_Feed690_388];
    BUNativeAdsManager *nad = [[BUNativeAdsManager alloc]initWithSlot:slot1];
    nad.adSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    // 不支持中途更改代理，中途更改代理会导致接收不到广告相关回调，如若存在中途更改代理场景，需自行处理相关逻辑，确保广告相关回调正常执行。
    nad.delegate = self;
    nad.nativeExpressAdViewDelegate = self;
    self.adManager = nad;
    [nad loadAdDataWithCount:1];
}


- (void)nativeAdsManagerSuccessToLoad:(BUNativeAdsManager *)adsManager nativeAds:(NSArray<BUNativeAd *> *_Nullable)nativeAdDataArray {
   
    UIView *adView;
    for (BUNativeAd *nativeAd in nativeAdDataArray) {
        _relatedView = [[BUNativeAdRelatedView alloc] init];
        [_relatedView refreshData:nativeAd];
        adView = _relatedView.ecMallView;
    }
    if (adView == nil) {
        adView == [BUNativeAdRelatedView defaultECMallView];
    }
    [self.view addSubview:adView];
    adView.bounds = self.view.bounds;
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeAdsManagerDelegate" msg:[NSString stringWithFormat:@"native-count:%ld", (long)nativeAdDataArray.count]];

}



- (void)nativeAdsManager:(BUNativeAdsManager *)adsManager didFailWithError:(NSError *_Nullable)error {
    
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeAdsManagerDelegate" msg:[NSString stringWithFormat:@"error:%@", error]];
}
#pragma mark - BUNativeExpressAdViewDelegate
- (void)nativeExpressAdViewRenderSuccess:(BUNativeExpressAdView *)nativeExpressAdView {
   
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeExpressAdViewDelegate" msg:[NSString stringWithFormat:@"nativeExpressAdView.videoDuration:%ld", (long)nativeExpressAdView.videoDuration]];
}


- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView stateDidChanged:(BUPlayerPlayState)playerState {
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeExpressAdViewDelegate" msg:[NSString stringWithFormat:@"playerState:%ld", (long)playerState]];
}

- (void)nativeExpressAdViewRenderFail:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *)error {
  
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeExpressAdViewDelegate" msg:[NSString stringWithFormat:@"error:%@", error]];
}

- (void)nativeExpressAdViewWillShow:(BUNativeExpressAdView *)nativeExpressAdView {
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeExpressAdViewDelegate" msg:@""];
}

- (void)nativeExpressAdViewDidClick:(BUNativeExpressAdView *)nativeExpressAdView {
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeExpressAdViewDelegate" msg:@""];
}

- (void)nativeExpressAdViewPlayerDidPlayFinish:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *)error {
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeExpressAdViewDelegate" msg:@""];
}

- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords {//【重要】需要在点击叉以后 在这个回调中移除视图，否则，会出现用户点击叉无效的情况
//    [self.dataSource removeObject:nativeExpressAdView];
//
//    NSUInteger index = [self.dataSource indexOfObject:nativeExpressAdView];
//    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index inSection:0];
//    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeExpressAdViewDelegate" msg:@""];
}

- (void)nativeExpressAdViewDidClosed:(BUNativeExpressAdView *)nativeExpressAdView {
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeExpressAdViewDelegate" msg:@""];
}

- (void)nativeExpressAdViewWillPresentScreen:(BUNativeExpressAdView *)nativeExpressAdView {
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeExpressAdViewDelegate" msg:@""];
}

- (void)nativeExpressAdViewDidCloseOtherController:(BUNativeExpressAdView *)nativeExpressAdView interactionType:(BUInteractionType)interactionType {
    NSString *str;
    if (interactionType == BUInteractionTypePage) {
        str = @"ladingpage";
    } else if (interactionType == BUInteractionTypeVideoAdDetail) {
        str = @"videoDetail";
    } else {
        str = @"appstoreInApp";
    }
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeExpressAdViewDelegate" msg:str];
}





#pragma mark - BUNativeAdDelegate
- (void)nativeAdDidLoad:(BUNativeAd *)nativeAd {
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeAdDelegate" msg:@""];
}
- (void)nativeAdDidLoad:(BUNativeAd *)nativeAd view:view {
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeAdDelegate" msg:@""];
}

- (void)nativeAd:(BUNativeAd *)nativeAd didFailWithError:(NSError *_Nullable)error {
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeAdDelegate" msg:[NSString stringWithFormat:@"error:%@", error]];
}

- (void)nativeAdDidBecomeVisible:(BUNativeAd *)nativeAd {
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeAdDelegate" msg:@""];
}

- (void)nativeAdDidCloseOtherController:(BUNativeAd *)nativeAd interactionType:(BUInteractionType)interactionType {
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeAdDelegate" msg:[NSString stringWithFormat:@"interactionType:%ld", (long)interactionType]];
}

- (void)nativeAdDidClick:(BUNativeAd *)nativeAd withView:(UIView *_Nullable)view {
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeAdDelegate" msg:[NSString stringWithFormat:@"view:%@", view]];
}

- (void)nativeAd:(BUNativeAd *)nativeAd dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords {
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeAdDelegate" msg:@""];
}


- (void)nativeAd:(BUNativeAd *)nativeAd adContainerViewDidRemoved:(UIView *)adContainerView {

}

#pragma mark - BUVideoAdViewDelegate

- (void)videoAdView:(BUMediaAdView *)adView stateDidChanged:(BUPlayerPlayState)playerState {
    
    [self pbud_logWithSEL:_cmd prefix:@"BUVideoAdViewDelegate" msg:[NSString stringWithFormat:@"playerState:%ld", (long)playerState]];
}

- (void)videoAdView:(BUMediaAdView *)adView didLoadFailWithError:(NSError *)error {
    [self pbud_logWithSEL:_cmd prefix:@"BUVideoAdViewDelegate" msg:[NSString stringWithFormat:@"error:%@", error]];
}

- (void)playerDidPlayFinish:(BUMediaAdView *)adView {
    [self pbud_logWithSEL:_cmd prefix:@"BUVideoAdViewDelegate" msg:@""];
}

- (void)videoAdViewDidClick:(BUMediaAdView *)adView {
    [self pbud_logWithSEL:_cmd prefix:@"BUVideoAdViewDelegate" msg:@""];
}

- (void)videoAdViewFinishViewDidClick:(BUMediaAdView *)adView {
    [self pbud_logWithSEL:_cmd prefix:@"BUVideoAdViewDelegate" msg:@""];
}


- (void)videoAdViewDidCloseOtherController:(BUMediaAdView *)adView interactionType:(BUInteractionType)interactionType {
    [self pbud_logWithSEL:_cmd prefix:@"BUVideoAdViewDelegate" msg:[NSString stringWithFormat:@"interactionType:%ld", (long)interactionType]];
}

- (void)videoAdView:(BUMediaAdView *)videoAdView
 rewardDidCountDown:(NSInteger)countDown {
    [self pbud_logWithSEL:_cmd prefix:@"BUVideoAdViewDelegate" msg:[NSString stringWithFormat:@"videoAdView:rewardDidCountDown:%ld", (long)countDown]];
}

#pragma mark - Log
- (void)pbud_logWithSEL:(SEL)sel prefix:(NSString *)prefix msg:(NSString *)msg {
    NSLog(@"SDKDemoDelegate Native Feed %@ In VC (%@) extraMsg:%@", prefix, NSStringFromSelector(sel), msg);
}

@end
