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
#import "NSString+Json.h"
#import "BUDFeedNormalModel.h"
#import "BUDFeedNormalTableViewCell.h"
#import "BUDMacros.h"
#import "NSString+LocalizedString.h"

@interface BUDFeedViewController () <UITableViewDataSource, UITableViewDelegate, BUNativeAdsManagerDelegate, BUVideoAdViewDelegate,BUNativeAdDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) BUNativeAdsManager *adManager;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation BUDFeedViewController

- (void)dealloc {
    _tableView.delegate = nil;
    _adManager.delegate = nil;
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
    
    [self.tableView registerClass:[BUDFeedAdLeftTableViewCell class] forCellReuseIdentifier:@"BUDFeedAdLeftTableViewCell"];
    [self.tableView registerClass:[BUDFeedAdLargeTableViewCell class] forCellReuseIdentifier:@"BUDFeedAdLargeTableViewCell"];
    [self.tableView registerClass:[BUDFeedAdGroupTableViewCell class] forCellReuseIdentifier:@"BUDFeedAdGroupTableViewCell"];
    [self.tableView registerClass:[BUDFeedVideoAdTableViewCell class] forCellReuseIdentifier:@"BUDFeedVideoAdTableViewCell"];
    [self.tableView registerClass:[BUDFeedNormalTableViewCell class] forCellReuseIdentifier:@"BUDFeedNormalTableViewCell"];
    [self.tableView registerClass:[BUDFeedNormalTitleTableViewCell class] forCellReuseIdentifier:@"BUDFeedNormalTitleTableViewCell"];
    [self.tableView registerClass:[BUDFeedNormalTitleImgTableViewCell class] forCellReuseIdentifier:@"BUDFeedNormalTitleImgTableViewCell"];
    [self.tableView registerClass:[BUDFeedNormalBigImgTableViewCell class] forCellReuseIdentifier:@"BUDFeedNormalBigImgTableViewCell"];
    [self.tableView registerClass:[BUDFeedNormalthreeImgsableViewCell class] forCellReuseIdentifier:@"BUDFeedNormalthreeImgsableViewCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    //方图
    [self.tableView registerClass:[BUDFeedAdSquareImgTableViewCell class] forCellReuseIdentifier:@"BUDFeedAdSquareImgTableViewCell"];
    //方视频
    [self.tableView registerClass:[BUDFeedSquareVideoAdTableViewCell class] forCellReuseIdentifier:@"BUDFeedSquareVideoAdTableViewCell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self loadNativeAds];
    
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
        } else if (nativeAd.data.imageMode == BUFeedADModeLargeImage || nativeAd.data.imageMode == BUFeedADModeImagePortrait) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"BUDFeedAdLargeTableViewCell" forIndexPath:indexPath];
        } else if (nativeAd.data.imageMode == BUFeedADModeGroupImage) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"BUDFeedAdGroupTableViewCell" forIndexPath:indexPath];
        } else if (nativeAd.data.imageMode == BUFeedVideoAdModeImage || nativeAd.data.imageMode ==  BUFeedVideoAdModePortrait) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"BUDFeedVideoAdTableViewCell" forIndexPath:indexPath];
            // Set the delegate to listen for status of video
            isVideoCell = YES;
        } else if (nativeAd.data.imageMode == BUFeedADModeSquareImage) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"BUDFeedAdSquareImgTableViewCell" forIndexPath:indexPath];
        } else if (nativeAd.data.imageMode == BUFeedADModeSquareVideo) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"BUDFeedSquareVideoAdTableViewCell" forIndexPath:indexPath];
            isVideoCell = YES;
        }
        
        BUInteractionType type = nativeAd.data.interactionType;
        if (cell) {
            [cell refreshUIWithModel:nativeAd];
            if (isVideoCell) {
                if (nativeAd.data.imageMode == BUFeedVideoAdModeImage || nativeAd.data.imageMode ==  BUFeedVideoAdModePortrait) {
                    BUDFeedVideoAdTableViewCell *videoCell = (BUDFeedVideoAdTableViewCell *)cell;
                    videoCell.nativeAdRelatedView.videoAdView.delegate = self;
                    [nativeAd registerContainer:videoCell withClickableViews:@[videoCell.creativeButton]];
                } else if (nativeAd.data.imageMode == BUFeedADModeSquareVideo) {
                    BUDFeedSquareVideoAdTableViewCell *videoCell = (BUDFeedSquareVideoAdTableViewCell *)cell;
                    videoCell.nativeAdRelatedView.videoAdView.delegate = self;
                    [nativeAd registerContainer:videoCell withClickableViews:@[videoCell.creativeButton]];
                }
            } else {
                if (type == BUInteractionTypeDownload) {
                    [cell.customBtn setTitle:[NSString localizedStringForKey:ClickDownload] forState:UIControlStateNormal];
                    [nativeAd registerContainer:cell withClickableViews:@[cell.customBtn]];
                } else if (type == BUInteractionTypePhone) {
                    [cell.customBtn setTitle:[NSString localizedStringForKey:Call] forState:UIControlStateNormal];
                    [nativeAd registerContainer:cell withClickableViews:@[cell.customBtn]];
                } else if (type == BUInteractionTypeURL) {
                    [cell.customBtn setTitle:[NSString localizedStringForKey:ExternalLink] forState:UIControlStateNormal];
                    [nativeAd registerContainer:cell withClickableViews:@[cell.customBtn]];
                } else if (type == BUInteractionTypePage) {
                    [cell.customBtn setTitle:[NSString localizedStringForKey:InternalLink] forState:UIControlStateNormal];
                    [nativeAd registerContainer:cell withClickableViews:@[cell.customBtn]];
                } else {
                    [cell.customBtn setTitle:[NSString localizedStringForKey:NoClick] forState:UIControlStateNormal];
                }
            }
            return cell;
        }
    }else if ([model isKindOfClass:[BUDFeedNormalModel class]]){
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
    // The ad cell provider knows the height of ad cells based on its configuration
    NSUInteger index = indexPath.row;
    id model = self.dataSource[index];
    if ([model isKindOfClass:[BUNativeAd class]]) {
        BUNativeAd *nativeAd = (BUNativeAd *)model;
        CGFloat width = CGRectGetWidth(self.tableView.bounds);
        if (nativeAd.data.imageMode == BUFeedADModeSmallImage) {
            return [BUDFeedAdLeftTableViewCell cellHeightWithModel:nativeAd width:width];
        } else if (nativeAd.data.imageMode == BUFeedADModeLargeImage || nativeAd.data.imageMode == BUFeedADModeImagePortrait) {
            return [BUDFeedAdLargeTableViewCell cellHeightWithModel:nativeAd width:width];
        } else if (nativeAd.data.imageMode == BUFeedADModeGroupImage) {
            return [BUDFeedAdGroupTableViewCell cellHeightWithModel:nativeAd width:width];
        } else if (nativeAd.data.imageMode == BUFeedVideoAdModeImage || nativeAd.data.imageMode == BUFeedVideoAdModePortrait) {
            return [BUDFeedVideoAdTableViewCell cellHeightWithModel:nativeAd width:width];
        } else if (nativeAd.data.imageMode == BUFeedADModeSquareImage) {
            return [BUDFeedAdSquareImgTableViewCell cellHeightWithModel:nativeAd width:width];
        } else if (nativeAd.data.imageMode == BUFeedADModeSquareVideo) {
            return [BUDFeedSquareVideoAdTableViewCell cellHeightWithModel:nativeAd width:width];
        }
    }else if ([model isKindOfClass:[BUDFeedNormalModel class]]){
        return [(BUDFeedNormalModel *)model cellHeight];
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
        } else if (nativeAd.data.imageMode == BUFeedADModeLargeImage || nativeAd.data.imageMode == BUFeedADModeImagePortrait) {
            return [BUDFeedAdLargeTableViewCell cellHeightWithModel:nativeAd width:width];
        } else if (nativeAd.data.imageMode == BUFeedADModeGroupImage) {
            return [BUDFeedAdGroupTableViewCell cellHeightWithModel:nativeAd width:width];
        } else if (nativeAd.data.imageMode == BUFeedVideoAdModeImage || nativeAd.data.imageMode == BUFeedVideoAdModePortrait) {
            return [BUDFeedVideoAdTableViewCell cellHeightWithModel:nativeAd width:width];
        } else if (nativeAd.data.imageMode == BUFeedADModeSquareImage) {
            return [BUDFeedAdSquareImgTableViewCell cellHeightWithModel:nativeAd width:width];
        } else if (nativeAd.data.imageMode == BUFeedADModeSquareVideo) {
            return [BUDFeedSquareVideoAdTableViewCell cellHeightWithModel:nativeAd width:width];
        }
    }else if ([model isKindOfClass:[BUDFeedNormalModel class]]){
        return [(BUDFeedNormalModel *)model cellHeight];
    }
    return 80;
}

