//
//  BUDFeedViewController.m
//  BUDemo
//
//  Created by chenren on 25/05/2017.
//  Copyright © 2017 chenren. All rights reserved.
//

#import "BUDFeedViewController.h"

#import <BUAdSDK/BUNativeAdsManager.h>
#import "BUDFeedAdTableViewCell.h"

@interface BUDFeedViewController () <UITableViewDataSource, UITableViewDelegate, BUNativeAdsManagerDelegate, BUVideoAdViewDelegate,BUNativeAdDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) BUNativeAdsManager *adManager;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation BUDFeedViewController

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
    
    [self.tableView registerClass:[BUDFeedAdLeftTableViewCell class] forCellReuseIdentifier:@"BUDFeedAdLeftTableViewCell"];
    [self.tableView registerClass:[BUDFeedAdLargeTableViewCell class] forCellReuseIdentifier:@"BUDFeedAdLargeTableViewCell"];
    [self.tableView registerClass:[BUDFeedAdGroupTableViewCell class] forCellReuseIdentifier:@"BUDFeedAdGroupTableViewCell"];
    [self.tableView registerClass:[BUDFeedVideoAdTableViewCell class] forCellReuseIdentifier:@"BUDFeedVideoAdTableViewCell"];
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
    BUNativeAdsManager *nad = [BUNativeAdsManager new];
    BUAdSlot *slot1 = [[BUAdSlot alloc] init];
    slot1.ID = self.viewModel.slotID;
    slot1.AdType = BUAdSlotAdTypeFeed;
    slot1.position = BUAdSlotPositionTop;
    slot1.imgSize = [BUSize sizeBy:BUProposalSize_Feed690_388];
    slot1.isSupportDeepLink = YES;
    nad.adslot = slot1;
    nad.delegate = self;
    self.adManager = nad;
    
    [nad loadAdDataWithCount:3];
}

- (void)nativeAdsManagerSuccessToLoad:(BUNativeAdsManager *)adsManager nativeAds:(NSArray<BUNativeAd *> *_Nullable)nativeAdDataArray {
    NSString *info = [NSString stringWithFormat:@"获取了%tu条广告", nativeAdDataArray.count];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"广告" message:info delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
    
    NSMutableArray *dataSources = [self.dataSource mutableCopy];
    for (BUNativeAd *model in nativeAdDataArray) {
        NSUInteger index = rand() % dataSources.count;
        [dataSources insertObject:model atIndex:index];
    }
    self.dataSource = [dataSources copy];
    
    [self.tableView reloadData];
}

