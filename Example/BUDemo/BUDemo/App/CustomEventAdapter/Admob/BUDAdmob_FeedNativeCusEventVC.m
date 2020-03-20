//
//  BUDAdmob_FeedNativeCusEventVC.m
//  BUDemo
//
//  Created by liudonghui on 2020/1/3.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDAdmob_FeedNativeCusEventVC.h"
#import "BUDFeedAdTableViewCell.h"
#import "NSString+Json.h"
#import "BUDFeedNormalModel.h"
#import "BUDFeedNormalTableViewCell.h"
#import "BUDMacros.h"
#import "NSString+LocalizedString.h"
#import "BUDAdmobNativeFeedView.h"
#import "BUDSlotID.h"
#import <GoogleMobileAds/GADAdLoader.h>
#import <GoogleMobileAds/GADAdLoaderDelegate.h>
#import <GoogleMobileAds/GADUnifiedNativeAd.h>
#import <GoogleMobileAds/GADUnifiedNativeAdDelegate.h>

@interface BUDAdmob_FeedNativeCusEventVC () <UITableViewDataSource, UITableViewDelegate,GADAdLoaderDelegate,GADUnifiedNativeAdDelegate,BUVideoAdViewDelegate,BUNativeAdDelegate,GADVideoControllerDelegate,GADUnifiedNativeAdLoaderDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong, getter=getAdLoader) GADAdLoader *adLoader;
@end

@implementation BUDAdmob_FeedNativeCusEventVC

- (void)dealloc {
    _tableView.delegate = nil;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //load normal feed
    [self loadNormalFeed];
    
    // load ads
    GADRequest *req = [GADRequest request];
    // this is set test device
    //req.testDevices = @[@"a71ad56d46ccbcd77254f4f0f5f2f80d"];
    [self.adLoader loadRequest:req];
}

- (GADAdLoader *)getAdLoader {
    if (_adLoader == nil) {
        GADMultipleAdsAdLoaderOptions *multipleAdsOptions =
            [[GADMultipleAdsAdLoaderOptions alloc] init];
        GADNativeMuteThisAdLoaderOptions *muteOptions = [GADNativeMuteThisAdLoaderOptions new];
        multipleAdsOptions.numberOfAds = 1;
        _adLoader = [[GADAdLoader alloc] initWithAdUnitID:admob_native_UnitID rootViewController:self adTypes:@[kGADAdLoaderAdTypeUnifiedNative] options:@[multipleAdsOptions,muteOptions]];
        _adLoader.delegate = self;
    }
    return _adLoader;
}

