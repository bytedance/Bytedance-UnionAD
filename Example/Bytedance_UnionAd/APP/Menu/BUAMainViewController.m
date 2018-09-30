//
//  MainViewController.m
//  BUAemo
//
//  Created by jiacy on 2017/6/6.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import "BUAMainViewController.h"

#import "BUAActionCellDefine.h"
#import "BUAActionCellView.h"
#import "BUABannerViewController.h"
#import "BUAFeedViewController.h"
#import "BUAInterstitialViewController.h"
#import "BUANativeViewController.h"
#import "BUASplashViewController.h"
#import "BUASlotViewModel.h"
#import "BUARewardedVideoAdViewController.h"
#import "BUARewardVideoCusEventVC.h"

@interface BUAMainViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<BUAActionModel *> *items;
@end

@implementation BUAMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Menu";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    Class plainActionCellClass = [BUAActionCellView class];
    [self.tableView registerClass:plainActionCellClass forCellReuseIdentifier:NSStringFromClass(plainActionCellClass)];
    
    BUAActionModel *item1 = [BUAActionModel plainTitleActionModel:@"Feed" action:^{
        BUAFeedViewController *vc = [BUAFeedViewController new];
        BUASlotViewModel *viewModel = [BUASlotViewModel new];
        viewModel.slotID = @"900546238";
        vc.viewModel = viewModel;
        [self.navigationController pushViewController:vc animated:YES];
    }];

    BUAActionModel *item2 = [BUAActionModel plainTitleActionModel:@"Native" action:^{
        BUANativeViewController *vc = [BUANativeViewController new];
        BUASlotViewModel *viewModel = [BUASlotViewModel new];
        viewModel.slotID = @"900546238";
        vc.viewModel = viewModel;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUAActionModel *item3 = [BUAActionModel plainTitleActionModel:@"Banner" action:^{
        BUABannerViewController *vc = [BUABannerViewController new];
        BUASlotViewModel *viewModel = [BUASlotViewModel new];
        viewModel.slotID = @"900546859";
        vc.viewModel = viewModel;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUAActionModel *item4 = [BUAActionModel plainTitleActionModel:@"插屏广告" action:^{
        BUAInterstitialViewController *vc = [BUAInterstitialViewController new];
        BUASlotViewModel *viewModel = [BUASlotViewModel new];
        viewModel.slotID = @"900546957";
        vc.viewModel = viewModel;
        vc.view.backgroundColor = [UIColor whiteColor];
        
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUAActionModel *item5 = [BUAActionModel plainTitleActionModel:@"开屏广告" action:^{
        BUASplashViewController *vc = [BUASplashViewController new];
        vc.view.backgroundColor = [UIColor whiteColor];
        BUASlotViewModel *viewModel = [BUASlotViewModel new];
        viewModel.slotID = @"800546808";
        vc.viewModel = viewModel;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUAActionModel *item6 = [BUAActionModel plainTitleActionModel:@"激励视频" action:^{
        BUARewardedVideoAdViewController *vc = [BUARewardedVideoAdViewController new];
        BUASlotViewModel *viewModel = [BUASlotViewModel new];
        viewModel.slotID = @"900546421";
        vc.viewModel = viewModel;
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];

    BUAActionModel *item7 = [BUAActionModel plainTitleActionModel:@"激励视频（CustomEventAdapter）" action:^{
        BUARewardVideoCusEventVC *vc = [BUARewardVideoCusEventVC new];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    self.items = @[item1, item2, item3, item4, item5, item6, item7];
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
    BUAActionModel *model = self.items[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BUAActionCellView" forIndexPath:indexPath];
    if ([cell conformsToProtocol:@protocol(BUAActionCellConfig)]) {
        [(id<BUAActionCellConfig>)cell configWithModel:model];
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
    UITableViewCell<BUACommandProtocol> *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell conformsToProtocol:@protocol(BUACommandProtocol)]) {
        [cell execute];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
