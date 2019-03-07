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
#import "BUDBannerViewController.h"
#import "BUDFeedViewController.h"
#import "BUDInterstitialViewController.h"
#import "BUDNativeViewController.h"
#import "BUDSettingViewController.h"
#import "BUDSlotViewModel.h"
#import "BUDSplashViewController.h"
#import "BUDRewardedVideoAdViewController.h"
#import "BUDCustomEventViewController.h"
#import "BUDFullscreenViewController.h"
#import "BUNativeSettingViewController.h"
#import "BUDMacros.h"
#import <BUAdSDK/BUAdSDK.h>

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
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UILabel *versionLable = [[UILabel alloc]initWithFrame:CGRectMake(0, self.tableView.frame.size.height - 150, self.tableView.frame.size.width, 40)];
    versionLable.textAlignment = NSTextAlignmentCenter;
    versionLable.text = [NSString stringWithFormat:@"V%@",[BUAdSDKManager SDKVersion]];
    versionLable.textColor = [UIColor grayColor];
    [self.tableView addSubview:versionLable];
    
    Class plainActionCellClass = [BUDActionCellView class];
    [self.tableView registerClass:plainActionCellClass forCellReuseIdentifier:NSStringFromClass(plainActionCellClass)];
    
    BUDActionModel *settingVC = [BUDActionModel plainTitleActionModel:@"Native" type:BUDCellType_native action:^{
        BUNativeSettingViewController *vc = [[BUNativeSettingViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *item4 = [BUDActionModel plainTitleActionModel:@"Banner" type:BUDCellType_normal action:^{
        BUDBannerViewController *vc = [BUDBannerViewController new];
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *slotId =  [defaults objectForKey:@"banner_slot_id"];
        viewModel.slotID = slotId;
//        viewModel.slotID = @"900546859";  //应用下载
        vc.viewModel = viewModel;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *item6 = [BUDActionModel plainTitleActionModel:@"插屏广告" type:BUDCellType_normal action:^{
        BUDInterstitialViewController *vc = [BUDInterstitialViewController new];
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *slotId =  [defaults objectForKey:@"interstitial_slot_id"];
        viewModel.slotID = slotId;
//        viewModel.slotID = @"900546957";  //应用下载
        vc.viewModel = viewModel;
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *item7 = [BUDActionModel plainTitleActionModel:@"开屏广告" type:BUDCellType_normal action:^{
        BUDSplashViewController *vc = [BUDSplashViewController new];
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *slotId =  [defaults objectForKey:@"splash_slot_id"];
        viewModel.slotID = slotId;
//        viewModel.slotID = @"800546808";  //落地页
        vc.viewModel = viewModel;
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *fullscreenItem = [BUDActionModel plainTitleActionModel:@"全屏视频" type:BUDCellType_video action:^{
        BUDFullscreenViewController *vc = [BUDFullscreenViewController new];
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
        viewModel.slotID = @"900546299";
        vc.viewModel = viewModel;
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *item10 = [BUDActionModel plainTitleActionModel:@"激励视频" type:BUDCellType_video action:^{
        BUDRewardedVideoAdViewController *vc = [BUDRewardedVideoAdViewController new];
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
//        viewModel.slotID = @"900546311";  //应用下载
//        viewModel.slotID = @"900546421";  //访问对方服务器
//        viewModel.slotID = @"900546748";  //不访问对方服务器
        viewModel.slotID = @"900546826";    //访问对方服务器 在ETCD中删除了预览，请主动建立预览
        vc.viewModel = viewModel;
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *item12 = [BUDActionModel plainTitleActionModel:@"CustomEventAdapter" type:BUDCellType_CustomEvent action:^{
        BUDCustomEventViewController *vc = [BUDCustomEventViewController new];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *item8 = [BUDActionModel plainTitleActionModel:@"工具" type:BUDCellType_setting action:^{
        BUDSettingViewController *vc = [BUDSettingViewController new];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    self.items = @[@[settingVC], @[item4, item6, item7], @[fullscreenItem,item10], @[item12], @[item8]];
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

// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll; // 避免有些只有横屏情况
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
    return 0;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
