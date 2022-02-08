//
//  MainViewController.m
//  BUDemo
//
//  Created by jiacy on 2017/6/6.
//  Copyright © 2017年 chenren. All rights reserved.
//

#import "BUDMainViewController.h"
#import "BUDFeedViewController.h"
#import "BUDRewardedVideoAdViewController.h"
#import "BUDCustomEventViewController.h"
#import "BUDFullscreenViewController.h"
#import "BUDExpressBannerViewController.h"
#import <BUAdSDK/BUAdSDK.h>

@interface BUDMainViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray *> *items;
@end

@implementation BUDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"BytedanceUnion Demo";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    _items = @[
                @[
                    @{@"title":@"Native",@"class":@"BUDFeedViewController"},
                    @{@"title":@"Banner",@"class":@"BUDExpressBannerViewController"},
                ],
                @[
                    @{@"title":@"FullScreenVideo",@"class":@"BUDFullscreenViewController"},
                    @{@"title":@"RewardVideo",@"class":@"BUDRewardedVideoAdViewController"},
                    @{@"title":@"AppOpenAd",@"class":@"BUDAppOpenAdViewController"},
                ],
                @[
                    @{@"title":@"CustomEventAdapter",@"class":@"BUDCustomEventViewController"},
                ],
                @[
                    @{@"title":@"Pangle-Owned GDPR Consent Dialog",@"class":@""},
                ],
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:NO];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BUDActionCellView"];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (self.items.count > indexPath.section) {
        NSArray *sectionItems = self.items[indexPath.section];
        if (sectionItems.count > indexPath.row) {
            NSDictionary *info = sectionItems[indexPath.row];
            cell.textLabel.text = info[@"title"];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.items.count > indexPath.section) {
        NSArray *sectionItems = self.items[indexPath.section];
        if (sectionItems.count > indexPath.row) {
            NSDictionary *info = sectionItems[indexPath.row];
            NSString *className = info[@"class"];
            if (className.length > 0) {
                UIViewController *vc = [NSClassFromString(className) new];
                vc.view.backgroundColor = [UIColor whiteColor];
                [self.navigationController pushViewController:vc animated:YES];
            } else {
                [BUAdSDKManager openGDPRPrivacyFromRootViewController:self confirm:^(BOOL isAgreed) {
                    [BUAdSDKManager setGDPR:isAgreed?0:1];
                }];

                ///deselected tablecell
                [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
