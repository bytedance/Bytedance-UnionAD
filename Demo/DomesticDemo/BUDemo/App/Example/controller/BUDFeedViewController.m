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
#ifdef DEBUG
#import <MBProgressHUD/MBProgressHUD.h>
#endif
#import "NSBundle+BUDemo.h"
@interface BUDFeedViewController () <UITableViewDataSource, UITableViewDelegate, BUNativeAdsManagerDelegate, BUVideoAdViewDelegate,BUNativeAdDelegate,BUNativeExpressAdViewDelegate, BUDFeedCustomDislikeDelgate>
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) BUNativeAdsManager *adManager;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, assign) NSInteger insertIndex;

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
    NSString *feedPath = [NSBundle csjDemoResource_pathForResource:@"feedInfo" ofType:@"cactus"];
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
           NSUInteger index = arc4random() % (datasCount - 3) + 2;
           BUDFeedNormalModel *model = [[BUDFeedNormalModel alloc]initWithDict:[datas objectAtIndex:index]];
           [self.dataSource addObject:model];
       }
    }
    
    self.insertIndex = 3;
}

- (void)loadNativeAds {
    [self pbud_resetDemoData];
    BUAdSlot *slot1 = [[BUAdSlot alloc] init];
    slot1.ID = self.viewModel.slotID;
    slot1.AdType = BUAdSlotAdTypeFeed;
    slot1.supportRenderControl = self.renderSwitchView.on;
    slot1.imgSize = [BUSize sizeBy:BUProposalSize_Feed690_388];
    BUNativeAdsManager *nad = [[BUNativeAdsManager alloc]initWithSlot:slot1];
    nad.adSize = CGSizeMake(self.tableView.frame.size.width, 0);
    // 不支持中途更改代理，中途更改代理会导致接收不到广告相关回调，如若存在中途更改代理场景，需自行处理相关逻辑，确保广告相关回调正常执行。
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
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    // 适配横竖屏
    CGRect tableVieRect = self.tableView.frame;
    self.tableView.frame = CGRectMake(CGRectGetMinX(tableVieRect), CGRectGetMinY(tableVieRect), size.width, size.height);
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // For ad cells just as the ad cell provider, for normal cells do whatever you would do.
    NSUInteger index = indexPath.row;
    if (index >= self.dataSource.count) {
        return [UITableViewCell new];
    }
    UITableViewCell *resultCell = nil;
    id model = self.dataSource[index];
    if ([model isKindOfClass:[BUNativeAd class]]) {
        resultCell = [self pbud_cellWithTableView:self.tableView indexPath:indexPath nativeAd:model];
    } else if ([model isKindOfClass:[BUDFeedNormalModel class]]) {
        resultCell = [self pbud_cellWithTableView:self.tableView indexPath:indexPath feedNormalModel:model];
    } else if ([model isKindOfClass:[UIView class]]) {
        resultCell = [self pbud_cellWithTableView:self.tableView indexPath:indexPath customView:model];
    }
    if (resultCell == nil) {
        resultCell = [[UITableViewCell alloc] init];
        resultCell.textLabel.text = [NSString localizedStringForKey:Unknown];
    }
    return resultCell;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
}



#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // The ad cell provider knows the height of ad cells based on its configuration
    CGFloat resultHeight = 0;
    NSUInteger index = indexPath.row;
    id model = self.dataSource[index];
    if ([model isKindOfClass:[BUNativeAd class]]) {
        resultHeight = [self pbud_heightWithTableView:self.tableView indexPath:indexPath nativeAd:model];
    } else if ([model isKindOfClass:[BUDFeedNormalModel class]]){
        resultHeight = [(BUDFeedNormalModel *)model cellHeight];
    } else if ([model isKindOfClass:[UIView class]]) {
        UIView *view = (UIView *)model;
        resultHeight = view.bounds.size.height;
    }
    return resultHeight;
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self tableView:tableView heightForRowAtIndexPath:indexPath];
}



