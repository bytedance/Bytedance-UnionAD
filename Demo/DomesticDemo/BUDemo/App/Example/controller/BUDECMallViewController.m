//
//  BUDECMallViewController.m
//  BUDemoSource
//
//  Created by yujie on 2024/10/31.
//

#import "BUDECMallViewController.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDSlotID.h"
#import "NSString+LocalizedString.h"

typedef NS_ENUM(NSInteger, BUDECMallActionState) {
    BUDECMallActionStateReadyToPreload,
    BUDECMallActionStateLoading,
    BUDECMallActionStateReadyToShow,
};

@interface BUDECMallViewController ()
@property (nonatomic, strong) BUNativeAdsManager *adManager;
@property (nonatomic, strong) BUNativeAdRelatedView *relatedView;
@property (nonatomic, strong) UIView *ecMallAdView;
@property (nonatomic, strong) UIBarButtonItem *loadAndShowButtonItem;
@property (nonatomic, strong) UIBarButtonItem *preloadShowButtonItem;
@property (nonatomic, assign) BUDECMallActionState actionState;
@property (nonatomic, assign) BOOL shouldShowECMallViewAfterLoad;
@end

@implementation BUDECMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavigationBarButtons];
    [self updatePreloadShowButtonWithState:BUDECMallActionStateReadyToPreload];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self attachNavigationBarButtons];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self detachNavigationBarButtons];
}

- (void)setupNavigationBarButtons {
    self.loadAndShowButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"加载并展示"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(loadAndShowButtonDidClick:)];
    self.preloadShowButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"预加载"
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(preloadShowButtonDidClick:)];
}

- (UINavigationItem *)activeNavigationItem {
    return self.tabBarController.navigationItem ?: self.navigationItem;
}

- (void)attachNavigationBarButtons {
    self.activeNavigationItem.rightBarButtonItems = @[self.loadAndShowButtonItem, self.preloadShowButtonItem];
}

- (void)detachNavigationBarButtons {
    UINavigationItem *navigationItem = self.activeNavigationItem;
    NSArray<UIBarButtonItem *> *rightBarButtonItems = navigationItem.rightBarButtonItems;
    if ([rightBarButtonItems containsObject:self.loadAndShowButtonItem] || [rightBarButtonItems containsObject:self.preloadShowButtonItem]) {
        navigationItem.rightBarButtonItems = nil;
    }
}

- (void)loadAndShowButtonDidClick:(UIBarButtonItem *)sender {
    self.shouldShowECMallViewAfterLoad = YES;
    [self loadNativeAds];
}

- (void)preloadShowButtonDidClick:(UIBarButtonItem *)sender {
    if (self.actionState == BUDECMallActionStateReadyToPreload) {
        self.shouldShowECMallViewAfterLoad = NO;
        [self loadNativeAds];
    } else if (self.actionState == BUDECMallActionStateReadyToShow) {
        [self showECMallView];
    }
}

- (void)loadNativeAds {
    [self resetECMallViewState];
    [self updatePreloadShowButtonWithState:BUDECMallActionStateLoading];
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

- (void)resetECMallViewState {
    [self.relatedView setECMallViewVisiable:NO];
    [self.ecMallAdView removeFromSuperview];
    self.ecMallAdView = nil;
    self.relatedView = nil;
}

- (void)preloadECMallView {
    UIView *adView = nil;
    if ([self.relatedView isECMallValid]) {
        adView = self.relatedView.ecMallView;
    }
    if (adView == nil) {
        adView = [BUNativeAdRelatedView defaultECMallView];
    }
    if (adView == nil) {
        [self updatePreloadShowButtonWithState:BUDECMallActionStateReadyToPreload];
        return;
    }
    [self.relatedView setECMallViewVisiable:NO];
    self.ecMallAdView = adView;
    [self updatePreloadShowButtonWithState:BUDECMallActionStateReadyToShow];
}

- (void)showECMallView {
    if (self.ecMallAdView == nil) {
        [self updatePreloadShowButtonWithState:BUDECMallActionStateReadyToPreload];
        return;
    }
    [self.relatedView setECMallViewVisiable:YES];
    [self.ecMallAdView removeFromSuperview];
    [self.view addSubview:self.ecMallAdView];
    self.ecMallAdView.frame = self.view.bounds;
    [self updatePreloadShowButtonWithState:BUDECMallActionStateReadyToPreload];
}

- (void)updatePreloadShowButtonWithState:(BUDECMallActionState)state {
    self.actionState = state;
    switch (state) {
        case BUDECMallActionStateReadyToPreload:
            self.preloadShowButtonItem.title = @"预加载";
            self.preloadShowButtonItem.enabled = YES;
            self.loadAndShowButtonItem.enabled = YES;
            break;
        case BUDECMallActionStateLoading:
            self.preloadShowButtonItem.title = @"预加载";
            self.preloadShowButtonItem.enabled = NO;
            self.loadAndShowButtonItem.enabled = NO;
            break;
        case BUDECMallActionStateReadyToShow:
            self.preloadShowButtonItem.title = @"展示";
            self.preloadShowButtonItem.enabled = YES;
            self.loadAndShowButtonItem.enabled = YES;
            break;
    }
}

- (void)nativeAdsManagerSuccessToLoad:(BUNativeAdsManager *)adsManager nativeAds:(NSArray<BUNativeAd *> *_Nullable)nativeAdDataArray {
   
    BUNativeAdRelatedView *relatedView = nil;
    for (BUNativeAd *nativeAd in nativeAdDataArray) {
        relatedView = [[BUNativeAdRelatedView alloc] init];
        [relatedView refreshData:nativeAd];
        if ([relatedView isECMallValid]) {
            break;
        }
    }
    self.relatedView = relatedView;
    [self preloadECMallView];
    if (self.shouldShowECMallViewAfterLoad && self.ecMallAdView) {
        [self showECMallView];
    }
    self.shouldShowECMallViewAfterLoad = NO;
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeAdsManagerDelegate" msg:[NSString stringWithFormat:@"native-count:%ld", (long)nativeAdDataArray.count]];

}



- (void)nativeAdsManager:(BUNativeAdsManager *)adsManager didFailWithError:(NSError *_Nullable)error {
    
    self.shouldShowECMallViewAfterLoad = NO;
    [self updatePreloadShowButtonWithState:BUDECMallActionStateReadyToPreload];
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
- (void)nativeAdDidLoad:(BUNativeAd *)nativeAd view:(UIView *_Nullable)view {
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
