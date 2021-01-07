//
//  BUDFeedViewController.m
//  BUDemo
//
//  Created by chenren on 25/05/2017.
//  Copyright © 2017 chenren. All rights reserved.
//

#import "BUDFeedViewController.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDFeedAdTableViewCell.h"
#import "NSString+Json.h"
#import "BUDFeedNormalModel.h"
#import "BUDFeedNormalTableViewCell.h"
#import "BUDMacros.h"
#import "NSString+LocalizedString.h"
#import "BUDSwitchView.h"
#import <MJRefresh/MJRefresh.h>

@interface BUDFeedViewController () <UITableViewDataSource, UITableViewDelegate, BUNativeAdsManagerDelegate, BUVideoAdViewDelegate,BUNativeAdDelegate,BUNativeExpressAdViewDelegate>
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
    
    self.haveRenderSwitchView = YES;
    
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.tableView];
    
    __weak typeof(self) weakSelf = self;
    MJRefreshHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNativeAds];
    }];
    self.tableView.mj_header = refreshHeader;
    
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
    
   
    [self.tableView reloadData];
}

// 重置测试数据，非广告数据
- (void)pbud_resetDemoData {
    NSString *feedPath = [[NSBundle mainBundle] pathForResource:@"feedInfo" ofType:@"cactus"];
    NSString *s = [NSString stringWithContentsOfFile:feedPath encoding:NSUTF8StringEncoding error:nil];
    NSArray *datas = [s objectFromJSONString];

    self.dataSource = [NSMutableArray new];
    for (NSDictionary *dict in datas) {
       BUDFeedNormalModel *model = [[BUDFeedNormalModel alloc]initWithDict:dict];
       [self.dataSource addObject:model];
    }
    NSInteger datasCount = datas.count;
    if (datasCount > 3) {
       for (int i = 0; i < datasCount; i++) {
           NSUInteger index = rand() % (datasCount - 3) + 2;
           BUDFeedNormalModel *model = [[BUDFeedNormalModel alloc]initWithDict:[datas objectAtIndex:index]];
           [self.dataSource addObject:model];
       }
    }
}

- (void)loadNativeAds {
    [self pbud_resetDemoData];
    BUNativeAdsManager *nad = [BUNativeAdsManager new];
    BUAdSlot *slot1 = [[BUAdSlot alloc] init];
    slot1.ID = self.viewModel.slotID;
    slot1.AdType = BUAdSlotAdTypeFeed;
    slot1.supportRenderControl = self.renderSwitchView.on;
    slot1.imgSize = [BUSize sizeBy:BUProposalSize_Feed690_388];
    nad.adslot = slot1;
    nad.adSize = CGSizeMake(self.tableView.frame.size.width, 0);
    nad.delegate = self;
    nad.nativeExpressAdViewDelegate = self;
    self.adManager = nad;
    
    [nad loadAdDataWithCount:3];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    // 适配横竖屏
    CGRect tableVieRect = self.tableView.frame;
    self.tableView.frame = CGRectMake(CGRectGetMinX(tableVieRect), CGRectGetMinY(tableVieRect), size.width, size.height);
    [self.tableView reloadData];
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
        
    } else if ([model isKindOfClass:[UIView class]]) {
        
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 重用BUNativeExpressAdView，先把之前的广告试图取下来，再添加上当前视图
        UIView *subView = (UIView *)[cell.contentView viewWithTag:1000];
        if ([subView superview]) {
            [subView removeFromSuperview];
        }
        
        UIView *view = (UIView *)model;
        view.tag = 1000;
        [cell.contentView addSubview:view];
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
        if (width == BUMAXScreenSide && BUiPhoneX) {
            // 横屏刘海，减去左右安全区域
            if (@available(iOS 11.0, *)) {
                width = width - self.view.safeAreaInsets.left - self.view.safeAreaInsets.right;
            } else {
                // Fallback on earlier versions
            }
        }
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
    } else if ([model isKindOfClass:[UIView class]]) {
        UIView *view = (UIView *)model;
        return view.bounds.size.height;
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
    } else if ([model isKindOfClass:[UIView class]]) {
           UIView *view = (UIView *)model;
           return view.bounds.size.height;
       }
    return 80;
}


- (void)pbud_insertIntoDataSourceWithArray:(NSArray *)array {
    if (self.dataSource.count > 3) {
        for (id item in array) {
            NSUInteger index = rand() % (self.dataSource.count - 3) + 2;
            [self.dataSource insertObject:item atIndex:index];
        }
    }
}

#pragma mark - BUNativeAdsManagerDelegate

- (void)nativeAdsManagerSuccessToLoad:(BUNativeAdsManager *)adsManager nativeAds:(NSArray<BUNativeAd *> *_Nullable)nativeAdDataArray {
    [self pbud_insertIntoDataSourceWithArray:nativeAdDataArray];
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeAdsManagerDelegate" msg:[NSString stringWithFormat:@"native-count:%ld", (long)nativeAdDataArray.count]];
}



- (void)nativeAdsManager:(BUNativeAdsManager *)adsManager didFailWithError:(NSError *_Nullable)error {
    [self.tableView.mj_header endRefreshing];
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeAdsManagerDelegate" msg:[NSString stringWithFormat:@"error:%@", error]];
}
#pragma mark - BUNativeExpressAdViewDelegate
- (void)nativeExpressAdSuccessToLoad:(BUNativeExpressAdManager *)nativeExpressAd views:(NSArray<__kindof BUNativeExpressAdView *> *)views {
    [self.tableView.mj_header endRefreshing];
    [self pbud_insertIntoDataSourceWithArray:views];
    if (views.count) {
        [views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BUNativeExpressAdView *expressView = (BUNativeExpressAdView *)obj;
            expressView.rootViewController = self;
            // important: 此处会进行WKWebview的渲染，建议一次最多预加载三个广告，如果超过3个会很大概率导致WKWebview渲染失败。
            [expressView render];
        }];
    }
    [self.tableView reloadData];
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeExpressAdViewDelegate" msg:@""];
}

- (void)nativeExpressAdFailToLoad:(BUNativeExpressAdManager *)nativeExpressAd error:(NSError *)error {
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeExpressAdViewDelegate" msg:[NSString stringWithFormat:@"error:%@", error]];
}

- (void)nativeExpressAdViewRenderSuccess:(BUNativeExpressAdView *)nativeExpressAdView {
    [self.tableView reloadData];
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
    [self.dataSource removeObject:nativeExpressAdView];

    NSUInteger index = [self.dataSource indexOfObject:nativeExpressAdView];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
