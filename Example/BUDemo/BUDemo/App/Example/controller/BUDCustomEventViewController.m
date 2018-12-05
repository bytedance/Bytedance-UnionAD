//
//  BUDCustomEventViewController.m
//  BUADDemo
//
//  Created by bytedance_yuanhuan on 2018/11/21.
//  Copyright © 2018年 Bytedance. All rights reserved.
//

#import "BUDCustomEventViewController.h"
#import "BUDActionCellView.h"
#import "BUDAdmob_RewardVideoCusEventVC.h"
#import "BUDMopub_BannerViewController.h"
#import "BUDMopub_FullScreenVideoCusEventVC.h"
#import "BUDMopub_InterstitialViewController.h"
#import "BUDMopub_RewardVideoCusEventVC.h"

@interface BUDCustomEventViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSMutableArray *> *items;
@end

@implementation BUDCustomEventViewController

- (void)dealloc {
    NSLog(@"CustomEvent - dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.items = [NSMutableArray array];

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    Class plainActionCellClass = [BUDActionCellView class];
    [self.tableView registerClass:plainActionCellClass forCellReuseIdentifier:NSStringFromClass(plainActionCellClass)];
    [self.view addSubview:self.tableView];
    
    [self buildItemsData];

}

- (void)buildItemsData {
    __weak typeof(self) weakSelf = self;
    BUDActionModel *Mopub_RewardVideo_Item = [BUDActionModel plainTitleActionModel:@"Mopub RewardVideo" type:BUDCellType_CustomEvent action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDMopub_RewardVideoCusEventVC *vc = [BUDMopub_RewardVideoCusEventVC new];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *Mopub_Banner_Item = [BUDActionModel plainTitleActionModel:@"Mopub Banner" type:BUDCellType_CustomEvent action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDMopub_BannerViewController *vc = [BUDMopub_BannerViewController new];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *Mopub_Interstitial_Item = [BUDActionModel plainTitleActionModel:@"Mopub Interstitial" type:BUDCellType_CustomEvent action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDMopub_InterstitialViewController *vc = [BUDMopub_InterstitialViewController new];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *Mopub_FullScreenVideo_Item = [BUDActionModel plainTitleActionModel:@"Mopub FullScreenVideo" type:BUDCellType_CustomEvent action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDMopub_FullScreenVideoCusEventVC *vc = [BUDMopub_FullScreenVideoCusEventVC new];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *Admob_RewardVideo_Item = [BUDActionModel plainTitleActionModel:@"Admob RewardVideo" type:BUDCellType_CustomEvent action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDAdmob_RewardVideoCusEventVC *vc = [BUDAdmob_RewardVideoCusEventVC new];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    self.items = @[@[Mopub_RewardVideo_Item, Mopub_Banner_Item, Mopub_Interstitial_Item, Mopub_FullScreenVideo_Item],
                   @[Admob_RewardVideo_Item]];
}

#pragma mark - UITableViewDataSource
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionItems = self.items[section];
    return sectionItems.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.items.count;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell<BUDCommandProtocol> *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell conformsToProtocol:@protocol(BUDCommandProtocol)]) {
        [cell execute];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:NO];
}

#pragma mark - Orientations
-(BOOL)shouldAutorotate
{
    return YES;
}

// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll; // 避免有些只有横屏情况
}
@end
