//
//  BUAFeedViewController.m
//  BUAemo
//
//  Created by chenren on 25/05/2017.
//  Copyright © 2017 chenren. All rights reserved.
//

#import "BUAFeedViewController.h"

#import <WMAdSDK/WMTableViewCell.h>
#import <WMAdSDK/WMNativeAdsManager.h>
#import "BUAFeedAdTableViewCell.h"

@interface BUAFeedViewController () <UITableViewDataSource, UITableViewDelegate, WMNativeAdsManagerDelegate, WMTableViewCellDelegate, WMVideoAdViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) WMNativeAdsManager *adManager;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation BUAFeedViewController

- (void)dealloc {
    _tableView.delegate = nil;
    _adManager.delegate = nil;
}

// 页面消失时候
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
    
    [self.tableView registerClass:[BUAFeedAdLeftTableViewCell class] forCellReuseIdentifier:@"BUAFeedAdLeftTableViewCell"];
    [self.tableView registerClass:[BUAFeedAdLargeTableViewCell class] forCellReuseIdentifier:@"BUAFeedAdLargeTableViewCell"];
    [self.tableView registerClass:[BUAFeedAdGroupTableViewCell class] forCellReuseIdentifier:@"BUAFeedAdGroupTableViewCell"];
    [self.tableView registerClass:[BUAFeedVideoAdTableViewCell class] forCellReuseIdentifier:@"BUAFeedVideoAdTableViewCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    [self loadNativeAds];
    
    NSMutableArray *datas = [NSMutableArray array];
    for (NSInteger i =0 ; i <= 37; i++) {
        [datas addObject:@"App的tableViewcell"];
    }
    self.dataSource = [datas copy];
    
    [self.tableView reloadData];
}

- (void)loadNativeAds {
    WMNativeAdsManager *nad = [WMNativeAdsManager new];
    WMAdSlot *slot1 = [[WMAdSlot alloc] init];
    slot1.ID = self.viewModel.slotID;
    slot1.AdType = WMAdSlotAdTypeFeed;
    slot1.position = WMAdSlotPositionTop;
    slot1.imgSize = [WMSize sizeBy:WMProposalSize_Feed690_388];
    slot1.isSupportDeepLink = YES;
    slot1.AdCount = 3;
    nad.adslot = slot1;
    
    nad.delegate = self;
    self.adManager = nad;
    
    [nad loadAdData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)nativeAdsManagerSuccessToLoad:(WMNativeAdsManager *)adsManager materialMeta:(NSArray<WMMaterialMeta *> *_Nullable)nativeAdDataArray {
    NSString *info = [NSString stringWithFormat:@"获取了%u条广告", nativeAdDataArray.count];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"广告" message:info delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
    
    [self.adManager registerTableView:self.tableView];
    NSMutableArray *dataSources = [self.dataSource mutableCopy];
    for (WMMaterialMeta *model in nativeAdDataArray) {
        NSUInteger index = rand() % dataSources.count;
        [dataSources insertObject:model atIndex:index];
    }
    self.dataSource = [dataSources copy];
    
    [self.tableView reloadData];
}

- (void)nativeAdsManager:(WMNativeAdsManager *)adsManager didFailWithError:(NSError *_Nullable)error {
    NSLog(@"%s %@", __PRETTY_FUNCTION__, error);
}

- (NSString *)identifiyWithModel:(WMMaterialMeta *)material {
    NSDictionary *cells = @{
                            @(WMFeedADModeSmallImage) : @"BUAFeedAdLeftTableViewCell",
                            @(WMFeedADModeGroupImage) : @"BUAFeedAdGroupTableViewCell",
                            @(WMFeedADModeLargeImage) : @"BUAFeedAdLargeTableViewCell",
                            @(WMFeedVideoAdModeImage) : @"BUAFeedLargeVideoTableViewCell",
                            @(WMFeedVideoAdModeImage) : @"BUAFeedVideoAdTableViewCell",
                            };
    return cells[@(material.imageMode)];
}

#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // For ad cells just as the ad cell provider, for normal cells do whatever you would do.
    Boolean isVideoCell = NO;
    NSUInteger index = indexPath.row;
    id model = self.dataSource[index];
    if ([model isKindOfClass:[WMMaterialMeta class]]) {
        WMMaterialMeta *adMeta = (WMMaterialMeta *)model;
        WMTableViewCell<BUAFeedCellProtocol> *cell = nil;
        if (adMeta.imageMode == WMFeedADModeSmallImage) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"BUAFeedAdLeftTableViewCell" forIndexPath:indexPath];
        } else if (adMeta.imageMode == WMFeedADModeLargeImage) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"BUAFeedAdLargeTableViewCell" forIndexPath:indexPath];
        } else if (adMeta.imageMode == WMFeedADModeGroupImage) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"BUAFeedAdGroupTableViewCell" forIndexPath:indexPath];
        } else if (adMeta.imageMode == WMFeedVideoAdModeImage) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"BUAFeedVideoAdTableViewCell" forIndexPath:indexPath];
            BUAFeedVideoAdTableViewCell *videoCell = (BUAFeedVideoAdTableViewCell *)cell;
            // 设置代理，用于监听播放状态
            videoCell.videoAdView.delegate = self;
            isVideoCell = YES;
        }
        if (cell) {
            cell.delegate = self;
            [cell refreshUIWithModel:adMeta];
            [cell registerViewForInteraction:cell];
            return cell;
        }
    }
    NSString *text = [NSString stringWithFormat:@"%@", model];
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = text;
    return cell;
}