#pragma mark - BUNativeAdsManagerDelegate

- (void)nativeAdsManagerSuccessToLoad:(BUNativeAdsManager *)adsManager nativeAds:(NSArray<BUNativeAd *> *_Nullable)nativeAdDataArray {
    for (BUNativeAd *model in nativeAdDataArray) {
        NSUInteger index = rand() % (self.dataSource.count-3)+2;
        [self.dataSource insertObject:model atIndex:index];
    }
    
    [self.tableView reloadData];
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeAdsManagerDelegate" msg:[NSString stringWithFormat:@"native-count:%ld", (long)nativeAdDataArray.count]];
}

- (void)nativeAdsManager:(BUNativeAdsManager *)adsManager didFailWithError:(NSError *_Nullable)error {
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeAdsManagerDelegate" msg:[NSString stringWithFormat:@"error:%@", error]];
}
#pragma mark - BUNativeAdDelegate
- (void)nativeAdDidLoad:(BUNativeAd *)nativeAd {
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
    NSMutableArray *dataSources = [self.dataSource mutableCopy];
    [dataSources removeObject:nativeAd];
    self.dataSource = [dataSources copy];
    [self.tableView reloadData];
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeAdDelegate" msg:@""];
}


#pragma mark - BUVideoAdViewDelegate

