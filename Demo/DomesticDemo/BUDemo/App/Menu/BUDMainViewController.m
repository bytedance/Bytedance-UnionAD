//
//  MainViewController.m
//  BUDemo
//
//  Created by jiacy on 2017/6/6.
//  Copyright © 2017年 chenren. All rights reserved.
//

#import "BUDMainViewController.h"
#import "BUDActionCellDefine.h"
#import "BUDActionCellView.h"
#import "BUDFeedViewController.h"
#import "BUDCustomEventViewController.h"
#import "BUDToolsSettingViewController.h"
#import "BUDMacros.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDWaterfallViewController.h"
#import "BUDFeedAdListViewController.h"
#import "BUDDrawAdListViewController.h"
#import "BUDBannerAdListViewController.h"
#import "BUDSplashAdListViewController.h"
#import "BUDFullScreenVideoAdListViewController.h"
#import "BUDRewardedAdListViewController.h"
#import "BUDStreamAdListViewController.h"
#import "BUDSlotABViewController.h"
#if TARGET==1
#import "BUDUGenoDemoViewController.h"
#endif

#import "BUDAdManager.h"

#if __has_include(<BUWebAd/BUWebAd.h>)
#import "BUDWebViewController.h"
#endif

#import "NSString+LocalizedString.h"
@interface BUDMainViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NSArray *> *items;
@end

@implementation BUDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.items = [NSMutableArray array];
    
    if (self.viewModel.custormNavigation) {
        self.navigationController.navigationBarHidden = YES;
    }
    
    [self.navigationController.navigationBar setBarTintColor:titleBGColor];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.title = @"BytedanceUnion Demo";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    Class plainActionCellClass = [BUDActionCellView class];
    [self.tableView registerClass:plainActionCellClass forCellReuseIdentifier:NSStringFromClass(plainActionCellClass)];

    __weak typeof(self) weakSelf = self;
    BUDActionModel *feedAdVc = [BUDActionModel plainTitleActionModel:[NSString localizedStringForKey:kFeedAd] type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[BUDFeedAdListViewController alloc] init] sender:nil];
    }];
    BUDActionModel *drawAdVc = [BUDActionModel plainTitleActionModel:[NSString localizedStringForKey:kDrawAd] type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[BUDDrawAdListViewController alloc] init] sender:nil];
    }];
    BUDActionModel *bannerAdVc = [BUDActionModel plainTitleActionModel:[NSString localizedStringForKey:kBannerAd] type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[BUDBannerAdListViewController alloc] init] sender:nil];
    }];
    BUDActionModel *splashAdVc = [BUDActionModel plainTitleActionModel:[NSString localizedStringForKey:kSplashAd] type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[BUDSplashAdListViewController alloc] init] sender:nil];
    }];
    BUDActionModel *rewardedAdVc = [BUDActionModel plainTitleActionModel:[NSString localizedStringForKey:kRewardedAd] type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[BUDRewardedAdListViewController alloc] init] sender:nil];
    }];
    BUDActionModel *fullScreenVideoAdVc = [BUDActionModel plainTitleActionModel:[NSString localizedStringForKey:kFullscreenAd] type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[BUDFullScreenVideoAdListViewController alloc] init] sender:nil];
    }];
    
    BUDActionModel *streamAdVc = [BUDActionModel plainTitleActionModel:[NSString localizedStringForKey:kStreamAd] type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[BUDStreamAdListViewController alloc] init] sender:nil];
    }];
    
    BUDActionModel *waterfallItem = [BUDActionModel plainTitleActionModel:[NSString localizedStringForKey:kWaterfallAd] type:BUDCellType_video action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDWaterfallViewController *vc = [BUDWaterfallViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *adapterItem = [BUDActionModel plainTitleActionModel:@"CustomEventAdapter" type:BUDCellType_CustomEvent action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDCustomEventViewController *vc = [BUDCustomEventViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }];

#if TARGET==1
    BUDActionModel *ugenoItem = [BUDActionModel plainTitleActionModel:@"UGenoDemo" type:BUDCellType_CustomEvent action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDUGenoDemoViewController *vc = [BUDUGenoDemoViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
#endif
    
    BUDActionModel *slotABItem = [BUDActionModel plainTitleActionModel:@"Slot AB" type:BUDCellType_CustomEvent action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDSlotABViewController *vc = [BUDSlotABViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }];

#if __has_include(<BUWebAd/BUWebAd.h>)
    BUDActionModel *webAdItem = [BUDActionModel plainTitleActionModel:@"WebAd" type:BUDCellType_CustomEvent action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDWebViewController *vc = [[BUDWebViewController alloc] init];
        vc.url = @"https://sf3-fe-tos.pglstatp-toutiao.com/obj/ad-pattern/union-native-components/examples/native-ad-ios.html";
        [self.navigationController pushViewController:vc animated:YES];
    }];
#endif
    
    BUDActionModel *toolsItem = [BUDActionModel plainTitleActionModel:@"Tools" type:BUDCellType_setting action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDToolsSettingViewController *vc = [BUDToolsSettingViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }];

    NSArray *normalItems = @[
        @[feedAdVc, drawAdVc, bannerAdVc, splashAdVc, rewardedAdVc, fullScreenVideoAdVc, streamAdVc],
        @[waterfallItem, slotABItem],
        @[adapterItem]];
    
    [self.items addObjectsFromArray:normalItems];
    
#if __has_include(<BUWebAd/BUWebAd.h>)
    [self.items addObject:@[webAdItem]];
#endif
    
#if TARGET==1
    [self.items addObject:@[ugenoItem]];
#endif
    
    [self.items addObject:@[toolsItem]];

    CGFloat height = 22 * self.items.count;
    for (NSArray *subItem in self.items) {
        height += 44 * subItem.count;
    }
    height += 30;
    UILabel *versionLable = [[UILabel alloc]initWithFrame:CGRectMake(0, height, self.tableView.frame.size.width, 40)];
    versionLable.textAlignment = NSTextAlignmentCenter;
    versionLable.text = [NSString stringWithFormat:@"v%@",[BUAdSDKManager SDKVersion]];
    versionLable.textColor = [UIColor grayColor];
    [self.tableView addSubview:versionLable];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 清除自定义dislike标识
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:NO forKey:@"kCustomDislikeIsOn"];
    [userDefaults synchronize];
}

-(BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll; // Avoid some situations where it's just landscape
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionItems = self.items[section];
    return sectionItems.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 22;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *sectionItems = self.items[indexPath.section];
    BUDActionModel *model = sectionItems[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BUDActionCellView" forIndexPath:indexPath];
    if ([cell conformsToProtocol:@protocol(BUDActionCellConfig)]) {
        [(id<BUDActionCellConfig>)cell configWithModel:model];
    } else {
        cell = [UITableViewCell new];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell<BUDCommandProtocol> *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell conformsToProtocol:@protocol(BUDCommandProtocol)]) {
        [cell execute];
    }
}
@end
