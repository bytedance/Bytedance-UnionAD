//
//  BUDDrawVideoViewController.m
//  BUDemo
//
//  Created by iCuiCui on 2018/9/20.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDDrawVideoViewController.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDDrawTableViewCell.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "BUDMacros.h"
#import "UIColor+DarkMode.h"

@interface BUDDrawVideoViewController ()<UITableViewDataSource, UITableViewDelegate, BUNativeAdsManagerDelegate, BUVideoAdViewDelegate,BUNativeAdDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) BUNativeAdsManager *adManager;
@property (nonatomic, copy) NSArray *dataSource;
@property (nonatomic ,strong)BUDDrawBaseTableViewCell *lastCell;
@end

@implementation BUDDrawVideoViewController

- (void)dealloc {
    _tableView.delegate = nil;
    _adManager.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.bud_systemBackgroundColor;
    
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.pagingEnabled = YES;
    self.tableView.scrollsToTop = NO;
#if defined(__IPHONE_11_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0
    if ([self.tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
#else
    self.automaticallyAdjustsScrollViewInsets = NO;
#endif
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[BUDDrawNormalTableViewCell class] forCellReuseIdentifier:@"BUDDrawNormalTableViewCell"];
    [self.tableView registerClass:[BUDDrawAdTableViewCell class] forCellReuseIdentifier:@"BUDDrawAdTableViewCell"];
    [self.tableView registerClass:[BUDDrawBaseTableViewCell class] forCellReuseIdentifier:@"BUDDrawBaseTableViewCell"];
    
    [self loadNativeAds];
    
    NSMutableArray *datas = [NSMutableArray array];
    for (NSInteger i =0 ; i <= 15; i++) {
        [datas addObject:@"App tableViewcell"];
    }
    self.dataSource = [datas copy];
    
    [self.tableView reloadData];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(13, 34, 30, 30);
    [btn setImage:[UIImage imageNamed:@"draw_back.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(closeVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view bringSubviewToFront:btn];
    [self.view addSubview:btn];
    btn.accessibilityIdentifier = @"draw_back";
}

- (void)closeVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark -- adsManager
- (void)loadNativeAds {
    BUAdSlot *slot1 = [[BUAdSlot alloc] init];
    slot1.ID = self.viewModel.slotID;
    slot1.AdType = BUAdSlotAdTypeDrawVideo; //required
    slot1.imgSize = [BUSize sizeBy:BUProposalSize_DrawFullScreen];
    BUNativeAdsManager *nad = [[BUNativeAdsManager alloc]initWithSlot:slot1];
    // 不支持中途更改代理，中途更改代理会导致接收不到广告相关回调，如若存在中途更改代理场景，需自行处理相关逻辑，确保广告相关回调正常执行。
    nad.delegate = self;
    self.adManager = nad;
    
    [nad loadAdDataWithCount:3];
}
- (void)nativeAdsManagerSuccessToLoad:(BUNativeAdsManager *)adsManager nativeAds:(NSArray<BUNativeAd *> *_Nullable)nativeAdDataArray {
    
    BUD_Log(@"DrawVideo datas load success");
    NSMutableArray *dataSources = [self.dataSource mutableCopy];
    for (BUNativeAd *model in nativeAdDataArray) {
        NSUInteger index = rand() % dataSources.count;
        [dataSources insertObject:model atIndex:index];
    }
    self.dataSource = [dataSources copy];
    
    [self.tableView reloadData];
}

- (void)nativeAdsManager:(BUNativeAdsManager *)adsManager didFailWithError:(NSError *_Nullable)error {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.offset = CGPointMake(0, -100);
    hud.label.text = @"DrawVideo datas load faiule";
    [hud hideAnimated:YES afterDelay:1];
    BUD_Log(@"DrawVideo datas load faiule");
    NSLog(@"error code : %ld , error message : %@",(long)error.code,error.description);
}

- (void)nativeAdDidClick:(BUNativeAd *)nativeAd withView:(UIView *)view {
    BUD_Log(@"DrawVideo %s",__func__);
}
#pragma mark --- BUVideoAdViewDelegate

- (void)videoAdViewFinishViewDidClick:(BUVideoAdView *)videoAdView {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"finishView is clicked" message:[NSString stringWithFormat:@"%s",__func__] delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
    [alert show];
#pragma clang diagnostic pop
}
/**
 This method is called when videoadview failed to play.
 @param error : the reason of error
 */
- (void)videoAdView:(BUVideoAdView *)videoAdView didLoadFailWithError:(NSError *_Nullable)error {
    BUD_Log(@"DrawVideo %s",__func__);
}

/**
 This method is called when videoadview ready to play.
 */
- (void)playerReadyToPlay:(BUVideoAdView *)videoAdView {
    BUD_Log(@"DrawVideo %s",__func__);
}

/**
 This method is called when videoadview playback status changed.
 @param playerState : player state after changed
 */
- (void)videoAdView:(BUVideoAdView *)videoAdView stateDidChanged:(BUPlayerPlayState)playerState {
    BUD_Log(@"DrawVideo %s",__func__);
}

/**
 This method is called when the countdown of reward video rewards starts
 @param countDown : countdown of reward video rewards
 @Note : This method is only useful in China area.
 */
- (void)videoAdView:(BUVideoAdView *)videoAdView rewardDidCountDown:(NSInteger)countDown {
    BUD_Log(@"DrawVideo %s",__func__);
}


/**
 This method is called when videoadview end of play.
 */
- (void)playerDidPlayFinish:(BUVideoAdView *)videoAdView {
    BUD_Log(@"DrawVideo %s",__func__);
}

/**
 This method is called when videoadview is clicked.
 */
- (void)videoAdViewDidClick:(BUVideoAdView *)videoAdView {
    BUD_Log(@"DrawVideo %s",__func__);
}

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)videoAdViewDidCloseOtherController:(BUVideoAdView *)videoAdView interactionType:(BUInteractionType)interactionType {
    BUD_Log(@"DrawVideo %s",__func__);
}

#pragma mark --- tableView dataSource&delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger index = indexPath.row;
    id model = self.dataSource[index];
    if ([model isKindOfClass:[BUNativeAd class]]) {
        BUNativeAd *nativeAd = (BUNativeAd *)model;
        nativeAd.rootViewController = self;
        nativeAd.delegate = self;
        BUDDrawAdTableViewCell *cell = nil;
        cell = [tableView dequeueReusableCellWithIdentifier:@"BUDDrawAdTableViewCell" forIndexPath:indexPath];
        cell.nativeAdRelatedView.videoAdView.delegate = self;
        [cell refreshUIWithModel:nativeAd];
        cell.nativeAdRelatedView.videoAdView.delegate = self;
        [model registerContainer:cell withClickableViews:@[cell.creativeButton,cell.titleLabel,cell.descriptionLabel,cell.headImg]];
        
        return cell;
    }else{
        BUDDrawNormalTableViewCell *cell = nil;
        cell = [tableView dequeueReusableCellWithIdentifier:@"BUDDrawNormalTableViewCell" forIndexPath:indexPath];
        cell.videoId = index;
        [cell refreshUIAtIndex:index];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [BUDDrawBaseTableViewCell cellHeight];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
