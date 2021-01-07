//
//  BUDWaterfallViewController.m
//  BUDemo
//
//  Created by wangyanlin on 2020/4/12.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDWaterfallViewController.h"
#import <BUAdSDK/BUNativeExpressAdManager.h>
#import <BUAdSDK/BUNativeExpressAdView.h>
#import "BUDMacros.h"
#import "BUDNormalButton.h"
#import "UIView+Draw.h"
#import "NSString+LocalizedString.h"

NSString *const BU_AdCachePath = @"adCachePath.data";
NSString *const BU_adloadSeqKey = @"bu_adloadSeqKey";
NSString *const BU_adloadSeqTimestamp = @"bu_adloadSeqTimestamp";

@interface BUDWaterfallViewController () <BUNativeExpressAdViewDelegate, UITableViewDelegate, UITableViewDataSource>
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
//waterfall slotIds
@property (strong, nonatomic) NSArray <NSString *>*slotIds;

@property (strong, nonatomic) NSMutableDictionary *adInfo;
@property (assign, nonatomic) NSInteger currentIndex;
@end

@implementation BUDWaterfallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.slotIds = @[@"945135101",@"945135136",@"945113159"];
    self.expressAdViews = [NSMutableArray new];
    [self setupViews];
    [self readLocalData];
    if (!self.adInfo) {
        self.adInfo = [[NSMutableDictionary alloc] init];
    }
    [self updateAdLoadTimes];
    [self loadData];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self updateLocalData];
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
    [self.freshButton addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventTouchUpInside];
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
    if (self.currentIndex > 2) {
        return;
    }
    slot1.ID = self.slotIds[self.currentIndex];
    slot1.AdType = BUAdSlotAdTypeFeed;
    BUSize *imgSize = [BUSize sizeBy:BUProposalSize_Feed228_150];
    slot1.imgSize = imgSize;
    slot1.position = BUAdSlotPositionFeed;
    slot1.adloadSeq = [[self.adInfo objectForKey:BU_adloadSeqKey] integerValue];
    slot1.primeRit =  self.slotIds.firstObject;
    
    self.nativeExpressAdManager = [[BUNativeExpressAdManager alloc] initWithSlot:slot1 adSize:CGSizeMake(self.widthSlider.value, self.heightSlider.value)];
    self.nativeExpressAdManager.delegate = self;
    NSInteger count = (NSInteger)self.adCountSlider.value;
    [self.nativeExpressAdManager loadAdDataWithCount:count];
}

- (void)updateAdLoadTimes{
    NSInteger adloadSeq = [[self.adInfo objectForKey:BU_adloadSeqKey] integerValue];
    
    NSInteger timestamp = [[self.adInfo objectForKey:BU_adloadSeqTimestamp] integerValue];
    if (!timestamp) {
        [self.adInfo setObject:@(1) forKey:BU_adloadSeqKey];
    }else{
        if (timestamp > [self zeroOfToday]) {
            NSInteger adloadSeqNum = adloadSeq;
            [self.adInfo setObject:@(adloadSeqNum + 1) forKey:BU_adloadSeqKey];
        }else{
            [self.adInfo setObject:@(1) forKey:BU_adloadSeqKey];
        }
    }
    [self.adInfo setObject:@([self nowTimestemp]) forKey:BU_adloadSeqTimestamp];
    [self updateLocalData];
}

- (NSInteger)zeroOfToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
    NSDate *datetime = [calendar dateFromComponents:components];
    NSInteger timestamp = [datetime timeIntervalSince1970] * 1000;
    return timestamp;
}

- (NSInteger)nowTimestemp
{
    NSDate *datenow = [NSDate date];
    return (NSInteger)([datenow timeIntervalSince1970]*1000);
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

- (void)refreshData{
    self.currentIndex = 0;
    [self updateAdLoadTimes];
    [self loadData];
}

- (void)readLocalData{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:BU_AdCachePath];
    self.adInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

- (void)updateLocalData{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:BU_AdCachePath];
    // 归档
    [NSKeyedArchiver archiveRootObject:self.adInfo toFile:filePath];
}

#pragma mark - BUNativeExpressAdViewDelegate
- (void)nativeExpressAdSuccessToLoad:(BUNativeExpressAdManager *)nativeExpressAd views:(NSArray<__kindof BUNativeExpressAdView *> *)views {
    [self.expressAdViews removeAllObjects];//【重要】不能保存太多view，需要在合适的时机手动释放不用的，否则内存会过大
    if (views.count) {
        [self.expressAdViews addObjectsFromArray:views];
        [views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BUNativeExpressAdView *expressView = (BUNativeExpressAdView *)obj;
            expressView.rootViewController = self;
            [expressView render];
        }];
    }else{
        self.currentIndex ++;
        [self loadData];
    }
    [self.tableView reloadData];
    NSLog(@"【BytedanceUnion】个性化模板拉取广告成功回调");
}

- (void)nativeExpressAdFailToLoad:(BUNativeExpressAdManager *)nativeExpressAd error:(NSError *)error {
    BUD_Log(@"%s",__func__);
    NSLog(@"error code : %ld , error message : %@",(long)error.code,error.description);
    self.currentIndex ++;
    [self loadData];
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
    for (BUNativeExpressAdView *nativeExpressAdView in self.expressAdViews) {
        NSLog(@"====== %p currentPlayedTime = %f",nativeExpressAdView,nativeExpressAdView.currentPlayedTime);
    }
}

- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView stateDidChanged:(BUPlayerPlayState)playerState {
    NSLog(@"====== %p playerState = %ld", nativeExpressAdView, (long)playerState);
}

- (void)nativeExpressAdViewRenderFail:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *)error {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressAdViewWillShow:(BUNativeExpressAdView *)nativeExpressAdView {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressAdViewDidClick:(BUNativeExpressAdView *)nativeExpressAdView {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressAdViewPlayerDidPlayFinish:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *)error {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords {//【重要】需要在点击叉以后 在这个回调中移除视图，否则，会出现用户点击叉无效的情况
    [self.expressAdViews removeObject:nativeExpressAdView];

    NSUInteger index = [self.expressAdViews indexOfObject:nativeExpressAdView];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

}

- (void)nativeExpressAdViewDidClosed:(BUNativeExpressAdView *)nativeExpressAdView {
    BUD_Log(@"%s",__func__);
}

- (void)nativeExpressAdViewWillPresentScreen:(BUNativeExpressAdView *)nativeExpressAdView {
    BUD_Log(@"%s",__func__);
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
    BUD_Log(@"%s __ %@",__func__,str);
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.expressAdViews.count == 0) {
        return 44;
    }
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

@end