- (void)nativeAdsManager:(BUNativeAdsManager *)adsManager didFailWithError:(NSError *_Nullable)error {
    NSLog(@"%s %@", __PRETTY_FUNCTION__, error);
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // For ad cells just as the ad cell provider, for normal cells do whatever you would do.
    BOOL isVideoCell = NO;
    NSUInteger index = indexPath.row;
    id model = self.dataSource[index];
    if ([model isKindOfClass:[BUNativeAd class]]) {
        BUNativeAd *nativeAd = (BUNativeAd *)model;
        nativeAd.rootViewController = self;
        nativeAd.delegate = self;
        UITableViewCell<BUDFeedCellProtocol> *cell = nil;
        if (nativeAd.data.imageMode == BUFeedADModeSmallImage) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"BUDFeedAdLeftTableViewCell" forIndexPath:indexPath];
        } else if (nativeAd.data.imageMode == BUFeedADModeLargeImage) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"BUDFeedAdLargeTableViewCell" forIndexPath:indexPath];
        } else if (nativeAd.data.imageMode == BUFeedADModeGroupImage) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"BUDFeedAdGroupTableViewCell" forIndexPath:indexPath];
        } else if (nativeAd.data.imageMode == BUFeedVideoAdModeImage) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"BUDFeedVideoAdTableViewCell" forIndexPath:indexPath];
            // 设置代理，用于监听播放状态
            isVideoCell = YES;
        }
        
        BUInteractionType type = nativeAd.data.interactionType;
        if (cell) {
            [cell refreshUIWithModel:nativeAd];
            if (isVideoCell) {
                BUDFeedVideoAdTableViewCell *videoCell = (BUDFeedVideoAdTableViewCell *)cell;
                videoCell.nativeAdRelatedView.videoAdView.delegate = self;
                [nativeAd registerContainer:videoCell withClickableViews:@[videoCell.creativeButton]];
            } else {
                if (type == BUInteractionTypeDownload) {
                    [cell.customBtn setTitle:@"点击下载" forState:UIControlStateNormal];
                    [nativeAd registerContainer:cell withClickableViews:@[cell.customBtn]];
                } else if (type == BUInteractionTypePhone) {
                    [cell.customBtn setTitle:@"拨打电话" forState:UIControlStateNormal];
                    [nativeAd registerContainer:cell withClickableViews:@[cell.customBtn]];
                } else if (type == BUInteractionTypeURL) {
                    [cell.customBtn setTitle:@"外部拉起" forState:UIControlStateNormal];
                    [nativeAd registerContainer:cell withClickableViews:@[cell.customBtn]];
                } else if (type == BUInteractionTypePage) {
                    [cell.customBtn setTitle:@"内部拉起" forState:UIControlStateNormal];
                    [nativeAd registerContainer:cell withClickableViews:@[cell.customBtn]];
                } else {
                    [cell.customBtn setTitle:@"无点击" forState:UIControlStateNormal];
                }
            }
            return cell;
        }
    }
    NSString *text = [NSString stringWithFormat:@"%@", model];
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = text;
    return cell;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // The ad cell provider knows the height of ad cells based on its configuration
    NSUInteger index = indexPath.row;
    id model = self.dataSource[index];
    if ([model isKindOfClass:[BUNativeAd class]]) {
        BUNativeAd *nativeAd = (BUNativeAd *)model;
        CGFloat width = CGRectGetWidth(self.tableView.bounds);
        if (nativeAd.data.imageMode == BUFeedADModeSmallImage) {
            return [BUDFeedAdLeftTableViewCell cellHeightWithModel:nativeAd width:width];
        } else if (nativeAd.data.imageMode == BUFeedADModeLargeImage) {
            return [BUDFeedAdLargeTableViewCell cellHeightWithModel:nativeAd width:width];
        } else if (nativeAd.data.imageMode == BUFeedADModeGroupImage) {
            return [BUDFeedAdGroupTableViewCell cellHeightWithModel:nativeAd width:width];
        } else if (nativeAd.data.imageMode == BUFeedVideoAdModeImage) {
            return [BUDFeedVideoAdTableViewCell cellHeightWithModel:nativeAd width:width];
        }
    }
    return 80;
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger index = indexPath.row;
    id model = self.dataSource[index];
    if ([model isKindOfClass:[BUNativeAd class]]) {
        BUNativeAd *nativeAd = (BUNativeAd *)model;
        CGFloat width = CGRectGetWidth(self.tableView.bounds);
        if (nativeAd.data.imageMode == BUFeedADModeSmallImage) {
            return [BUDFeedAdLeftTableViewCell cellHeightWithModel:nativeAd width:width];
        } else if (nativeAd.data.imageMode == BUFeedADModeLargeImage) {
            return [BUDFeedAdLargeTableViewCell cellHeightWithModel:nativeAd width:width];
        } else if (nativeAd.data.imageMode == BUFeedADModeGroupImage) {
            return [BUDFeedAdGroupTableViewCell cellHeightWithModel:nativeAd width:width];
        } else if (nativeAd.data.imageMode == BUFeedVideoAdModeImage) {
            return [BUDFeedVideoAdTableViewCell cellHeightWithModel:nativeAd width:width];
        }
    }
    return 80;
}

#pragma mark
- (void)nativeAd:(BUNativeAd *)nativeAd dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords {
    NSMutableArray *dataSources = [self.dataSource mutableCopy];
    [dataSources removeObject:nativeAd];
    self.dataSource = [dataSources copy];
    [self.tableView reloadData];
}

- (void)videoAdView:(BUVideoAdView *)videoAdView stateDidChanged:(BUPlayerPlayState)playerState {
    NSLog(@"videoAdView state change to %ld", (long)playerState);
}

- (void)videoAdView:(BUVideoAdView *)videoAdView didLoadFailWithError:(NSError *)error {
    NSLog(@"videoAdView didLoadFailWithError");
}

- (void)playerDidPlayFinish:(BUVideoAdView *)videoAdView {
    NSLog(@"videoAdView didPlayFinish");
}

@end
