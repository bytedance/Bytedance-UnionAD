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
#import "BUDExpressViewController.h"
#import "BUDToolsSettingViewController.h"
#import "BUDMacros.h"
#import "BUDSlotID.h"
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
    
    Class plainActionCellClass = [BUDActionCellView class];
    [self.tableView registerClass:plainActionCellClass forCellReuseIdentifier:NSStringFromClass(plainActionCellClass)];
    
    BUDActionModel *settingVC = [BUDActionModel plainTitleActionModel:@"Native Ad" type:BUDCellType_native action:^{
        BUNativeSettingViewController *vc = [[BUNativeSettingViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *nativeExpressModel = [BUDActionModel plainTitleActionModel:@"Express Ad" type:BUDCellType_native action:^{
        BUDExpressViewController *vc = [[BUDExpressViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *item4 = [BUDActionModel plainTitleActionModel:@"Normal Banner" type:BUDCellType_normal action:^{
        BUDBannerViewController *vc = [BUDBannerViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *item6 = [BUDActionModel plainTitleActionModel:@"Normal Interstitial" type:BUDCellType_normal action:^{
        BUDInterstitialViewController *vc = [BUDInterstitialViewController new];
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
        viewModel.slotID = normal_interstitial_ID;  
        vc.viewModel = viewModel;
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *item7 = [BUDActionModel plainTitleActionModel:@"Normal Splash" type:BUDCellType_normal action:^{
        BUDSplashViewController *vc = [BUDSplashViewController new];
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
        viewModel.slotID = normal_splash_ID;
        vc.viewModel = viewModel;
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *fullscreenItem = [BUDActionModel plainTitleActionModel:@"Normal FullScreenVideo" type:BUDCellType_video action:^{
        BUDFullscreenViewController *vc = [BUDFullscreenViewController new];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *item10 = [BUDActionModel plainTitleActionModel:@"Normal RewardVideo" type:BUDCellType_video action:^{
        BUDRewardedVideoAdViewController *vc = [BUDRewardedVideoAdViewController new];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *item12 = [BUDActionModel plainTitleActionModel:@"CustomEventAdapter" type:BUDCellType_CustomEvent action:^{
        BUDCustomEventViewController *vc = [BUDCustomEventViewController new];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *item8 = [BUDActionModel plainTitleActionModel:@"Tools" type:BUDCellType_setting action:^{
        BUDToolsSettingViewController *vc = [BUDToolsSettingViewController new];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    self.items = @[@[settingVC, nativeExpressModel], @[item4, item6, item7], @[fullscreenItem,item10], @[item12], @[item8]];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