// 视频划出屏幕暂停播放
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if ([cell isKindOfClass:[BUAFeedVideoAdTableViewCell class]]) {
        BUAFeedVideoAdTableViewCell *videoCell = (BUAFeedVideoAdTableViewCell *)cell;
        [videoCell wmCellDidEndDisplay];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    WMTableViewCell *cell = (WMTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[WMTableViewCell class]] && [cell respondsToSelector:@selector(didSelect)]) {
        [cell didSelect];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // The ad cell provider knows the height of ad cells based on its configuration
    NSUInteger index = indexPath.row;
    id model = self.dataSource[index];
    if ([model isKindOfClass:[WMMaterialMeta class]]) {
        WMMaterialMeta *adMeta = (WMMaterialMeta *)model;
        CGFloat width = CGRectGetWidth(self.tableView.bounds);
        if (adMeta.imageMode == WMFeedADModeSmallImage) {
            return [BUAFeedAdLeftTableViewCell cellHeightWithModel:adMeta width:width];
        } else if (adMeta.imageMode == WMFeedADModeLargeImage) {
            return [BUAFeedAdLargeTableViewCell cellHeightWithModel:adMeta width:width];
        } else if (adMeta.imageMode == WMFeedADModeGroupImage) {
            return [BUAFeedAdGroupTableViewCell cellHeightWithModel:adMeta width:width];
        } else if (adMeta.imageMode == WMFeedVideoAdModeImage) {
            return [BUAFeedVideoAdTableViewCell cellHeightWithModel:adMeta width:width];
        }
    }
    return 80;
}

#pragma mark

- (void)wmTableViewCellDidClick:(WMTableViewCell *)cell withView:(UIView *)view {
    NSString *str = cell.materialMeta.AdDescription;
    NSString *info = [NSString stringWithFormat:@"自定义点击了 %@", str];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"广告" message:info delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
}

- (void)wmTableViewCellDidBecomeVisible:(WMTableViewCell *)cell {
    NSLog(@"Ads-%@ has been witnessed!", cell.materialMeta);
}

- (void)wmTableViewCell:(WMTableViewCell *)cell dislikeWithReason:(NSArray<WMDislikeWords *> *)filterWords {
    NSIndexPath *adRow = [self.tableView indexPathForCell:cell];
    if (adRow) {
        NSMutableArray *dataSource = self.dataSource.mutableCopy;
        [dataSource removeObject:cell.materialMeta];
        self.dataSource = [dataSource copy];
        [self.tableView deleteRowsAtIndexPaths:@[adRow] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    // 视频广告点击 dislike 后暂停播放
    BUAFeedVideoAdTableViewCell *videoCell = (BUAFeedVideoAdTableViewCell *)cell;
    
    if ([videoCell isKindOfClass:[BUAFeedVideoAdTableViewCell class]]) {
        [videoCell.videoAdView pause];
    }
}

- (void)videoAdView:(WMVideoAdView *)videoAdView stateDidChanged:(WMPlayerPlayState)playerState {
    NSLog(@"videoAdView state change to %ld", (long)playerState);
}

- (void)videoAdView:(WMVideoAdView *)videoAdView didLoadFailWithError:(NSError *)error {
    NSLog(@"videoAdView didLoadFailWithError");
}

- (void)playerDidPlayFinish:(WMVideoAdView *)videoAdView {
    NSLog(@"videoAdView didPlayFinish");
}

@end
