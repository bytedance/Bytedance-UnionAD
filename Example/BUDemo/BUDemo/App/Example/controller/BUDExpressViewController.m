//
//  BUDExpressViewController.m
//  BUADDemo
//
//  Created by xxx on 2019/5/15.
//  Copyright © 2019 Bytedance. All rights reserved.
//

#import "BUDExpressViewController.h"
#import "BUDActionCellView.h"
#import "BUDSlotViewModel.h"
#import "BUDMacros.h"
#import "BUDExpressFeedViewController.h"
#import "BUDExpressBannerViewController.h"
#import "BUDExpressInterstitialViewController.h"

@interface BUDExpressViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<BUDActionModel *> *items;

@end

@implementation BUDExpressViewController

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    BUDActionModel *feedCellItem = [BUDActionModel plainTitleActionModel:@"Express Feed" type:BUDCellType_native action:^{
        __strong typeof(self) strongSelf = weakSelf;
        BUDExpressFeedViewController *vc = [BUDExpressFeedViewController new];
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *slotId =  [defaults objectForKey:@"native_express_slot_id"];
        viewModel.slotID = slotId;
        vc.viewModel = viewModel;
        [strongSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *bannerCellItem = [BUDActionModel plainTitleActionModel:@"Express Banner" type:BUDCellType_native action:^{
        __strong typeof(self) strongSelf = weakSelf;
        BUDExpressBannerViewController *vc = [BUDExpressBannerViewController new];
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
        viewModel.slotID = @"900546269";
        vc.viewModel = viewModel;
        [strongSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *interCellItem = [BUDActionModel plainTitleActionModel:@"Express Interstitial" type:BUDCellType_native action:^{
        __strong typeof(self) strongSelf = weakSelf;
        BUDExpressInterstitialViewController *vc = [BUDExpressInterstitialViewController new];
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
        viewModel.slotID = @"900546270";
        vc.viewModel = viewModel;
        [strongSelf.navigationController pushViewController:vc animated:YES];
    }];
    self.items = @[feedCellItem,bannerCellItem,interCellItem].mutableCopy;
    
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



@end
