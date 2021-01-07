//
// Created by bytedance on 2020/10/20.
// Copyright (c) 2020 bytedance. All rights reserved.
//

#import "BUDSplashAdListViewController.h"
#import "BUDActionCellView.h"
#import "BUDExpressSplashViewController.h"
#import "BUDSlotViewModel.h"
#import "BUDSlotID.h"
#import "BUDSplashViewController.h"


@implementation BUDSplashAdListViewController

- (NSArray<NSArray<BUDActionModel *> *> *)itemsForList {
    __weak typeof(self) weakSelf = self;
    BUDActionModel *normalCellItem = [BUDActionModel plainTitleActionModel:@"Normal Splash" type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDSplashViewController *vc = [[BUDSplashViewController alloc] init];
        BUDSlotViewModel *viewModel = [[BUDSlotViewModel alloc] init];
        viewModel.slotID = normal_splash_ID;
        vc.viewModel = viewModel;
        [self.navigationController pushViewController:vc animated:YES];
    }];

    BUDActionModel *expressCellItem = [BUDActionModel plainTitleActionModel:@"Express Splash" type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDExpressSplashViewController *vc = [[BUDExpressSplashViewController alloc] init];
        BUDSlotViewModel *viewModel = [[BUDSlotViewModel alloc] init];
        viewModel.slotID = express_splash_ID;
        vc.viewModel = viewModel;
        [self.navigationController pushViewController:vc animated:YES];
    }];

    return @[@[normalCellItem,expressCellItem]];
}

@end