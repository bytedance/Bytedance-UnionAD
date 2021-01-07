//
//  BUDExpressFeedViewController.m
//  BUADDemo
//
//  Created by bytedance_yuanhuan on 2019/1/21.
//  Copyright © 2019年 Bytedance. All rights reserved.
//

#import "BUDExpressFeedViewController.h"
#import <BUAdSDK/BUNativeExpressAdManager.h>
#import <BUAdSDK/BUNativeExpressAdView.h>
#import "BUDMacros.h"
#import "BUDNormalButton.h"
#import "UIView+Draw.h"
#import "NSString+LocalizedString.h"
#import "BUDSlotID.h"

@interface BUDExpressFeedViewController () <BUNativeExpressAdViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray<__kindof BUNativeExpressAdView *> *expressAdViews;
@property (strong, nonatomic) BUNativeExpressAdManager *nativeExpressAdManager;
@property (strong, nonatomic) UILabel *widthLabel;
@property (strong, nonatomic) UISlider *widthSlider;
@property (strong, nonatomic) UILabel *heightLabel;
@property (strong, nonatomic) UISlider *heightSlider;
@property (strong, nonatomic) UISlider *adCountSlider;
@property (strong, nonatomic) UILabel *adCountLabel;
@property (strong, nonatomic) BUDNormalButton *freshButton;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) BUDSwitchView *slotSwitchView;
@end

// 方便将来测试用
#define BUD_FeedDistributionNumber      2
#define BUD_FeedDefaultCellHeight       44


@implementation BUDExpressFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.haveRenderSwitchView = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.expressAdViews = [NSMutableArray new];
    [self setupViews];
    
    [self loadData];
    [self addAccessibilityIdentifier];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}

- (void)setupViews {
    CGFloat x = 20;
    CGFloat y = 5.0;
    const CGFloat spaceY = 10;
    
    self.widthLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 60, 21)];
    self.widthLabel.textColor = titleBGColor;
    self.widthLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.widthLabel];
    
    self.widthSlider = [[UISlider alloc] initWithFrame:CGRectMake(self.widthLabel.right+10, y-5, self.view.width-self.widthLabel.right-10-x, 31)];
    self.widthSlider.maximumValue = CGRectGetWidth(self.view.frame);
    self.widthSlider.tintColor = mainColor;
    [self.view addSubview:self.widthSlider];
    y += 21 + spaceY;

    self.heightLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 60, 21)];
    self.heightLabel.font = [UIFont systemFontOfSize:15];
    self.heightLabel.textColor = titleBGColor;
    [self.view addSubview:self.heightLabel];
    
    self.heightSlider = [[UISlider alloc] initWithFrame:CGRectMake(self.widthSlider.left, y-5, self.widthSlider.width, 31)];
    self.heightSlider.maximumValue = CGRectGetHeight(self.view.frame);
    self.heightSlider.tintColor = mainColor;
    [self.view addSubview:self.heightSlider];
    y += 21 + spaceY;

    self.adCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 60, 21)];
    self.adCountLabel.font = [UIFont systemFontOfSize:15];
    self.adCountLabel.textColor = titleBGColor;
    [self.view addSubview:self.adCountLabel];
    
    self.adCountSlider = [[UISlider alloc] initWithFrame:CGRectMake(self.widthSlider.left, y-5, self.widthSlider.width, 31)];
    self.adCountSlider.maximumValue = 3;
    self.adCountSlider.minimumValue = 1;
    self.adCountSlider.tintColor = mainColor;
    [self.view addSubview:self.adCountSlider];
    
    y += 22 + spaceY;
    self.slotSwitchView = [[BUDSwitchView alloc] initWithTitle:@"是否是模板slot" on:YES height:44];
    CGRect frame = self.slotSwitchView.frame;
    frame.origin.y = y;
    self.slotSwitchView.frame = frame;
    [self.view addSubview:self.slotSwitchView];
    
    y += 21 + 2*spaceY;

    self.freshButton = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, y, 0, 0)];
    self.freshButton.showRefreshIncon = YES;
    [self.freshButton setTitle:[NSString localizedStringForKey:LoadedAd] forState:UIControlStateNormal];
    [self.freshButton addTarget:self action:@selector(loadData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.freshButton];
    
    CGFloat tableViewY = CGRectGetMaxY(self.freshButton.frame) + 2*spaceY;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, tableViewY, CGRectGetWidth(self.view.frame), BUScreenHeight - kBUDefaultNavigationBarHeight - tableViewY) style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"BUDNativeExpressCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"BUDSplitNativeExpressCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];

    self.widthSlider.value = [UIScreen mainScreen].bounds.size.width;
    self.heightSlider.value = 0;
    self.adCountSlider.value = 3;
    
    self.widthLabel.text = [NSString localizedStringWithFormat:@"%@%@", [NSString localizedStringForKey:Width], @(self.widthSlider.value)];
    self.heightLabel.text = [NSString localizedStringWithFormat:@"%@%@", [NSString localizedStringForKey:Height], @(self.heightSlider.value)];
    self.adCountLabel.text = [NSString stringWithFormat:@"count:%@", @(self.adCountSlider.value)];
    
    [self.widthSlider addTarget:self action:@selector(sliderPositionWChanged) forControlEvents:UIControlEventValueChanged];
    [self.heightSlider addTarget:self action:@selector(sliderPositionHChanged) forControlEvents:UIControlEventValueChanged];
    [self.adCountSlider addTarget:self action:@selector(sliderPositionCountChanged) forControlEvents:UIControlEventValueChanged];
}

