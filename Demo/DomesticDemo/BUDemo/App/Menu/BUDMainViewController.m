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
#import "BUDInterstitialAdListViewController.h"
#import "BUDSplashAdListViewController.h"
#import "BUDFullScreenVideoAdListViewController.h"
#import "BUDRewardedAdListViewController.h"

@interface BUDMainViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSMutableArray *> *items;
@end

@implementation BUDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.viewModel.custormNavigation) {
        self.navigationController.navigationBarHidden = YES;
    }
    
    self.title = @"BytedanceUnion Demo";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    Class plainActionCellClass = [BUDActionCellView class];
    [self.tableView registerClass:plainActionCellClass forCellReuseIdentifier:NSStringFromClass(plainActionCellClass)];

    __weak typeof(self) weakSelf = self;
    BUDActionModel *feedAdVc = [BUDActionModel plainTitleActionModel:@"Feed Ad" type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[BUDFeedAdListViewController alloc] init] sender:nil];
    }];
    BUDActionModel *drawAdVc = [BUDActionModel plainTitleActionModel:@"Draw Ad" type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[BUDDrawAdListViewController alloc] init] sender:nil];
    }];
    BUDActionModel *bannerAdVc = [BUDActionModel plainTitleActionModel:@"Banner Ad" type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[BUDBannerAdListViewController alloc] init] sender:nil];
    }];
    BUDActionModel *interstitialAdVc = [BUDActionModel plainTitleActionModel:@"Interstitial Ad" type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[BUDInterstitialAdListViewController alloc] init] sender:nil];
    }];
    BUDActionModel *splashAdVc = [BUDActionModel plainTitleActionModel:@"Splash Ad" type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[BUDSplashAdListViewController alloc] init] sender:nil];
    }];
    BUDActionModel *rewardedAdVc = [BUDActionModel plainTitleActionModel:@"Rewarded Ad" type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[BUDRewardedAdListViewController alloc] init] sender:nil];
    }];
    BUDActionModel *fullScreenVideoAdVc = [BUDActionModel plainTitleActionModel:@"FullScreenVideo Ad" type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[BUDFullScreenVideoAdListViewController alloc] init] sender:nil];
    }];
    
    BUDActionModel *waterfallItem = [BUDActionModel plainTitleActionModel:@"Waterfall Ad" type:BUDCellType_video action:^{
        BUDWaterfallViewController *vc = [BUDWaterfallViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *adapterItem = [BUDActionModel plainTitleActionModel:@"CustomEventAdapter" type:BUDCellType_CustomEvent action:^{
        BUDCustomEventViewController *vc = [BUDCustomEventViewController new];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *toolsItem = [BUDActionModel plainTitleActionModel:@"Tools" type:BUDCellType_setting action:^{
        BUDToolsSettingViewController *vc = [BUDToolsSettingViewController new];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];

    self.items = @[
            @[feedAdVc, drawAdVc, bannerAdVc, interstitialAdVc, splashAdVc, rewardedAdVc, fullScreenVideoAdVc],
            @[waterfallItem],
            @[adapterItem],
            @[toolsItem]
    ];

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

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBarTintColor:nil];
    [self.navigationController.navigationBar setTintColor:nil];
    [self.navigationController.navigationBar setTitleTextAttributes:nil];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:NO];
    
    [self.navigationController.navigationBar setBarTintColor:titleBGColor];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
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
