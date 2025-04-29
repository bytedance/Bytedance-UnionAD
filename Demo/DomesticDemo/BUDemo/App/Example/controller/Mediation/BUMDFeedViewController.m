//
//  BUMDFeedViewController.m
//  BUDemo
//
//  Created by ByteDance on 2022/10/23.
//  Copyright © 2022 bytedance. All rights reserved.
//

#import "BUMDFeedViewController.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUMDFeedAdTableViewCell.h"
#import "BUMDFeedNormalTableViewCell.h"
#import "BUDSlotID.h"
#import "BUDMacros.h"
#import "NSString+LocalizedString.h"
#import "NSBundle+BUDemo.h"

@interface BUMDFeedViewController ()<UITableViewDataSource, UITableViewDelegate, BUMNativeAdsManagerDelegate, BUMNativeAdDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) BUNativeAdsManager *adManager;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIButton *showAndRefreshAd;
@property (nonatomic, strong) NSArray<BUNativeAd *> *nativeAdDataArray;
@end

@implementation BUMDFeedViewController

- (void)dealloc {
    BUImageMediation *a = nil;
    if (self.adManager) {
        [self.adManager.mediation destory];
    }
    _tableView.delegate = nil;
    _adManager.delegate = nil;
    _adManager = nil;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 弹幕功能使用相关
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveWidgetNotification:) name:BUMMediaAdWidgetViewCreateNotificationName object:nil];
    
    CGFloat width  = 300;
    CGFloat height = 60;
    CGFloat x = (CGRectGetWidth(self.view.frame) - width) / 2;
    CGFloat y = 10;
    _showAndRefreshAd = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [self.view addSubview:_showAndRefreshAd];
    [_showAndRefreshAd addTarget:self action:@selector(refreshAdAndShow) forControlEvents:UIControlEventTouchUpInside];
    [_showAndRefreshAd setTitle:@"Feed show or refresh" forState:UIControlStateNormal];
    [_showAndRefreshAd setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _showAndRefreshAd.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    
    UILabel *separator = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_showAndRefreshAd.frame) + 10 , CGRectGetWidth(self.view.frame), 1)];
    separator.backgroundColor = [UIColor blackColor];
    [self.view addSubview:separator];
    
    CGFloat versionBottom = 0;
    versionBottom = CGRectGetMaxY(separator.frame) + 10;
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, versionBottom, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - versionBottom)];
    [self.view addSubview:self.tableView];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.tableView registerClass:[BUMDFeedAdLeftTableViewCell class] forCellReuseIdentifier:@"BUMDFeedAdLeftTableViewCell"];
    [self.tableView registerClass:[BUMDFeedAdLargeTableViewCell class] forCellReuseIdentifier:@"BUMDFeedAdLargeTableViewCell"];
    [self.tableView registerClass:[BUMDFeedAdGroupTableViewCell class] forCellReuseIdentifier:@"BUMDFeedAdGroupTableViewCell"];
    [self.tableView registerClass:[BUMDFeedVideoAdTableViewCell class] forCellReuseIdentifier:@"BUMDFeedVideoAdTableViewCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerClass:[BUMDFeedNormalTableViewCell class] forCellReuseIdentifier:@"BUMDFeedNormalTableViewCell"];
    [self.tableView registerClass:[BUMDFeedNormalTitleTableViewCell class] forCellReuseIdentifier:@"BUMDFeedNormalTitleTableViewCell"];
    [self.tableView registerClass:[BUMDFeedNormalTitleImgTableViewCell class] forCellReuseIdentifier:@"BUMDFeedNormalTitleImgTableViewCell"];
    [self.tableView registerClass:[BUMDFeedNormalBigImgTableViewCell class] forCellReuseIdentifier:@"BUMDFeedNormalBigImgTableViewCell"];
    [self.tableView registerClass:[BUMDFeedNormalthreeImgsableViewCell class] forCellReuseIdentifier:@"BUMDFeedNormalthreeImgsableViewCell"];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self refreshAdAndShow];
}

