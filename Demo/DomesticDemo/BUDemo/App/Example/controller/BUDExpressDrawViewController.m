//
//  BUDExpressDrawViewController.m
//  BUDemo
//
//  Created by Bytedance on 2019/7/29.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDExpressDrawViewController.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDDrawTableViewCell.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "BUDMacros.h"

@interface BUDExpressDrawViewController ()<UITableViewDataSource, UITableViewDelegate,BUNativeExpressAdViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataSource;
@property (nonatomic, strong) BUNativeExpressAdManager *nativeExpressAdManager;
@property (nonatomic ,strong)BUDDrawBaseTableViewCell *lastCell;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation BUDExpressDrawViewController

- (void)dealloc {
    _tableView.delegate = nil;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.pagingEnabled = YES;
#if defined(__IPHONE_11_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0
    if ([self.tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            self.tableView.estimatedRowHeight = 0;
        }
    }
#else
    self.automaticallyAdjustsScrollViewInsets = NO;
#endif
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"BUDNativeExpressCell"];
    [self.tableView registerClass:[BUDDrawNormalTableViewCell class] forCellReuseIdentifier:@"BUDDrawNormalTableViewCell"];
    [self.tableView registerClass:[BUDDrawAdTableViewCell class] forCellReuseIdentifier:@"BUDDrawAdTableViewCell"];
    [self.tableView registerClass:[BUDDrawBaseTableViewCell class] forCellReuseIdentifier:@"BUDDrawBaseTableViewCell"];
    
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
    // Do any additional setup after loading the view.
    [self loadData];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}

- (void)loadData {
    BUAdSlot *slot1 = [[BUAdSlot alloc] init];
    slot1.ID = self.viewModel.slotID;
    slot1.AdType = BUAdSlotAdTypeDrawVideo; //required
    slot1.isOriginAd = YES; //required
    slot1.imgSize = [BUSize sizeBy:BUProposalSize_DrawFullScreen];
    
    if (!self.nativeExpressAdManager) {
        self.nativeExpressAdManager = [[BUNativeExpressAdManager alloc] initWithSlot:slot1 adSize:self.view.bounds.size];
    }
    self.nativeExpressAdManager.delegate = self;
    [self.nativeExpressAdManager loadAdDataWithCount:3];
}

- (void)closeVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - BUNativeExpressAdViewDelegate
- (void)nativeExpressAdSuccessToLoad:(BUNativeExpressAdManager *)nativeExpressAd views:(NSArray<__kindof BUNativeExpressAdView *> *)views {
    if (views.count) {
        NSMutableArray *dataSources = [self.dataSource mutableCopy];
        [views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BUNativeExpressAdView *expressView = (BUNativeExpressAdView *)obj;
            expressView.rootViewController = self;
            // important: 此处会进行WKWebview的渲染，建议一次最多预加载三个广告，如果超过3个会很大概率导致WKWebview渲染失败。
            [expressView render];
            NSUInteger index = rand() % (self.dataSource.count-3)+2;
            [dataSources insertObject:expressView atIndex:index];
        }];
        self.dataSource = [dataSources copy];
    }
    [self.tableView reloadData];
}

- (void)nativeExpressAdFailToLoad:(BUNativeExpressAdManager *)nativeExpressAd error:(NSError *)error {
    BUD_Log(@"%s",__func__);
    NSLog(@"error code : %ld , error message : %@",(long)error.code,error.description);
}

- (void)nativeExpressAdViewRenderSuccess:(BUNativeExpressAdView *)nativeExpressAdView {
    [self.tableView reloadData];
    NSLog(@"====== %p videoDuration = %ld",nativeExpressAdView,(long)nativeExpressAdView.videoDuration);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCurrentPlayedTime) userInfo:nil repeats:YES];
        [self.timer fire];
    });
}

- (void)updateCurrentPlayedTime {
    for (id nativeExpressAdView in self.dataSource) {
        if ([nativeExpressAdView isKindOfClass:[BUNativeExpressAdView class]]) {
            BUNativeExpressAdView *adView = nativeExpressAdView;
            NSLog(@"====== %p currentPlayedTime = %f",nativeExpressAdView,adView.currentPlayedTime);
        }
    }
}

- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView stateDidChanged:(BUPlayerPlayState)playerState {
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"BUPlayerPlayState:%ld", (long)playerState]];
}

- (void)nativeExpressAdViewRenderFail:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *)error {
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"error:%@", error]];
}

- (void)nativeExpressAdViewWillShow:(BUNativeExpressAdView *)nativeExpressAdView {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressAdViewDidClick:(BUNativeExpressAdView *)nativeExpressAdView {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressAdViewPlayerDidPlayFinish:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *)error {
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"error:%@", error]];
}

- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressAdViewDidClosed:(BUNativeExpressAdView *)nativeExpressAdView {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressAdViewWillPresentScreen:(BUNativeExpressAdView *)nativeExpressAdView {
    [self pbud_logWithSEL:_cmd msg:@""];
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
    [self pbud_logWithSEL:_cmd msg:str];
}

- (void)pbud_logWithSEL:(SEL)sel msg:(NSString *)msg {
    BUD_Log(@"SDKDemoDelegate BUNativeExpressAdDrawView In VC (%@) extraMsg:%@", NSStringFromSelector(sel), msg);
}

#pragma mark --- tableView dataSource&delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger index = indexPath.row;
    id model = self.dataSource[index];
    if ([model isKindOfClass:[BUNativeExpressAdView class]]) {
        UITableViewCell *cell = nil;
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"BUDNativeExpressCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addAccessibilityIdentifier:model];
        // 重用BUNativeExpressAdView，先把之前的广告试图取下来，再添加上当前视图
        UIView *subView = (UIView *)[cell.contentView viewWithTag:1000];
        if ([subView superview]) {
            [subView removeFromSuperview];
        }
        
        UIView *view = model;
        view.tag = 1000;
        [cell.contentView addSubview:view];
        return cell;
    } else {
        BUDDrawNormalTableViewCell *cell = nil;
        cell = [tableView dequeueReusableCellWithIdentifier:@"BUDDrawNormalTableViewCell" forIndexPath:indexPath];
        cell.videoId = index;
        [cell refreshUIAtIndex:index];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger index = indexPath.row;
    id model = self.dataSource[index];
    if ([model isKindOfClass:[BUNativeExpressAdView class]]) {
        [self removeAccessibilityIdentifier:(BUNativeExpressAdView *)model];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [BUDDrawBaseTableViewCell cellHeight];
}

#pragma mark - AccessibilityIdentifier
- (void)addAccessibilityIdentifier:(BUNativeExpressAdView *)adView {
    adView.accessibilityIdentifier = @"express_draw_view";
}

- (void)removeAccessibilityIdentifier:(BUNativeExpressAdView *)adView {
    adView.accessibilityIdentifier = nil;
}
@end