#pragma mark - UITableView DataSource & Delegate auxiliary
- (CGFloat)pbud_heightWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath nativeAd:(BUNativeAd *)nativeAd {
    CGFloat width = CGRectGetWidth(self.tableView.bounds);
    if (width == BUDMAXScreenSide && BUDiPhoneX) {
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
    } else if (nativeAd.data.imageMode == BUFeedVideoAdModeImage || nativeAd.data.imageMode == BUFeedVideoAdModePortrait || nativeAd.data.imageMode == BUFeedADModeLiveStream) {
        return [BUDFeedVideoAdTableViewCell cellHeightWithModel:nativeAd width:width];
    } else if (nativeAd.data.imageMode == BUFeedADModeSquareImage) {
        return [BUDFeedAdSquareImgTableViewCell cellHeightWithModel:nativeAd width:width];
    } else if (nativeAd.data.imageMode == BUFeedADModeSquareVideo) {
        return [BUDFeedSquareVideoAdTableViewCell cellHeightWithModel:nativeAd width:width];
    }
    return 80;
}

- (UITableViewCell *)pbud_cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath customView:(UIView *)customView {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 重用BUNativeExpressAdView，先把之前的广告试图取下来，再添加上当前视图
    UIView *subView = (UIView *)[cell.contentView viewWithTag:1000];
    if ([subView superview]) {
        [subView removeFromSuperview];
    }
    
    UIView *view = (UIView *)customView;
    view.tag = 1000;
    [cell.contentView addSubview:view];
    return cell;
}
- (UITableViewCell *)pbud_cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath nativeAd:(BUNativeAd *)nativeAd {
    BOOL isVideoCell = NO;
    nativeAd.rootViewController = self;
    nativeAd.delegate = self;
    UITableViewCell<BUDFeedCellProtocol> *cell = nil;
    if (nativeAd.data.imageMode == BUFeedADModeSmallImage) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"BUDFeedAdLeftTableViewCell" forIndexPath:indexPath];
    } else if (nativeAd.data.imageMode == BUFeedADModeLargeImage || nativeAd.data.imageMode == BUFeedADModeImagePortrait) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"BUDFeedAdLargeTableViewCell" forIndexPath:indexPath];
    } else if (nativeAd.data.imageMode == BUFeedADModeGroupImage) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"BUDFeedAdGroupTableViewCell" forIndexPath:indexPath];
    } else if (nativeAd.data.imageMode == BUFeedVideoAdModeImage || nativeAd.data.imageMode ==  BUFeedVideoAdModePortrait || nativeAd.data.imageMode ==  BUFeedADModeLiveStream) {
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
            if (nativeAd.data.imageMode == BUFeedVideoAdModeImage || nativeAd.data.imageMode ==  BUFeedVideoAdModePortrait || nativeAd.data.imageMode ==  BUFeedADModeLiveStream) {
                BUDFeedVideoAdTableViewCell *videoCell = (BUDFeedVideoAdTableViewCell *)cell;
                videoCell.nativeAdRelatedView.mediaAdView.delegate = self;
                [nativeAd registerContainer:videoCell withClickableViews:@[videoCell.creativeButton]];
            } else if (nativeAd.data.imageMode == BUFeedADModeSquareVideo) {
                BUDFeedSquareVideoAdTableViewCell *videoCell = (BUDFeedSquareVideoAdTableViewCell *)cell;
                videoCell.nativeAdRelatedView.mediaAdView.delegate = self;
                [nativeAd registerContainer:videoCell withClickableViews:@[videoCell.creativeButton]];
            }
        } else {
            if (type == BUInteractionTypeDownload) {
                [cell.customBtn setTitle:[NSString localizedStringForKey:ClickDownload] forState:UIControlStateNormal];
                [nativeAd registerContainer:cell withClickableViews:@[cell.customBtn]];
            } else if (type == BUInteractionTypeURL) {
                [cell.customBtn setTitle:[NSString localizedStringForKey:ExternalLink] forState:UIControlStateNormal];
                [nativeAd registerContainer:cell withClickableViews:@[cell.customBtn]];
            } else if (type == BUInteractionTypePage) {
                [cell.customBtn setTitle:[NSString localizedStringForKey:InternalLink] forState:UIControlStateNormal];
                [nativeAd registerContainer:cell withClickableViews:@[cell.customBtn]];
            } else {
                [cell.customBtn setTitle:[NSString localizedStringForKey:NoClick] forState:UIControlStateNormal];
                [nativeAd registerContainer:cell withClickableViews:@[cell.customBtn]];
            }
        }
        cell.delegate = self;
    }
    return cell;
}
- (UITableViewCell *)pbud_cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath feedNormalModel:(BUDFeedNormalModel *)feedNormalModel {
    NSString *clazz=[self pbud_classNameWithCellType:[feedNormalModel type]];
    BUDFeedNormalTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:clazz forIndexPath:indexPath];
    if(!cell){
        cell = [(BUDFeedNormalTableViewCell *)[NSClassFromString(clazz) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:clazz];
    }
    if (indexPath.row == 0) {
        cell.separatorLine.hidden = YES;
    }
    [cell refreshUIWithModel:feedNormalModel];
    return cell;
}


