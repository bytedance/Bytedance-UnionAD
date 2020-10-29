//
//  BUDToolsSettingViewController.m
//  BUADDemo
//
//  Created by Bytedance on 2019/7/22.
//  Copyright © 2019 Bytedance. All rights reserved.
//

#import "BUDToolsSettingViewController.h"
#import "BUDActionCellView.h"
#import "BUDSettingTableView.h"
#import "BUDSettingViewController.h"
#import "BUDPlayableToolViewController.h"
#import "BUDSlotViewModel.h"
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import "BUDTestToolsViewController.h"
#import "BUDCoppaViewController.h"

@interface BUDToolsSettingViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) BUDSettingTableView *tableView;
@property (nonatomic, strong) NSMutableArray<BUDActionModel *> *items;
@end

@implementation BUDToolsSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.items = [NSMutableArray array];
    [self buildUpChildView];
    [self buildItemsData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}

- (void)buildUpChildView {
    [self.view addSubview:self.tableView];
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[BUDSettingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        Class plainActionCellClass = [BUDActionCellView class];
        [_tableView registerClass:plainActionCellClass forCellReuseIdentifier:NSStringFromClass(plainActionCellClass)];
    }
    return _tableView;
}

- (void)buildItemsData {
    __weak typeof(self) weaksefl = self;
    BUDActionModel *normalTools = [BUDActionModel plainTitleActionModel:@"Normal Tools" type:BUDCellType_setting action:^{
        BUDSettingViewController *vc = [BUDSettingViewController new];
        vc.view.backgroundColor = [UIColor whiteColor];
        [weaksefl.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *playableTools = [BUDActionModel plainTitleActionModel:@"Playable Tool" type:BUDCellType_setting action:^{
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
        viewModel.slotID = normal_reward_ID;
        BUDPlayableToolViewController *vc = [BUDPlayableToolViewController new];
        vc.viewModel = viewModel;
        vc.view.backgroundColor = [UIColor whiteColor];
        [weaksefl.navigationController pushViewController:vc animated:YES];
    }];
    BUDActionModel *testTools = [BUDActionModel plainTitleActionModel:@"Test Tool" type:BUDCellType_setting action:^{
        BUDTestToolsViewController *vc = [BUDTestToolsViewController new];
        vc.view.backgroundColor = [UIColor whiteColor];
        [weaksefl.navigationController pushViewController:vc animated:YES];
    }];
    BUDActionModel *coppaTools = [BUDActionModel plainTitleActionModel:@"Coppa && GDPR Tool" type:BUDCellType_setting action:^{
        BUDCoppaViewController *vc = [[BUDCoppaViewController alloc] initWithNibName:@"BUDCoppaViewController" bundle:[NSBundle mainBundle]];
        vc.view.backgroundColor = [UIColor whiteColor];
        [weaksefl.navigationController pushViewController:vc animated:YES];
    }];
    
    self.items = @[normalTools,
                   playableTools,
                   testTools,
                   coppaTools
                    ].mutableCopy;
}

-(BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BUDActionModel *model = self.items[indexPath.row];
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
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:NO];
}

@end