- (void)videoAdView:(BUVideoAdView *)videoAdView stateDidChanged:(BUPlayerPlayState)playerState {
    
    [self pbud_logWithSEL:_cmd prefix:@"BUVideoAdViewDelegate" msg:[NSString stringWithFormat:@"playerState:%ld", (long)playerState]];
}

- (void)videoAdView:(BUVideoAdView *)videoAdView didLoadFailWithError:(NSError *)error {
    [self pbud_logWithSEL:_cmd prefix:@"BUVideoAdViewDelegate" msg:[NSString stringWithFormat:@"error:%@", error]];
}

- (void)playerDidPlayFinish:(BUVideoAdView *)videoAdView {
    [self pbud_logWithSEL:_cmd prefix:@"BUVideoAdViewDelegate" msg:@""];
}

- (void)videoAdViewDidClick:(BUVideoAdView *)videoAdView {
    [self pbud_logWithSEL:_cmd prefix:@"BUVideoAdViewDelegate" msg:@""];
}

- (void)videoAdViewFinishViewDidClick:(BUVideoAdView *)videoAdView {
    [self pbud_logWithSEL:_cmd prefix:@"BUVideoAdViewDelegate" msg:@""];
}


- (void)videoAdViewDidCloseOtherController:(BUVideoAdView *)videoAdView interactionType:(BUInteractionType)interactionType {
    [self pbud_logWithSEL:_cmd prefix:@"BUVideoAdViewDelegate" msg:[NSString stringWithFormat:@"interactionType:%ld", (long)interactionType]];
}


#pragma mark - Log
- (void)pbud_logWithSEL:(SEL)sel prefix:(NSString *)prefix msg:(NSString *)msg {
    BUD_Log(@"SDKDemoDelegate Native Feed %@ In VC (%@) extraMsg:%@", prefix, NSStringFromSelector(sel), msg);
}
@end
