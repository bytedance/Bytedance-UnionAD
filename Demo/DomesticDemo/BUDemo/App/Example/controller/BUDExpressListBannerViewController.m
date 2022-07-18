//
//  BUDExpressListBannerViewController.m
//  BUDemo
//
//  Created by bytedance on 2021/7/4.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "BUDExpressListBannerViewController.h"
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDSelectedView.h"
#import "NSString+LocalizedString.h"
#import "AppDelegate.h"
#import "UIColor+DarkMode.h"
#ifdef DEBUG
#import <MBProgressHUD/MBProgressHUD.h>
#endif

#define NumberOfCellMax 3
#define BannerCellHeight 300

@interface BUDListBannerHeader : UICollectionReusableView @end
@implementation BUDListBannerHeader @end

@interface BUDBannerCollectionViewCell : UICollectionViewCell @end
@implementation BUDBannerCollectionViewCell @end

@interface BUDExpressListBannerViewController ()<BUNativeExpressBannerViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) BUDSelectedView *selectedView;
@property (nonatomic, strong) UIView *collectionHeaderView;

@property (nonatomic, copy) NSString *currentID;
@property (nonatomic, copy) NSDictionary *sizeDcit;
@property (nonatomic, strong) BUDSwitchView *slotSwitchView;
@property (nonatomic, strong) BUDSwitchView *rotationSwitchView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *bannerViewArray;

@end

@implementation BUDExpressListBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.bud_systemBackgroundColor;
    
    self.bannerViewArray = [NSMutableArray array];
    
    self.sizeDcit = @{
                          express_banner_ID_60090   :  [NSValue valueWithCGSize:CGSizeMake(300, 45)],
                          express_banner_ID_640100  :  [NSValue valueWithCGSize:CGSizeMake(320, 50)],
                          express_banner_ID_600150  :  [NSValue valueWithCGSize:CGSizeMake(300, 75)],
                          express_banner_ID_690388  :  [NSValue valueWithCGSize:CGSizeMake(345, 194)],
                          express_banner_ID_600260  :  [NSValue valueWithCGSize:CGSizeMake(300, 130)],
                          express_banner_ID_600300  :  [NSValue valueWithCGSize:CGSizeMake(300, 150)],
                          express_banner_ID_600400_both  :  [NSValue valueWithCGSize:CGSizeMake(300, 200)],
                          express_banner_ID_600500_both  :  [NSValue valueWithCGSize:CGSizeMake(300, 250)],
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
    self.selectedView = [[BUDSelectedView alloc] initWithAdName:self.adName SelectedTitlesAndIDS:titlesAndIDS loadAdAction:^(NSString * _Nullable slotId) {
        __strong typeof(self) strongself = weakself;
        [strongself loadBannerWithSlotID:slotId];
    } showAdAction:^{
        __strong typeof(self) strongself = weakself;
        [strongself showBanner];
    }];
    [self.collectionHeaderView addSubview:self.selectedView];
    self.selectedView.promptStatus = BUDPromptStatusDefault;
    
    
    self.rotationSwitchView = [[BUDSwitchView alloc] initWithTitle:@"轮播" on:NO height:44];
    CGRect frame = self.rotationSwitchView.frame;
    frame.origin.y = self.selectedView.bottom+20;
    frame.origin.x = 0;
    self.rotationSwitchView.frame = frame;
    [self.collectionHeaderView addSubview:self.rotationSwitchView];
    
    self.slotSwitchView = [[BUDSwitchView alloc] initWithTitle:@"是否是模板slot" on:YES height:44];
    CGRect frame2 = self.slotSwitchView.frame;
    frame2.origin.y = self.selectedView.bottom+20;
    frame2.origin.x = 120 + 51 + 10;
    self.slotSwitchView.frame = frame2;
    [self.collectionHeaderView addSubview:self.slotSwitchView];
    
    self.collectionHeaderView.bu_size = CGSizeMake(BUScreenWidth, self.slotSwitchView.bu_bottom);
    
    self.collectionView.frame = CGRectMake(0, 0, BUScreenWidth, BUScreenHeight - (BUiPhoneX ? 44 : 0));
    [self.view addSubview:self.collectionView];
}

/***important:
 广告加载成功的时候，会立即渲染WKWebView。
 如果想预加载的话，建议一次最多预加载三个广告，如果超过3个会很大概率导致WKWebview渲染失败。
 */
