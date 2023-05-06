//
//  BUDAdmobCustomEventViewController.m
//  BUDemo
//
//  Created by Bytedance on 2019/11/26.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDAdmobCustomEventViewController.h"
#import "BUDAdmob_RewardVideoCusEventVC.h"
#import "BUDAdmob_FeedNativeCusEventVC.h"
#import "BUDAdmob_FullScreenCusEventVC.h"
#import "BUDAdmob_BannerCusEventVC.h"

@interface BUDAdmobCustomEventViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray *> *items;

@end

@implementation BUDAdmobCustomEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Admob Adapter";
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
    _items = @[
                @[
                    @{@"title":@"RewardVideo",@"class":@"BUDAdmob_RewardVideoCusEventVC"},
                    @{@"title":@"FullScreenVideo",@"class":@"BUDAdmob_FullScreenCusEventVC"},
                ],
                @[
                    @{@"title":@"Native",@"class":@"BUDAdmob_FeedNativeCusEventVC"},
                    @{@"title":@"Banner",@"class":@"BUDAdmob_BannerCusEventVC"},
                ]
    ];
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
    }
    return _tableView;
}

#pragma mark - rotate
- (BOOL)shouldAutorotate {
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
            UIViewController *vc = [NSClassFromString(info[@"class"]) new];
            vc.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:vc animated:YES];
        }
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
