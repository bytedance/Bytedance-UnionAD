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
@end

@implementation BUDExpressFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.expressAdViews = [NSMutableArray new];
    [self setupViews];
    
    [self loadData];
    [self addAccessibilityIdentifier];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}

- (void)setupViews {
    CGFloat x = 20;
    CGFloat y = 20 + NavigationBarHeight;
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
    y += 21 + 2*spaceY;

    self.freshButton = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, y, 0, 0)];
    self.freshButton.showRefreshIncon = YES;
    [self.freshButton setTitle:[NSString localizedStringForKey:LoadedAd] forState:UIControlStateNormal];
    [self.freshButton addTarget:self action:@selector(loadData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.freshButton];
    
    CGFloat tableViewY = CGRectGetMaxY(self.freshButton.frame) + 2*spaceY;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, tableViewY, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - tableViewY) style:UITableViewStylePlain];
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
    slot1.ID = self.viewModel.slotID;
    slot1.AdType = BUAdSlotAdTypeFeed;
    BUSize *imgSize = [BUSize sizeBy:BUProposalSize_Feed228_150];
    slot1.imgSize = imgSize;
    slot1.position = BUAdSlotPositionFeed;
    slot1.isSupportDeepLink = YES;
    
    // self.nativeExpressAdManager可以重用
    if (!self.nativeExpressAdManager) {
        self.nativeExpressAdManager = [[BUNativeExpressAdManager alloc] initWithSlot:slot1 adSize:CGSizeMake(self.widthSlider.value, self.heightSlider.value)];
    }
    self.nativeExpressAdManager.adSize = CGSizeMake(self.widthSlider.value, self.heightSlider.value);
    self.nativeExpressAdManager.delegate = self;
    NSInteger count = (NSInteger)self.adCountSlider.value;
    [self.nativeExpressAdManager loadAd:count];
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
        [views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BUNativeExpressAdView *expressView = (BUNativeExpressAdView *)obj;
            expressView.rootViewController = self;
            // important: 此处会进行WKWebview的渲染，建议一次最多预加载三个广告，如果超过3个会很大概率导致WKWebview渲染失败。
            [expressView render];
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
//    NSLog(@"====== %p playerState = %ld",nativeExpressAdView,(long)playerState);
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
    NSString *str = nil;
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
    if (indexPath.row % 2 == 0) {
        UIView *view = [self.expressAdViews objectAtIndex:indexPath.row / 2];
        return view.bounds.size.height;
    }
    else {
        return 44;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.expressAdViews.count * 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.row % 2 == 0) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"BUDNativeExpressCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 重用BUNativeExpressAdView，先把之前的广告试图取下来，再添加上当前视图
        UIView *subView = (UIView *)[cell.contentView viewWithTag:1000];
        if ([subView superview]) {
            [subView removeFromSuperview];
        }
        
        UIView *view = [self.expressAdViews objectAtIndex:indexPath.row / 2];
        view.tag = 1000;
        [cell.contentView addSubview:view];
    } else {
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"BUDSplitNativeExpressCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

- (void) addAccessibilityIdentifier {
    self.widthSlider.accessibilityIdentifier = @"expressFeed_width";
    self.heightSlider.accessibilityIdentifier = @"expressFeed_height";
    self.adCountSlider.accessibilityIdentifier = @"expressFeed_count";
}

@end