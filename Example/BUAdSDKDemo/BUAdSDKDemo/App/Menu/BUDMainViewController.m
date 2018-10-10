//
//  MainViewController.m
//  BUDemo
//
//  Created by jiacy on 2017/6/6.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import "BUDMainViewController.h"

#import "BUDActionCellDefine.h"
#import "BUDActionCellView.h"
#import "BUDBannerViewController.h"
#import "BUDFeedViewController.h"
#import "BUDInterstitialViewController.h"
#import "BUDNativeViewController.h"
#import "BUDSplashViewController.h"
#import "BUDSlotViewModel.h"
#import "BUDRewardedVideoAdViewController.h"
#import "BUDRewardVideoCusEventVC.h"
#import "BUDNativeBannerViewController.h"
#import "BUDNativeInterstitialViewController.h"
#import "BUDFullscreenViewController.h"
#import "BUDDrawVideoViewController.h"

@interface BUDMainViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<BUDActionModel *> *items;
@end

@implementation BUDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Menu";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    Class plainActionCellClass = [BUDActionCellView class];
    [self.tableView registerClass:plainActionCellClass forCellReuseIdentifier:NSStringFromClass(plainActionCellClass)];
    
    BUDActionModel *item1 = [BUDActionModel plainTitleActionModel:@"Feed" action:^{
        BUDFeedViewController *vc = [BUDFeedViewController new];
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
        viewModel.slotID = @"900546238";
        vc.viewModel = viewModel;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    __weak typeof(self) weakSelf = self;
    BUDActionModel *item2 = [BUDActionModel plainTitleActionModel:@"Native Draw Feed" action:^{
        __strong typeof(self) strongSelf = weakSelf;
        BUDDrawVideoViewController *vc = [BUDDrawVideoViewController new];
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
        viewModel.slotID = @"900546910";
        vc.viewModel = viewModel;
        [strongSelf presentViewController:vc animated:YES completion:nil];
    }];

    BUDActionModel *item3 = [BUDActionModel plainTitleActionModel:@"Native" action:^{
        BUDNativeViewController *vc = [BUDNativeViewController new];
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
        viewModel.slotID = @"900546910";
        vc.viewModel = viewModel;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *itemNativeBanner = [BUDActionModel plainTitleActionModel:@"Native Banner" action:^{
        BUDNativeBannerViewController *vc = [BUDNativeBannerViewController new];
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
        viewModel.slotID = @"900546687";
        vc.viewModel = viewModel;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *itemNativeInterstitial = [BUDActionModel plainTitleActionModel:@"Native Interstitial" action:^{
        BUDNativeInterstitialViewController *vc = [BUDNativeInterstitialViewController new];
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
        viewModel.slotID = @"900546829";
        vc.viewModel = viewModel;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *fullscreenItem = [BUDActionModel plainTitleActionModel:@"全屏视频" action:^{
        BUDFullscreenViewController *vc = [BUDFullscreenViewController new];
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
        viewModel.slotID = @"900546910";
        vc.viewModel = viewModel;
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *item4 = [BUDActionModel plainTitleActionModel:@"Banner" action:^{
        BUDBannerViewController *vc = [BUDBannerViewController new];
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
        viewModel.slotID = @"900546859";
        vc.viewModel = viewModel;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *item5 = [BUDActionModel plainTitleActionModel:@"插屏广告" action:^{
        BUDInterstitialViewController *vc = [BUDInterstitialViewController new];
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
        viewModel.slotID = @"900546957";
        vc.viewModel = viewModel;
        vc.view.backgroundColor = [UIColor whiteColor];
        
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *item6 = [BUDActionModel plainTitleActionModel:@"开屏广告" action:^{
        BUDSplashViewController *vc = [BUDSplashViewController new];
        vc.view.backgroundColor = [UIColor whiteColor];
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
        viewModel.slotID = @"800546808";
        vc.viewModel = viewModel;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *item7 = [BUDActionModel plainTitleActionModel:@"激励视频" action:^{
        BUDRewardedVideoAdViewController *vc = [BUDRewardedVideoAdViewController new];
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
        viewModel.slotID = @"900546421";
        vc.viewModel = viewModel;
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];

    BUDActionModel *item8 = [BUDActionModel plainTitleActionModel:@"激励视频（CustomEventAdapter）" action:^{
        BUDRewardVideoCusEventVC *vc = [BUDRewardVideoCusEventVC new];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    self.items = @[item1, item2, itemNativeBanner, itemNativeInterstitial, fullscreenItem, item3, item4, item5, item6, item7,item8];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - tableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.items.count) {
        return [UITableViewCell new];
    }
    BUDActionModel *model = self.items[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BUDActionCellView" forIndexPath:indexPath];
    if ([cell conformsToProtocol:@protocol(BUDActionCellConfig)]) {
        [(id<BUDActionCellConfig>)cell configWithModel:model];
    } else {
        cell = [UITableViewCell new];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.items.count) {
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UITableViewCell<BUDCommandProtocol> *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell conformsToProtocol:@protocol(BUDCommandProtocol)]) {
        [cell execute];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
