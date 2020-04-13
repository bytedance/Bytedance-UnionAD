//
//  BUDMopubCustomEventViewController.m
//  BUDemo
//
//  Created by Bytedance on 2019/11/26.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDMopubCustomEventViewController.h"
#import "BUDActionCellView.h"
#import "BUDSlotViewModel.h"
#import "BUDMacros.h"
#import "BUDMopub_BannerCusEventVC.h"
#import "BUDMopub_FullScreenVideoCusEventVC.h"
#import "BUDMopub_InterstitialCusEventVC.h"
#import "BUDMopub_RewardVideoCusEventVC.h"
#import "BUDMopub_ExpressBannerCusEventVC.h"
#import "BUDMopub_ExpressFullScreenVideoCusEventVC.h"
#import "BUDMopub_ExpressInterstitialCusEventVC.h"
#import "BUDMopub_ExpressRewardVideoCusEventVC.h"
#import "BUDMopub_NativeAdCusEventVC.h"

@interface BUDMopubCustomEventViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSMutableArray *> *items;
@end

@implementation BUDMopubCustomEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.items = [NSMutableArray array];
    [self buildUpChildView];
    [self buildItemsData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:NO];
}

- (void)buildItemsData {
    __weak typeof(self) weakSelf = self;
    BUDActionModel *RewardVideo_Item = [BUDActionModel plainTitleActionModel:@"Normal RewardVideo" type:BUDCellType_CustomEvent action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDMopub_RewardVideoCusEventVC *vc = [BUDMopub_RewardVideoCusEventVC new];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *FullScreenVideo_Item = [BUDActionModel plainTitleActionModel:@"Normal FullScreenVideo" type:BUDCellType_CustomEvent action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDMopub_FullScreenVideoCusEventVC *vc = [BUDMopub_FullScreenVideoCusEventVC new];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *Banner_Item = [BUDActionModel plainTitleActionModel:@"Normal Banner" type:BUDCellType_CustomEvent action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDMopub_BannerCusEventVC *vc = [BUDMopub_BannerCusEventVC new];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *Interstitial_Item = [BUDActionModel plainTitleActionModel:@"Normal Interstitial" type:BUDCellType_CustomEvent action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDMopub_InterstitialCusEventVC *vc = [BUDMopub_InterstitialCusEventVC new];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *Express_RewardVideo_Item = [BUDActionModel plainTitleActionModel:@"Express RewardVideo" type:BUDCellType_CustomEvent action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDMopub_ExpressRewardVideoCusEventVC *vc = [BUDMopub_ExpressRewardVideoCusEventVC new];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *Express_FullScreenVideo_Item = [BUDActionModel plainTitleActionModel:@"Express FullScreenVideo" type:BUDCellType_CustomEvent action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDMopub_ExpressFullScreenVideoCusEventVC *vc = [BUDMopub_ExpressFullScreenVideoCusEventVC new];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *Express_Banner_Item = [BUDActionModel plainTitleActionModel:@"Express Banner" type:BUDCellType_CustomEvent action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDMopub_ExpressBannerCusEventVC *vc = [BUDMopub_ExpressBannerCusEventVC new];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *Express_Interstitial_Item = [BUDActionModel plainTitleActionModel:@"Express Interstitial" type:BUDCellType_CustomEvent action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDMopub_ExpressInterstitialCusEventVC *vc = [BUDMopub_ExpressInterstitialCusEventVC new];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *native_feed_Item = [BUDActionModel plainTitleActionModel:@"Native Feed" type:BUDCellType_CustomEvent action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDMopub_NativeAdCusEventVC *vc = [BUDMopub_NativeAdCusEventVC new];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    self.items = @[@[RewardVideo_Item, FullScreenVideo_Item,Banner_Item, Interstitial_Item],@[Express_RewardVideo_Item, Express_FullScreenVideo_Item,Express_Banner_Item, Express_Interstitial_Item],@[native_feed_Item]].mutableCopy;
}

- (void)buildUpChildView {
    [self.view addSubview:self.tableView];
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        Class plainActionCellClass = [BUDActionCellView class];
        [_tableView registerClass:plainActionCellClass forCellReuseIdentifier:NSStringFromClass(plainActionCellClass)];
    }
    return _tableView;
}

#pragma mark - rotate
-(BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionItems = self.items[section];
    return sectionItems.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *sectionItems = self.items[indexPath.section];
    BUDActionModel *model = sectionItems[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BUDActionCellView" forIndexPath:indexPath];
    if ([cell conformsToProtocol:@protocol(BUDActionCellConfig)]) {
        [(id<BUDActionCellConfig>)cell configWithModel:model];
    } else {
        cell = [[UITableViewCell alloc] init];;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell<BUDCommandProtocol> *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell conformsToProtocol:@protocol(BUDCommandProtocol)]) {
        [cell execute];
    }
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

@end