- (void)loadData {
    
    if (!self.expressAdViews) {
        self.expressAdViews = [NSMutableArray arrayWithCapacity:20];
    }
    BUAdSlot *slot1 = [[BUAdSlot alloc] init];
    NSString *slotId = self.slotSwitchView.on ? self.viewModel.slotID : native_feed_ID;
    slot1.ID = slotId;
    slot1.AdType = BUAdSlotAdTypeFeed;
    slot1.supportRenderControl = YES;
    BUSize *imgSize = [BUSize sizeBy:BUProposalSize_Feed228_150];
    slot1.imgSize = imgSize;
    slot1.position = BUAdSlotPositionFeed;
    
    // self.nativeExpressAdManager可以重用
    if (!self.nativeExpressAdManager) {
        self.nativeExpressAdManager = [[BUNativeExpressAdManager alloc] initWithSlot:slot1 adSize:CGSizeMake(self.widthSlider.value, self.heightSlider.value)];
    }
    self.nativeExpressAdManager.delegate = self;
    NSInteger count = (NSInteger)self.adCountSlider.value;
    [self.nativeExpressAdManager loadAdDataWithCount:count];
}

- (void)sliderPositionWChanged {
    self.widthLabel.text = [NSString localizedStringWithFormat:@"%@%.0f", [NSString localizedStringForKey:Width], self.widthSlider.value];
}

- (void)sliderPositionHChanged {
    self.heightLabel.text = [NSString localizedStringWithFormat:@"%@%.0f", [NSString localizedStringForKey:Height], self.heightSlider.value];
}

- (void)sliderPositionCountChanged {
    self.adCountLabel.text = [NSString stringWithFormat:@"count:%d",(int)self.adCountSlider.value];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

#pragma mark - BUNativeExpressAdViewDelegate
- (void)nativeExpressAdSuccessToLoad:(BUNativeExpressAdManager *)nativeExpressAd views:(NSArray<__kindof BUNativeExpressAdView *> *)views {
    [self.expressAdViews removeAllObjects];//【重要】不能保存太多view，需要在合适的时机手动释放不用的，否则内存会过大
    if (views.count) {

        [self.expressAdViews addObjectsFromArray:views];
//        [self.expressAdViews addObject:views.firstObject];
        [views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BUNativeExpressAdView *expressView = (BUNativeExpressAdView *)obj;
            expressView.rootViewController = self;
            // important: 此处会进行WKWebview的渲染，建议一次最多预加载三个广告，如果超过3个会很大概率导致WKWebview渲染失败。
            [expressView render];
//            *stop = YES;
        }];
    }
    [self.tableView reloadData];
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressAdFailToLoad:(BUNativeExpressAdManager *)nativeExpressAd error:(NSError *)error {
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"error:%@", error]];
}

- (void)nativeExpressAdViewRenderSuccess:(BUNativeExpressAdView *)nativeExpressAdView {
    [self.tableView reloadData];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCurrentPlayedTime) userInfo:nil repeats:YES];
        [self.timer fire];
    });
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"nativeExpressAdView.videoDuration:%ld", (long)nativeExpressAdView.videoDuration]];
}

- (void)updateCurrentPlayedTime {
    for (BUNativeExpressAdView *nativeExpressAdView in self.expressAdViews) {
        [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"nativeExpressAdView.currentPlayedTime:%.4f", nativeExpressAdView.currentPlayedTime]];
    }
}

- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView stateDidChanged:(BUPlayerPlayState)playerState {
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"playerState:%ld", (long)playerState]];
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
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords {//【重要】需要在点击叉以后 在这个回调中移除视图，否则，会出现用户点击叉无效的情况
    [self.expressAdViews removeObject:nativeExpressAdView];

    NSUInteger index = [self.expressAdViews indexOfObject:nativeExpressAdView];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
    BUD_Log(@"SDKDemoDelegate BUNativeExpressFeedAdView In VC (%@) extraMsg:%@", NSStringFromSelector(sel), msg);
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % BUD_FeedDistributionNumber == 0) {
        UIView *view = [self.expressAdViews objectAtIndex:indexPath.row / BUD_FeedDistributionNumber];
        return view.bounds.size.height;
    }
    else {
        return BUD_FeedDefaultCellHeight;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.expressAdViews.count * BUD_FeedDistributionNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.row % BUD_FeedDistributionNumber == 0) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"BUDNativeExpressCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 重用BUNativeExpressAdView，先把之前的广告试图取下来，再添加上当前视图
        UIView *subView = (UIView *)[cell.contentView viewWithTag:1000];
        if ([subView superview]) {
            [subView removeFromSuperview];
        }
        
        UIView *view = [self.expressAdViews objectAtIndex:indexPath.row / BUD_FeedDistributionNumber];
        view.tag = 1000;
        [self addAccessibilityIdentifier:view];
        [cell.contentView addSubview:view];
    } else {
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"BUDSplitNativeExpressCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    UIView *view = [cell.contentView viewWithTag:1000];
    if (view) {
        [self removeAccessibilityIdentifier:view];
    }
}

#pragma mark - AccessibilityIdentifier
- (void)addAccessibilityIdentifier {
    self.widthSlider.accessibilityIdentifier = @"expressFeed_width";
    self.heightSlider.accessibilityIdentifier = @"expressFeed_height";
    self.adCountSlider.accessibilityIdentifier = @"expressFeed_count";
}

- (void)addAccessibilityIdentifier:(UIView *)adView {
    adView.accessibilityIdentifier = @"express_feed_view";
}

- (void)removeAccessibilityIdentifier:(UIView *)adView {
    adView.accessibilityIdentifier = nil;
}
@end