- (void)loadNormalFeed {
    // register cell for feed content
    [self.tableView registerClass:[BUDFeedNormalTableViewCell class] forCellReuseIdentifier:@"BUDFeedNormalTableViewCell"];
    [self.tableView registerClass:[BUDFeedNormalTitleTableViewCell class] forCellReuseIdentifier:@"BUDFeedNormalTitleTableViewCell"];
    [self.tableView registerClass:[BUDFeedNormalTitleImgTableViewCell class] forCellReuseIdentifier:@"BUDFeedNormalTitleImgTableViewCell"];
    [self.tableView registerClass:[BUDFeedNormalBigImgTableViewCell class] forCellReuseIdentifier:@"BUDFeedNormalBigImgTableViewCell"];
    [self.tableView registerClass:[BUDFeedNormalthreeImgsableViewCell class] forCellReuseIdentifier:@"BUDFeedNormalthreeImgsableViewCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSString *feedPath = [[NSBundle mainBundle] pathForResource:@"feedInfo" ofType:@"cactus"];
    NSString *s = [NSString stringWithContentsOfFile:feedPath encoding:NSUTF8StringEncoding error:nil];
    NSArray *datas = [s objectFromJSONString];
    
    self.dataSource = [NSMutableArray new];
    for (NSDictionary *dict in datas) {
        BUDFeedNormalModel *model = [[BUDFeedNormalModel alloc]initWithDict:dict];
        [self.dataSource addObject:model];
    }
    for (int i = 0; i < datas.count; i++) {
        NSUInteger index = rand() % (datas.count-3)+2;
        BUDFeedNormalModel *model = [[BUDFeedNormalModel alloc]initWithDict:[datas objectAtIndex:index]];
        [self.dataSource addObject:model];
    }
    [self.tableView reloadData];

}

#pragma mark - GADAdLoaderDelegate
- (void)adLoaderDidFinishLoading:(GADAdLoader *)adLoader {
    BUD_Log(@"%s",__func__);
}

- (void)adLoader:(GADAdLoader *)adLoader didFailToReceiveAdWithError:(GADRequestError *)error {
    BUD_Log(@"%s",__func__);
    BUD_Log(@"%@",error);
}

#pragma mark - GADUnifiedNativeAdDelegate
- (void)nativeAdDidRecordImpression:(nonnull GADUnifiedNativeAd *)nativeAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeAdDidRecordClick:(nonnull GADUnifiedNativeAd *)nativeAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeAdWillPresentScreen:(nonnull GADUnifiedNativeAd *)nativeAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeAdIsMuted:(GADUnifiedNativeAd *)nativeAd {
    BUD_Log(@"%s",__func__);
    for (NSInteger i = 0; i < self.dataSource.count; i++) {
        if (self.dataSource[i] == nativeAd) {
            [self.dataSource removeObjectAtIndex:i];
            [self.tableView reloadData];
            break;
        }
    }
}

#pragma mark - GADUnifiedNativeAdLoaderDelegate
- (void)adLoader:(nonnull GADAdLoader *)adLoader didReceiveUnifiedNativeAd:(nonnull GADUnifiedNativeAd *)nativeAd {
    BUD_Log(@"%s",__func__);
    // set delegate and rootVC of nativeAd
    nativeAd.delegate = self;
    nativeAd.rootViewController = self;
    if ([nativeAd.extraAssets objectForKey:BUDNativeAdTranslateKey]) {
        BUNativeAd *bu_nativeAd = (BUNativeAd *)[nativeAd.extraAssets objectForKey:BUDNativeAdTranslateKey];
        bu_nativeAd.delegate = self;
        bu_nativeAd.rootViewController = self;
    }
    NSInteger index = random() % self.dataSource.count;
    // add the nativeAd to dataSource
    [self.dataSource insertObject:nativeAd atIndex:index];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // For ad cells just as the ad cell provider, for normal cells do whatever you would do.
    NSUInteger index = indexPath.row;
    id model = self.dataSource[index];
    if ([model isKindOfClass:[GADUnifiedNativeAd class]]) {
        GADUnifiedNativeAd *nativeAd = (GADUnifiedNativeAd *)model;
        BUDAdmobNativeFeedView *view = [[BUDAdmobNativeFeedView alloc] initWithGADModel:nativeAd];
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        [cell.contentView addSubview:view];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if ([model isKindOfClass:[BUDFeedNormalModel class]]) {
        return [self getNormalFeedCellForTableView:tableView atIndexPath:indexPath];
    }
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [NSString localizedStringForKey:Unknown];
    return cell;
}

- (NSString *)classNameWithCellType:(NSString *)type {
    if ([type isEqualToString: @"title"]) {
        return @"BUDFeedNormalTitleTableViewCell";
    }else if ([type isEqualToString: @"titleImg"]){
        return @"BUDFeedNormalTitleImgTableViewCell";
    }else if ([type isEqualToString: @"bigImg"]){
        return @"BUDFeedNormalBigImgTableViewCell";
    }else if ([type isEqualToString: @"threeImgs"]){
        return @"BUDFeedNormalthreeImgsableViewCell";
    }else{
        return @"unkownCell";
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger index = indexPath.row;
    id model = self.dataSource[index];
    
    if ([model isKindOfClass:[GADUnifiedNativeAd class]]) {
        GADUnifiedNativeAd *nativeAd = (GADUnifiedNativeAd *)model;
        return [BUDAdmobNativeFeedView cellHeightWithModel:nativeAd width:CGRectGetWidth(self.tableView.bounds)];
    }else if ([model isKindOfClass:[BUDFeedNormalModel class]]){
        return [(BUDFeedNormalModel *)model cellHeight];
    }
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger index = indexPath.row;
    id model = self.dataSource[index];
    
    if ([model isKindOfClass:[GADUnifiedNativeAd class]]) {
        GADUnifiedNativeAd *nativeAd = (GADUnifiedNativeAd *)model;
        return [BUDAdmobNativeFeedView cellHeightWithModel:nativeAd width:CGRectGetWidth(self.tableView.bounds)];
    }else if ([model isKindOfClass:[BUDFeedNormalModel class]]){
        return [(BUDFeedNormalModel *)model cellHeight];
    }
    return 80;
}

#pragma mark - BUVideoAdViewDelegate
- (void)videoAdView:(BUVideoAdView *)videoAdView didLoadFailWithError:(NSError *_Nullable)error {
    BUD_Log(@"%s",__func__);
}

- (void)videoAdView:(BUVideoAdView *)videoAdView stateDidChanged:(BUPlayerPlayState)playerState {
    BUD_Log(@"%s",__func__);
}

- (void)playerDidPlayFinish:(BUVideoAdView *)videoAdView  {
    BUD_Log(@"%s",__func__);
}

- (void)videoAdViewDidClick:(BUVideoAdView *)videoAdView {
    BUD_Log(@"%s",__func__);
}

- (void)videoAdViewFinishViewDidClick:(BUVideoAdView *)videoAdView {
    BUD_Log(@"%s",__func__);
}

- (void)videoAdViewDidCloseOtherController:(BUVideoAdView *)videoAdView interactionType:(BUInteractionType)interactionType {
    BUD_Log(@"%s",__func__);
}

#pragma mark - BUNativeAdDelegate
- (void)nativeAd:(BUNativeAd *_Nullable)nativeAd dislikeWithReason:(NSArray<BUDislikeWords *> *_Nullable)filterWords {
    BUD_Log(@"click dislike");
    for (NSInteger i=0; i < self.dataSource.count; i++) {
        if ([[self.dataSource objectAtIndex:i] isKindOfClass:[GADUnifiedNativeAd class]]) {
            GADUnifiedNativeAd *gad_nativeAd = [self.dataSource objectAtIndex:i];
            BUNativeAd *temp = [gad_nativeAd.extraAssets objectForKey:BUDNativeAdTranslateKey];
            if (temp == nativeAd) {
                [self.dataSource removeObjectAtIndex:i];
                break;
            }
        }
    }
    [self.tableView reloadData];
}

- (void)nativeAdDidBecomeVisible:(BUNativeAd *)nativeAd {
    BUD_Log(@"%s",__func__);
}
- (void)nativeAdDidCloseOtherController:(BUNativeAd *)nativeAd interactionType:(BUInteractionType)interactionType {
    BUD_Log(@"%s",__func__);
}

- (void)nativeAdDidClick:(BUNativeAd *)nativeAd withView:(UIView *_Nullable)view {
    BUD_Log(@"%s",__func__);
}

#pragma mark - table View cell choose

/// get table view cell for normal feed
- (BUDFeedNormalTableViewCell *)getNormalFeedCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    NSUInteger index = indexPath.row;
    
    BUDFeedNormalModel *model = self.dataSource[index];
    // use the view of feed content
    NSString *clazz=[self classNameWithCellType:[(BUDFeedNormalModel *)model type]];
    BUDFeedNormalTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:clazz forIndexPath:indexPath];
    if(!cell){
        cell = [(BUDFeedNormalTableViewCell *)[NSClassFromString(clazz) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:clazz];
    }
    if (indexPath.row == 0) {
        cell.separatorLine.hidden = YES;
    }
    [cell refreshUIWithModel:model];
    return cell;
}

@end