- (NSString *)pbud_classNameWithCellType:(NSString *)type {
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

- (void)pbud_insertIntoDataSourceWithArray:(NSArray<BUNativeAd *> *)array {
    if (self.dataSource.count > 3) {
        for (BUNativeAd *item in array) {
            if (item.isNativeExpress) {
                item.nativeExpressAdView.rootViewController = self;
                [self.dataSource insertObject:item.nativeExpressAdView atIndex:self.insertIndex];
            } else {
                [self.dataSource insertObject:item atIndex:self.insertIndex];
            }
            self.insertIndex += 3;
        }
    }
}


#pragma mark - BUDFeedCustomDislikeDelgate
- (void)feedCustomDislike:(BUDFeedAdBaseTableViewCell *)cell withNativeAd:(BUNativeAd *)nativeAd didSlected:(BUDislikeWords *)dislikeWord {
    // 自定义dislike
    NSMutableArray *dataSources = [self.dataSource mutableCopy];
    [dataSources removeObject:nativeAd];
    self.dataSource = [dataSources copy];
    [self.tableView reloadData];
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeAdDelegate" msg:@""];
}

#pragma mark - BUNativeAdsManagerDelegate

- (void)nativeAdsManagerSuccessToLoad:(BUNativeAdsManager *)adsManager nativeAds:(NSArray<BUNativeAd *> *_Nullable)nativeAdDataArray {
    [self pbud_insertIntoDataSourceWithArray:nativeAdDataArray];
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
    for (BUNativeAd *nativeAd in nativeAdDataArray) {
        [nativeAd render];
    }
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeAdsManagerDelegate" msg:[NSString stringWithFormat:@"native-count:%ld", (long)nativeAdDataArray.count]];
}



- (void)nativeAdsManager:(BUNativeAdsManager *)adsManager didFailWithError:(NSError *_Nullable)error {
    [self.tableView.mj_header endRefreshing];
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeAdsManagerDelegate" msg:[NSString stringWithFormat:@"error:%@", error]];
}
#pragma mark - BUNativeExpressAdViewDelegate
- (void)nativeExpressAdViewRenderSuccess:(BUNativeExpressAdView *)nativeExpressAdView {
    [self.tableView reloadData];
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeExpressAdViewDelegate" msg:[NSString stringWithFormat:@"nativeExpressAdView.videoDuration:%ld", (long)nativeExpressAdView.videoDuration]];
}


- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView stateDidChanged:(BUPlayerPlayState)playerState {
    [self pbud_logWithSEL:_cmd prefix:@"BUNativeExpressAdViewDelegate" msg:[NSString stringWithFormat:@"playerState:%ld", (long)playerState]];
}

- (void)nativeExpressAdViewRenderFail:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *)error {
    [self.dataSource removeObject:nativeExpressAdView];
    [self.tableView reloadData];
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
#ifdef DEBUG
    [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view.window];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"温馨提示";
    hud.detailsLabel.text = @"强制关闭广告，开发者请做好布局处理";
    [hud hideAnimated:YES afterDelay:1.5];
#endif
    NSMutableArray *dataSources = [self.dataSource mutableCopy];
    [dataSources removeObject:nativeAd];
    self.dataSource = [dataSources copy];
    [self.tableView reloadData];
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
    BUD_Log(@"SDKDemoDelegate Native Feed %@ In VC (%@) extraMsg:%@", prefix, NSStringFromSelector(sel), msg);
}
@end