- (void)refreshAdAndShow {

    NSString *feedPath = [NSBundle csjDemoResource_pathForResource:@"feedInfo" ofType:@"cactus"];
    NSString *s = [NSString stringWithContentsOfFile:feedPath encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [s dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *datas = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

    self.dataSource = [NSMutableArray new];
    for (NSDictionary *dict in datas) {
        BUMDFeedNormalModel *model = [[BUMDFeedNormalModel alloc]initWithDict:dict];
        [self.dataSource addObject:model];
    }
    for (int i = 0; i < datas.count; i++) {
        NSUInteger index = rand() % (datas.count - 3) + 2;
        BUMDFeedNormalModel *model = [[BUMDFeedNormalModel alloc] initWithDict:datas[index]];
        [self.dataSource addObject:model];
    }
    
    [self.tableView reloadData];
    if ([self.tableView numberOfRowsInSection:0]) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    [self loadNativeAds];
}

// Demo中定义的广告加载方法，在Demo中点击加载广告后触发该方法
- (void)loadNativeAds {
#warning Every time the data is requested, a new one BUMNativeAdsManager needs to be initialized. Duplicate request data by the same  video ad is not allowed.
    
    if (self.adManager) {
        [self.adManager.mediation destory];
    }
    
    BUAdSlot *slot1 = [[BUAdSlot alloc] init];
    BUSize *imgSize1 = [[BUSize alloc] init];
    imgSize1.width = 1080;
    imgSize1.height = 1920;
    slot1.imgSize = imgSize1;
    
    slot1.ID = gromore_feed_ID;
    // 如果是模板广告，返回高度将不一定是300，而是按照414和对应代码位在平台的配置计算出的高度
    slot1.adSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 400);
    // [可选]配置：静音
    slot1.mediation.mutedIfCan = YES;
    
    self.adManager = [[BUNativeAdsManager alloc] initWithSlot:slot1];
    // 配置：跳转控制器
    self.adManager.mediation.rootViewController = self;
    // 配置：回调代理对象
    self.adManager.delegate = self;
    // 开始加载广告
    [self.adManager loadAdDataWithCount:3];
}

# pragma mark ---<BUMNativeAdsManagerDelegate>---
- (void)nativeAdsManagerSuccessToLoad:(BUNativeAdsManager *)adsManager nativeAds:(NSArray<BUNativeAd *> *_Nullable)nativeAdDataArray{
    BUD_Log(@"%s:%ld", __func__, nativeAdDataArray.count);

    self.nativeAdDataArray = nativeAdDataArray;
    
    for (BUNativeAd *model in nativeAdDataArray) {
        NSUInteger index = rand() % (self.dataSource.count - 3) + 2;

        model.rootViewController = self;
        model.delegate = self;
        if (model.mediation.isExpressAd) {
            [model.mediation render];
        }

        /*  (注意: getShowEcpmInfo 只需要在当前 adView show 之后调用, show 之前调用该方法会返回 nil)
        BUMRitInfo *info = [model.mediation getShowEcpmInfo];
        BUD_Log(@"ecpm:%@", info.ecpm);
        BUD_Log(@"platform:%@", info.adnName);
        BUD_Log(@"ritID:%@", info.slotID);
        BUD_Log(@"requestID:%@", info.requestID ?: @"None");
         */
        
        BUDictionary *mediaExt = model.mediation.extraData;
        if (mediaExt) {
//            BUD_Log(@"coupon:%@", mediaExt[@"coupon"]);
//            BUD_Log(@"live_room:%@", mediaExt[@"live_room"]);
//            BUD_Log(@"product:%@", mediaExt[@"product"]);
        }
        
        BUD_Log(@"getAdLoadInfoList:%@", [adsManager.mediation getAdLoadInfoList]);

        [self.dataSource insertObject:model atIndex:index];
    }
    
    [self.tableView reloadData];
}

- (void)didReceiveWidgetNotification:(NSNotification *)notify {
    BUMAdViewWidget *widget = notify.userInfo[BUMMediaAdBarrageViewCreator];
    if (widget) {
        CGFloat x1 = 6;
        CGFloat y1 = widget.adView.frame.size.height - 20;
        CGRect newFrame1;
        newFrame1.origin.x = x1;
        newFrame1.origin.y = y1;
        newFrame1.size.height = 100;
        newFrame1.size.width = self.view.frame.size.width;
        
        UIView *barrageView = [widget renderWithFrame:newFrame1];
        if (barrageView) {
            [widget.adView addSubview:barrageView];
        }
    }
    
    
    BUMAdViewWidget *suspensionWidget = notify.userInfo[BUMMediaAdCouponSuspensionViewCreator];
    if (suspensionWidget) {
        BUMCouponType type1 = suspensionWidget.couponType;
        // 调整尺寸 & 位置,添加到页面
        CGFloat x2 = 6;
        CGFloat y2 = widget.adView.frame.size.height - (type1 == BUMCouponSuspensionCard ?  124 : type1 == BUMCouponSuspensionIcon ? 102 : 102) - 20;
        CGRect newFrame2 = widget.adView.frame;
        newFrame2.origin.x = x2;
        newFrame2.origin.y = y2;
        
        UIView *suspensionView = [suspensionWidget renderWithFrame:newFrame2];
        if (suspensionView) {
            [widget.adView addSubview:suspensionView];
        }
    }
    
    
    BUMAdViewWidget *flipWidget = notify.userInfo[BUMMediaAdCouponFlipViewCreator];
    if (flipWidget) {
        // 调整尺寸 & 位置,添加到页面
        CGFloat x = flipWidget.adView.frame.size.width - 154;
        CGFloat y = flipWidget.adView.frame.size.height - 154;
        CGRect newFrame = flipWidget.adView.frame;
        newFrame.origin.x = x;
        newFrame.origin.y = y;
        UIView *flipView = [flipWidget renderWithFrame:newFrame];
        if (flipView) {        
            [widget.adView addSubview:flipView];
        }
    }
}

- (void)nativeAdsManager:(BUNativeAdsManager *)adsManager didFailWithError:(NSError *_Nullable)error {
    BUD_Log(@"%s:%@", __func__, error);
}

# pragma mark ---<BUMNativeAdViewDelegate>---

- (void)nativeAdDidBecomeVisible:(BUNativeAd *)nativeAd {
    BUD_Log(@"%s", __func__);
    
    // 展示后可获取信息如下
    BUMRitInfo *info = [nativeAd.mediation getShowEcpmInfo];
    BUD_Log(@"ecpm:%@", info.ecpm);
    BUD_Log(@"platform:%@", info.adnName);
    BUD_Log(@"ritID:%@", info.slotID);
    BUD_Log(@"requestID:%@", info.requestID ?: @"None");
}

- (void)nativeAdDidClick:(BUNativeAd *)nativeAd withView:(UIView *)view {
    BUD_Log(@"%s", __func__);
}

- (void)nativeAdWillPresentFullScreenModal:(BUNativeAd *)nativeAd {
    BUD_Log(@"%s", __func__);
}

- (void)nativeAdDidCloseOtherController:(BUNativeAd *)nativeAd interactionType:(BUInteractionType)interactionType {
    BUD_Log(@"%s", __func__);
}

- (void)nativeAdExpressViewRenderSuccess:(BUNativeAd *)nativeAd   {
    [self.tableView reloadData];
    BUD_Log(@"%s", __func__);
}

- (void)nativeAdExpressViewRenderFail:(BUNativeAd *)nativeAd error:(NSError *)error {
    BUD_Log(@"%s:%@", __func__, error);
}

- (void)nativeAd:(BUNativeAd *_Nullable)nativeAd dislikeWithReason:(NSArray<BUDislikeWords *> *_Nullable)filterWords {
    BUD_Log(@"%s", __func__);

    // !!!视图需要移除
    [self.dataSource removeObject:nativeAd];
    
    for (UITableViewCell *cell in self.tableView.visibleCells) {
        if ([cell isKindOfClass:BUMDFeedAdBaseTableViewCell.class]) {
            ((BUMDFeedAdBaseTableViewCell *)cell).nativeAdView = nil;
        }
        if ([cell.contentView viewWithTag:1000]) {
            [[cell.contentView viewWithTag:1000] removeFromSuperview];
        }
    }
    
    [nativeAd.mediation.canvasView removeFromSuperview];
    nativeAd = nil;
    
    [self.tableView reloadData];
    
}

- (void)nativeAd:(BUNativeAd *)nativeAd adContainerViewDidRemoved:(UIView *)adContainerView {
    BUD_Log(@"%s", __func__);
}

/**
 This method is called when videoadview playback status changed.
 @param playerState : player state after changed
 */
- (void)nativeAdVideo:(BUNativeAd *)nativeAd stateDidChanged:(BUPlayerPlayState)playerState {
    BUD_Log(@"%s:%ld", __func__, (long)playerState);
}

/**
 This method is called when videoadview's finish view is clicked.
 */
- (void)nativeAdVideoDidClick:(BUNativeAd *_Nullable)nativeAd {
    BUD_Log(@"%s", __func__);
}

/**
 This method is called when videoadview end of play.
 */
- (void)nativeAdVideoDidPlayFinish:(BUNativeAd *_Nullable)nativeAd {
    BUD_Log(@"%s", __func__);
}

# pragma mark ---<UITableViewDelegate>---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL isVideoCell = NO;
    NSUInteger index = (NSUInteger) indexPath.row;
    id model = self.dataSource[index];

    if ([model isKindOfClass:[BUNativeAd class]]) {
        BUNativeAd *nativeAd = (BUNativeAd *)model;
        nativeAd.mediation.canvasView.tag = 1000;

        UITableViewCell<BUMDFeedCellProtocol> *cell = nil;

        if (nativeAd.mediation.isExpressAd) {
            // 模板视图
            cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            // 重用BUNativeExpressAdView，先把之前的广告试图取下来，再添加上当前视图
            UIView *subView = [cell.contentView viewWithTag:1000];
            if ([subView superview]) {
                [subView removeFromSuperview];
            }

            [cell.contentView addSubview:nativeAd.mediation.canvasView];
            return cell;
        } else {
            // 自渲染
            if (nativeAd.data.imageMode == BUMFeedADModeSmallImage) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"BUMDFeedAdLeftTableViewCell" forIndexPath:indexPath];
            } else if (nativeAd.data.imageMode == BUMFeedADModeLargeImage ||
                       nativeAd.data.imageMode == BUMFeedADModeImagePortrait) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"BUMDFeedAdLargeTableViewCell" forIndexPath:indexPath];
            } else if (nativeAd.data.imageMode == BUMFeedADModeGroupImage) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"BUMDFeedAdGroupTableViewCell" forIndexPath:indexPath];
            } else if (nativeAd.data.imageMode == BUMFeedVideoAdModeImage ||
                       nativeAd.data.imageMode == BUMFeedVideoAdModePortrait) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"BUMDFeedVideoAdTableViewCell" forIndexPath:indexPath];
                // Set the delegate to listen for status of video
                isVideoCell = YES;
            }

            if (cell) {
                cell.tag = indexPath.row;
                
                __weak typeof(self) ws = self;
                cell.cellClose = ^(NSInteger index, BUMDFeedAdBaseTableViewCell *cell) {
                    __strong typeof(ws) self = ws;
                    if (index < self.dataSource.count) {
                        cell.nativeAdView = nil;
                        [self.dataSource removeObjectAtIndex:(NSUInteger) index];
                        [self.tableView reloadData];
                    }
                };

                [cell refreshUIWithModel:nativeAd];
                
                return cell;
            }
        }

        
    } else if ([model isKindOfClass:[BUMDFeedNormalModel class]]) {
        NSString *clazz = [self classNameWithCellType:[(BUMDFeedNormalModel *)model type]];

        BUMDFeedNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:clazz forIndexPath:indexPath];
        if (!cell) {
            cell = [(BUMDFeedNormalTableViewCell *)[NSClassFromString(clazz) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:clazz];
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
    if ([type isEqualToString:@"title"]) {
        return @"BUMDFeedNormalTitleTableViewCell";
    } else if ([type isEqualToString:@"titleImg"]) {
        return @"BUMDFeedNormalTitleImgTableViewCell";
    } else if ([type isEqualToString:@"bigImg"]) {
        return @"BUMDFeedNormalBigImgTableViewCell";
    } else if ([type isEqualToString:@"threeImgs"]) {
        return @"BUMDFeedNormalthreeImgsableViewCell";
    } else {
        return @"unkownCell";
    }
}

#pragma mark ---<UITableViewDelegate>---
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // The ad cell provider knows the height of ad cells based on its configuration
    NSUInteger index = (NSUInteger) indexPath.row;
    id model = self.dataSource[index];

    CGFloat height = 150;
    if ([model isKindOfClass:[BUNativeAd class]]) {
        BUNativeAd *nativeAdView = (BUNativeAd *)model;
        CGFloat width = CGRectGetWidth(self.tableView.bounds);

        if (nativeAdView.mediation.isExpressAd) {
            height = nativeAdView.mediation.canvasView.bounds.size.height;
        } else {
            if (nativeAdView.data.imageMode == BUMFeedADModeSmallImage) {
                height = [BUMDFeedAdLeftTableViewCell cellHeightWithModel:nativeAdView width:width];
            } else if (nativeAdView.data.imageMode == BUMFeedADModeLargeImage || nativeAdView.data.imageMode == BUMFeedADModeImagePortrait) {
                height = [BUMDFeedAdLargeTableViewCell cellHeightWithModel:nativeAdView width:width];
            } else if (nativeAdView.data.imageMode == BUMFeedADModeGroupImage) {
                height = [BUMDFeedAdGroupTableViewCell cellHeightWithModel:nativeAdView width:width];
            } else if (nativeAdView.data.imageMode == BUMFeedVideoAdModeImage) {
                height = [BUMDFeedVideoAdTableViewCell cellHeightWithModel:nativeAdView width:width];
            }
        }
    } else if ([model isKindOfClass:[BUMDFeedNormalModel class]]) {
        height = [(BUMDFeedNormalModel *)model cellHeight];
    }

    if (height <= 0) {
        height = 150;
    }
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger index = (NSUInteger) indexPath.row;
    id model = self.dataSource[index];

    CGFloat height = 150;
    if ([model isKindOfClass:[BUNativeAd class]]) {
        BUNativeAd *nativeAdView = (BUNativeAd *)model;
        CGFloat width = CGRectGetWidth(self.tableView.bounds);

        if (nativeAdView.mediation.isExpressAd) {
            height = nativeAdView.mediation.canvasView.bounds.size.height;
        } else {
            if (nativeAdView.data.imageMode == BUMFeedADModeSmallImage) {
                height =  [BUMDFeedAdLeftTableViewCell cellHeightWithModel:nativeAdView width:width];
            } else if (nativeAdView.data.imageMode == BUMFeedADModeLargeImage ||
                       nativeAdView.data.imageMode == BUMFeedADModeImagePortrait) {
                height =  [BUMDFeedAdLargeTableViewCell cellHeightWithModel:nativeAdView width:width];
            } else if (nativeAdView.data.imageMode == BUMFeedADModeGroupImage) {
                height =  [BUMDFeedAdGroupTableViewCell cellHeightWithModel:nativeAdView width:width];
            } else if (nativeAdView.data.imageMode == BUMFeedVideoAdModeImage) {
                height =  [BUMDFeedVideoAdTableViewCell cellHeightWithModel:nativeAdView width:width];
            }
        }
    } else if ([model isKindOfClass:[BUMDFeedNormalModel class]]) {
        height =  [(BUMDFeedNormalModel *)model cellHeight];
    }

    if (height <= 0) {
        height = 150;
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *visiblePath = [self.tableView indexPathsForVisibleRows];

    if ([visiblePath containsObject:indexPath]) {
        if ([self.dataSource count] > indexPath.row) {
            id model = nil;
            model = self.dataSource[(NSUInteger) indexPath.row];

            if ([model isKindOfClass:[BUNativeAd class]]) {
                return;
            }
        }
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *visiblePath = [self.tableView indexPathsForVisibleRows];

    if (![visiblePath containsObject:indexPath]) {
        if ([self.dataSource count] > indexPath.row) {
            id model = nil;
            model = self.dataSource[(NSUInteger) indexPath.row];

            if ([model isKindOfClass:[BUNativeAd class]]) {
                return;
            }
        }
    }
}

@end