- (void)loadBannerWithSlotID:(NSString *)slotID {
    [self.bannerViewArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.bannerViewArray removeAllObjects];
    
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
    
    NSValue *sizeValue = [self.sizeDcit objectForKey:slotID];
    CGSize size = [sizeValue CGSizeValue];
    //    native_banner_ID
    NSString *realSlotId = self.slotSwitchView.on ? slotID : native_banner_ID;
    // important: 升级的用户请注意，初始化方法去掉了imgSize参数
    for (int i = 0; i < NumberOfCellMax; i ++) {
        BUNativeExpressBannerView *bannerView = nil;
        if (self.rotationSwitchView.on) {
            bannerView = [[BUNativeExpressBannerView alloc] initWithSlotID:realSlotId rootViewController:self adSize:size interval:30];
            bannerView.layer.masksToBounds = YES;
        } else {
            bannerView = [[BUNativeExpressBannerView alloc] initWithSlotID:realSlotId rootViewController:self adSize:size];
        }
        bannerView.frame = CGRectMake((self.view.width - size.width)/2.0, 0, size.width, size.height);
        
        // 不支持中途更改代理，中途更改代理会导致接收不到广告相关回调，如若存在中途更改代理场景，需自行处理相关逻辑，确保广告相关回调正常执行。
        bannerView.delegate = self;
        [bannerView loadAdData];
        if (bannerView) {
            [self.bannerViewArray addObject:bannerView];
        }
    }
    
    self.selectedView.promptStatus = BUDPromptStatusLoading;
}

- (void)showBanner {
    self.selectedView.promptStatus = BUDPromptStatusDefault;
    [self.collectionView reloadData];
}

#pragma BUNativeExpressBannerViewDelegate
- (void)nativeExpressBannerAdViewDidLoad:(BUNativeExpressBannerView *)bannerAdView {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView didLoadFailWithError:(NSError *)error {
    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"error:%@", error]];
}

- (void)nativeExpressBannerAdViewRenderSuccess:(BUNativeExpressBannerView *)bannerAdView {
    self.selectedView.promptStatus = BUDPromptStatusAdLoaded;
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressBannerAdViewRenderFail:(BUNativeExpressBannerView *)bannerAdView error:(NSError *)error {
    self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"error:%@", error]];
}

- (void)nativeExpressBannerAdViewWillBecomVisible:(BUNativeExpressBannerView *)bannerAdView {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressBannerAdViewDidClick:(BUNativeExpressBannerView *)bannerAdView {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterwords {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressBannerAdViewDidCloseOtherController:(BUNativeExpressBannerView *)bannerAdView interactionType:(BUInteractionType)interactionType {
    NSString *str;
    if (interactionType == BUInteractionTypePage) {
        str = @"ladingpage";
    } else if (interactionType == BUInteractionTypeVideoAdDetail) {
        str = @"videoDetail";
    } else {
        str = @"appstoreInApp";
    }
    [self pbud_logWithSEL:_cmd msg:str];
}

- (void)nativeExpressBannerAdViewDidRemoved:(BUNativeExpressBannerView *)nativeExpressAdView {
#ifdef DEBUG
    [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view.window];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"温馨提示";
    hud.detailsLabel.text = @"强制关闭广告，开发者请做好布局处理";
    [hud hideAnimated:YES afterDelay:1.5];
#endif
    [UIView animateWithDuration:0.25 animations:^{
        nativeExpressAdView.alpha = 0;
    } completion:^(BOOL finished) {
        [nativeExpressAdView removeFromSuperview];
    }];
    self.selectedView.promptStatus = BUDPromptStatusDefault;
}

- (void)pbud_logWithSEL:(SEL)sel msg:(NSString *)msg {
    BUD_Log(@"SDKDemoDelegate BUNativeExpressBannerView In VC (%@) extraMsg:%@", NSStringFromSelector(sel), msg);
}

#pragma mark collectionViewDelegate datasource

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    BUDBannerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BUDBannerCollectionViewCell" forIndexPath:indexPath];
    BUNativeExpressBannerView *bannerView = [self.bannerViewArray bu_objectAtIndexSafely:indexPath.row];
    bannerView.bu_x = (BUScreenWidth - bannerView.bu_width) / 2.0;
    bannerView.bu_y = (BannerCellHeight - bannerView.bu_height) / 2.0;
    [cell addSubview:bannerView];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        BUDListBannerHeader *view = (BUDListBannerHeader *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BUDBannerCollectionViewHeader" forIndexPath:indexPath];
        [view addSubview:self.collectionHeaderView];
        return view;
    }
    return [[BUDListBannerHeader alloc] init];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.bannerViewArray.count <= indexPath.row) {
        return CGSizeZero;
    }
    return CGSizeMake(BUScreenWidth, BannerCellHeight);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return self.collectionHeaderView.bu_size;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return NumberOfCellMax;
}


#pragma mark lazy

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerClass:[BUDBannerCollectionViewCell class] forCellWithReuseIdentifier:@"BUDBannerCollectionViewCell"];
        [_collectionView registerClass:[BUDListBannerHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BUDBannerCollectionViewHeader"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

- (UIView *)collectionHeaderView {
    if (!_collectionHeaderView) {
        _collectionHeaderView = [[UIView alloc] init];
    }
    return _collectionHeaderView;
}

@end
